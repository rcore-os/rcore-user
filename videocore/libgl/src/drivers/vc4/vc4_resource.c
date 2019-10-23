#include <malloc.h>
#include <string.h>
#include <stdio.h>

#include "vc4_resource.h"
#include "vc4_context.h"

static void *vc4_resource_transfer_map(struct pipe_context *pctx,
				       struct pipe_resource *prsc)
{
	struct vc4_resource *rsc = vc4_resource(prsc);
	return vc4_bo_map(rsc->bo);
}

static void vc4_resource_destroy(struct pipe_context *pctx,
				 struct pipe_resource *prsc)
{
	if (!prsc)
		return;

	struct vc4_resource *rsc = vc4_resource(prsc);
	vc4_bo_unreference(rsc->bo);
	free(rsc);
}

static void vc4_setup_slices(struct vc4_resource *rsc)
{
	struct pipe_resource *prsc = &rsc->base;
	uint32_t width = prsc->width0;
	uint32_t height = prsc->height0;

	struct vc4_resource_slice *slice = &rsc->slices[0];

	slice->offset = 0;
	slice->stride = width * prsc->cpp;
	slice->size = height * slice->stride;
	slice->tiling = VC4_TILING_FORMAT_LINEAR;
}

static struct pipe_resource *
	vc4_resource_create(struct pipe_context *pctx,
			    const struct pipe_resource *tmpl)
{
	struct vc4_context *vc4 = vc4_context(pctx);
	struct vc4_resource *rsc;
	struct vc4_bo *bo;

	rsc = (struct vc4_resource *)malloc(sizeof(struct vc4_resource));
	if (rsc == NULL)
		return NULL;

	memset(rsc, 0, sizeof(struct vc4_resource));

	struct pipe_resource *prsc = &rsc->base;
	*prsc = *tmpl;

	vc4_setup_slices(rsc);

	if (tmpl->bind & PIPE_BIND_DISPLAY_TARGET)
		bo = vc4_bo_alloc_fb(vc4);
	else
		bo = vc4_bo_alloc(vc4,
				  rsc->slices[0].offset + rsc->slices[0].size);

	if (bo == NULL) {
		goto fail;
	}

	rsc->bo = bo;
	return prsc;

fail:
	vc4_resource_destroy(pctx, prsc);
	return NULL;
}

static struct pipe_surface *
	vc4_create_surface(struct pipe_context *pctx,
			   struct pipe_resource *ptex,
			   const struct pipe_surface *surf_tmpl)
{
	struct vc4_surface *surface;
	struct vc4_resource *rsc = vc4_resource(ptex);

	surface = (struct vc4_surface *)malloc(sizeof(struct vc4_surface));
	if (vc4_surface == NULL)
		return NULL;

	memset(surface, 0, sizeof(struct vc4_surface));

	struct pipe_surface *psurf = &surface->base;
	*psurf = *surf_tmpl;

	psurf->texture = ptex;
	psurf->context = pctx;
	surface->tiling = rsc->slices[0].tiling;

	return &surface->base;
}

static void vc4_surface_destroy(struct pipe_context *pctx,
				struct pipe_surface *psurf)
{
	if (psurf)
		free(psurf);
}

void vc4_dump_surface(struct pipe_surface *psurf)
{
	struct vc4_resource *rsc = vc4_resource(psurf->texture);
	void *map = vc4_bo_map(rsc->bo) + psurf->offset;
	uint32_t width = psurf->width;
	uint32_t height = psurf->height;
	uint32_t center_x = width / 2;
	uint32_t center_y = height / 2;
	const int window_size = 6;

	int x, y;
	for (y = -window_size; y < window_size; y++) {
		for (x = -window_size; x < window_size; x++) {
			uint32_t cpp = psurf->cpp;
			uint32_t addr =
				((y + center_y) * width + (x + center_x)) * cpp;
			char *ptr = map + addr;
			int k;
			for (k = cpp - 1; k >= 0; k--)
				printf("%02x", *(ptr + k));
			printf(" ");
		}
		printf("\n");
	}
}

void vc4_resource_init(struct pipe_context *pctx)
{
	pctx->resource_create = vc4_resource_create;
	pctx->resource_destroy = vc4_resource_destroy;
	pctx->resource_transfer_map = vc4_resource_transfer_map;
	pctx->create_surface = vc4_create_surface;
	pctx->surface_destroy = vc4_surface_destroy;
}
