#include <unistd.h>
#include <types.h>
#include <string.h>
#include <assert.h>

#include "vc4_context.h"
#include "vc4_cl.h"
#include "vc4_bufmgr.h"
#include "vc4_packet.h"
#include "vc4_resource.h"

static void vc4_get_draw_cl_space(struct vc4_context *vc4, int vert_count)
{
	int num_draws = 1;

	cl_ensure_space(&vc4->bcl, 256 + (VC4_PACKET_GL_INDEXED_PRIMITIVE_SIZE +
					  VC4_PACKET_NV_SHADER_STATE_SIZE) *
						   num_draws);

	cl_ensure_space(&vc4->shader_rec,
			(3 * sizeof(uint32_t) + 16) * num_draws);

	cl_ensure_space(&vc4->bo_handles, 20 * sizeof(uint32_t));
	cl_ensure_space(&vc4->bo_pointers, 20 * sizeof(uintptr_t));
}

static struct vc4_bo *get_ibo(struct vc4_context *vc4)
{
	static const uint8_t indices[] = {
		0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
	};
	struct vc4_bo *bo;
	void *map;

	bo = vc4_bo_alloc(vc4, sizeof(indices));
	map = vc4_bo_map(bo);
	memcpy(map, indices, sizeof(indices));

	return bo;
}

/**
 * Does the initial bining command list setup for drawing to a given FBO.
 */
static void vc4_start_draw(struct vc4_context *vc4)
{
	if (vc4->needs_flush)
		return;

	vc4_get_draw_cl_space(vc4, 0);

	cl_u8(&vc4->bcl, VC4_PACKET_TILE_BINNING_MODE_CONFIG);
	cl_u32(&vc4->bcl, 0);
	cl_u32(&vc4->bcl, 0);
	cl_u32(&vc4->bcl, 0);
	cl_u8(&vc4->bcl, vc4->draw_tiles_x);
	cl_u8(&vc4->bcl, vc4->draw_tiles_y);
	cl_u8(&vc4->bcl, VC4_BIN_CONFIG_AUTO_INIT_TSDA);

	/* START_TILE_BINNING resets the statechange counters in the hardware,
	 * which are what is used when a primitive is binned to a tile to
	 * figure out what new state packets need to be written to that tile's
	 * command list.
	 */
	cl_u8(&vc4->bcl, VC4_PACKET_START_TILE_BINNING);

	/* Reset the current compressed primitives format.  This gets modified
	 * by VC4_PACKET_GL_INDEXED_PRIMITIVE and
	 * VC4_PACKET_GL_ARRAY_PRIMITIVE, so it needs to be reset at the start
	 * of every tile.
	 */
	cl_u8(&vc4->bcl, VC4_PACKET_PRIMITIVE_LIST_FORMAT);
	cl_u8(&vc4->bcl, VC4_PRIMITIVE_LIST_FORMAT_16_INDEX |
				 VC4_PRIMITIVE_LIST_FORMAT_TYPE_TRIANGLES);

	vc4->needs_flush = 1;
	vc4->draw_calls_queued++;
	vc4->draw_width = vc4->framebuffer.width;
	vc4->draw_height = vc4->framebuffer.height;
}

static void vc4_init_context_fbo(struct vc4_context *vc4)
{
	vc4->tile_width = 64;
	vc4->tile_height = 64;

	vc4->draw_tiles_x =
		ROUNDUP_DIV(vc4->framebuffer.width, vc4->tile_width);
	vc4->draw_tiles_y =
		ROUNDUP_DIV(vc4->framebuffer.height, vc4->tile_height);
}

static void vc4_emit_nv_shader_state(struct vc4_context *vc4)
{
	struct pipe_vertex_buffer *vb = &vc4->vertexbuf;
	struct vc4_resource *rsc = vc4_resource(vb->buffer.resource);

	cl_u8(&vc4->bcl, VC4_PACKET_NV_SHADER_STATE);
	cl_u32(&vc4->bcl, 0); // offset into shader_rec

	cl_start_shader_reloc(&vc4->shader_rec, 3);
	cl_u8(&vc4->shader_rec, 0);
	cl_u8(&vc4->shader_rec, vb->stride);
	cl_u8(&vc4->shader_rec, 0); // num uniforms (not used)
	cl_u8(&vc4->shader_rec, 3); // num varyings
	cl_reloc(&vc4->shader_rec, vc4, vc4->prog.fs, 0);
	cl_reloc(&vc4->shader_rec, vc4, vc4->uniforms, 0);
	cl_reloc(&vc4->shader_rec, vc4, rsc->bo, vb->buffer_offset);

	if (vc4->zsa.base.depth.enabled) {
		vc4->resolve |= PIPE_CLEAR_DEPTH;
	}
	if (vc4->zsa.base.stencil[0].enabled)
		vc4->resolve |= PIPE_CLEAR_STENCIL;
	vc4->resolve |= PIPE_CLEAR_COLOR0;

	vc4->shader_rec_count++;
}

static void vc4_draw_vbo(struct pipe_context *pctx, struct pipe_draw_info *info)
{
	struct vc4_context *vc4 = vc4_context(pctx);

	vc4_init_context_fbo(vc4);

	vc4_get_draw_cl_space(vc4, 0);

	vc4_start_draw(vc4);
	vc4_update_compiled_shaders(vc4, info->mode);

	vc4_emit_state(vc4);

	if ((vc4->dirty & VC4_DIRTY_VTXBUF)) {
		vc4_emit_nv_shader_state(vc4);
	}

	vc4->dirty = 0;

	if (info->index_size) {
		struct vc4_bo *ibo = get_ibo(vc4);

		uint32_t index_size = info->index_size;
		uint32_t offset = info->start * index_size;
		assert(index_size == 1 || index_size == 2);

		cl_start_reloc(&vc4->bcl, 1);
		cl_u8(&vc4->bcl, VC4_PACKET_GL_INDEXED_PRIMITIVE);
		cl_u8(&vc4->bcl,
		      info->mode | (index_size == 2 ? VC4_INDEX_BUFFER_U16 :
						      VC4_INDEX_BUFFER_U8));
		cl_u32(&vc4->bcl, info->count);
		cl_reloc(&vc4->bcl, vc4, ibo, offset);
		cl_u32(&vc4->bcl, vc4->max_index);

		if (info->has_user_indices) {
			vc4_bo_unreference(ibo);
		}
	} else {
		cl_u8(&vc4->bcl, VC4_PACKET_GL_ARRAY_PRIMITIVE);
		cl_u8(&vc4->bcl, info->mode);
		cl_u32(&vc4->bcl, info->count);
		cl_u32(&vc4->bcl, info->start);
	}
}

static uint8_t float_to_ubyte(float f)
{
	union fi {
		float f;
		int32_t i;
		uint32_t ui;
	} tmp;

	tmp.f = f;
	if (tmp.i < 0) {
		return (uint8_t)0;
	} else if (tmp.i >= 0x3f800000 /* 1.0f */) {
		return (uint8_t)255;
	} else {
		tmp.f = tmp.f * (255.0f / 256.0f) + 32768.0f;
		return (uint8_t)tmp.i;
	}
}

static uint32_t pack_rgba(const float *rgba)
{
	uint8_t r = float_to_ubyte(rgba[0]);
	uint8_t g = float_to_ubyte(rgba[1]);
	uint8_t b = float_to_ubyte(rgba[2]);
	uint8_t a = float_to_ubyte(rgba[3]);
	return (a << 24) | (b << 16) | (g << 8) | r;
}

static void vc4_clear(struct pipe_context *pctx, unsigned buffers,
		      const union pipe_color_union *color, double depth,
		      unsigned stencil)
{
	struct vc4_context *vc4 = vc4_context(pctx);

	/* We can't flag new buffers for clearing once we've queued draws.  We
	 * could avoid this by using the 3d engine to clear.
	 */
	if (vc4->draw_calls_queued) {
		vc4_flush(pctx);
	}

	if (buffers & PIPE_CLEAR_COLOR0) {
		uint32_t clear_color;
		clear_color = pack_rgba(color->f);
		vc4->clear_color[0] = vc4->clear_color[1] = clear_color;
	}

	if (buffers & PIPE_CLEAR_DEPTHSTENCIL) {
		if (buffers & PIPE_CLEAR_DEPTH)
			vc4->clear_depth =
				depth == 1.0 ?
					0xffffff :
					(uint32_t)(depth * 0xffffff + 0.5f);
		if (buffers & PIPE_CLEAR_STENCIL)
			vc4->clear_stencil = stencil;
	}

	vc4_init_context_fbo(vc4);

	vc4->draw_min_x = 0;
	vc4->draw_min_y = 0;
	vc4->draw_max_x = vc4->framebuffer.width;
	vc4->draw_max_y = vc4->framebuffer.height;
	vc4->cleared |= buffers;

	vc4_start_draw(vc4);
}

void vc4_draw_init(struct pipe_context *pctx)
{
	pctx->draw_vbo = vc4_draw_vbo;
	pctx->clear = vc4_clear;
}
