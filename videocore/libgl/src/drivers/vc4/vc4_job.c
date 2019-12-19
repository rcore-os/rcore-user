
#include "vc4_drm.h"
#include "vc4_context.h"
#include <string.h>
#include <stdio.h>
#include <sys/ioctl.h>

void vc4_job_init(struct vc4_context *vc4)
{
	vc4_init_cl(&vc4->bcl);
	vc4_init_cl(&vc4->shader_rec);
	vc4_init_cl(&vc4->bo_handles);
	vc4_init_cl(&vc4->bo_pointers);
	vc4_job_reset(vc4);
}

void vc4_job_reset(struct vc4_context *vc4)
{
	int i;
	struct vc4_bo **referenced_bos = vc4->bo_pointers.base;
	for (i = 0; i < cl_offset(&vc4->bo_handles) / 4; i++) {
		vc4_bo_unreference(referenced_bos[i]);
	}

	vc4_reset_cl(&vc4->bcl);
	vc4_reset_cl(&vc4->shader_rec);
	vc4_reset_cl(&vc4->bo_handles);
	vc4_reset_cl(&vc4->bo_pointers);
	vc4->shader_rec_count = 0;

	vc4->needs_flush = false;
	vc4->draw_calls_queued = 0;
	/* We have no hardware context saved between our draw calls, so we
	 * need to flag the next draw as needing all state emitted.  Emitting
	 * all state at the start of our draws is also what ensures that we
	 * return to the state we need after a previous tile has finished.
	 */
	vc4->dirty = ~0;
	vc4->resolve = 0;
	vc4->cleared = 0;

	vc4->draw_min_x = ~0;
	vc4->draw_min_y = ~0;
	vc4->draw_max_x = 0;
	vc4->draw_max_y = 0;
}

static void vc4_submit_setup_rcl_surface(
	struct vc4_context *vc4, struct drm_vc4_submit_rcl_surface *submit_surf,
	struct pipe_surface *psurf, bool is_depth, bool is_write)
{
	struct vc4_surface *surf = vc4_surface(psurf);

	if (!surf) {
		submit_surf->hindex = ~0;
		return;
	}

	struct vc4_resource *rsc = vc4_resource(psurf->texture);
	submit_surf->hindex = vc4_gem_hindex(vc4, rsc->bo);
	submit_surf->offset = psurf->offset;

	if (is_depth) {
		submit_surf->bits =
			VC4_SET_FIELD(VC4_LOADSTORE_TILE_BUFFER_ZS,
				      VC4_LOADSTORE_TILE_BUFFER_BUFFER);
	} else {
		submit_surf->bits =
			VC4_SET_FIELD(VC4_LOADSTORE_TILE_BUFFER_COLOR,
				      VC4_LOADSTORE_TILE_BUFFER_BUFFER) |
			VC4_SET_FIELD(
				psurf->cpp == 2 ?
					VC4_LOADSTORE_TILE_BUFFER_BGR565 :
					VC4_LOADSTORE_TILE_BUFFER_RGBA8888,
				VC4_LOADSTORE_TILE_BUFFER_FORMAT);
	}
	submit_surf->bits |=
		VC4_SET_FIELD(surf->tiling, VC4_LOADSTORE_TILE_BUFFER_TILING);
}

static void vc4_submit_setup_rcl_render_config_surface(
	struct vc4_context *vc4, struct drm_vc4_submit_rcl_surface *submit_surf,
	struct pipe_surface *psurf)
{
	struct vc4_surface *surf = vc4_surface(psurf);

	if (!surf) {
		submit_surf->hindex = ~0;
		return;
	}

	struct vc4_resource *rsc = vc4_resource(psurf->texture);
	submit_surf->hindex = vc4_gem_hindex(vc4, rsc->bo);
	submit_surf->offset = psurf->offset;

	submit_surf->bits =
		VC4_SET_FIELD(psurf->cpp == 2 ?
				      VC4_RENDER_CONFIG_FORMAT_BGR565 :
				      VC4_RENDER_CONFIG_FORMAT_RGBA8888,
			      VC4_RENDER_CONFIG_FORMAT) |
		VC4_SET_FIELD(surf->tiling, VC4_RENDER_CONFIG_MEMORY_FORMAT);
}

void vc4_job_submit(struct vc4_context *vc4)
{
	struct drm_vc4_submit_cl submit;
	memset(&submit, 0, sizeof(submit));

	cl_ensure_space(&vc4->bo_handles, 4 * sizeof(uint32_t));
	cl_ensure_space(&vc4->bo_pointers, 4 * sizeof(struct vc4_bo *));

	vc4_submit_setup_rcl_surface(vc4, &submit.color_read, vc4->color_read,
				     false, false);
	vc4_submit_setup_rcl_render_config_surface(vc4, &submit.color_write,
						   vc4->color_write);
	vc4_submit_setup_rcl_surface(vc4, &submit.zs_read, vc4->zs_read, true,
				     false);
	vc4_submit_setup_rcl_surface(vc4, &submit.zs_write, vc4->zs_write, true,
				     true);

	submit.bin_cl = (uintptr_t)vc4->bcl.base;
	submit.bin_cl_size = cl_offset(&vc4->bcl);
	submit.shader_rec = (uintptr_t)vc4->shader_rec.base;
	submit.shader_rec_size = cl_offset(&vc4->shader_rec);
	submit.shader_rec_count = vc4->shader_rec_count;
	submit.bo_handles = (uintptr_t)vc4->bo_handles.base;
	submit.bo_handle_count = cl_offset(&vc4->bo_handles) / 4;

	if (vc4->draw_min_x == ~0 || vc4->draw_min_y == ~0) {
		printf("GLES: draw_min_x or draw_min_y not set.\n");
		return;
	}
	submit.min_x_tile = vc4->draw_min_x / vc4->tile_width;
	submit.min_y_tile = vc4->draw_min_y / vc4->tile_height;
	submit.max_x_tile = (vc4->draw_max_x - 1) / vc4->tile_width;
	submit.max_y_tile = (vc4->draw_max_y - 1) / vc4->tile_height;
	submit.width = vc4->draw_width;
	submit.height = vc4->draw_height;

	if (vc4->cleared) {
		submit.flags |= VC4_SUBMIT_CL_USE_CLEAR_COLOR;
		submit.clear_color[0] = vc4->clear_color[0];
		submit.clear_color[1] = vc4->clear_color[1];
		submit.clear_z = vc4->clear_depth;
		submit.clear_s = vc4->clear_stencil;
	}

	// vc4_dump_cl(vc4->bcl.base, cl_offset(&vc4->bcl), 8, "bcl");
	// vc4_dump_cl(vc4->shader_rec.base, cl_offset(&vc4->shader_rec), 8,
	// 	    "shader_rec");
	// vc4_dump_cl(vc4->bo_handles.base, cl_offset(&vc4->bo_handles), 8,
	// 	    "bo_handles");

	int ret = ioctl(vc4->fd, DRM_IOCTL_VC4_SUBMIT_CL, &submit);
	if (ret) {
		printf("GLES: submit failed: %e.\n", ret);
	}
	vc4_job_reset(vc4);
}
