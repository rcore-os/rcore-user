#ifndef VC4_RESOURCE_H
#define VC4_RESOURCE_H

#include "pipe/p_state.h"
#include "pipe/p_context.h"

struct vc4_resource_slice {
	uint32_t offset;
	uint32_t stride;
	uint32_t size;
	/** One of VC4_TILING_FORMAT_* */
	uint8_t tiling;
};

struct vc4_surface {
	struct pipe_surface base;
	uint8_t tiling;
};

struct vc4_resource {
	struct pipe_resource base;
	struct vc4_bo *bo;
	struct vc4_resource_slice slices[1];
};

static inline struct vc4_resource *vc4_resource(struct pipe_resource *prsc)
{
	return (struct vc4_resource *)prsc;
}

static inline struct vc4_surface *vc4_surface(struct pipe_surface *psurf)
{
	return (struct vc4_surface *)psurf;
}

void vc4_resource_init(struct pipe_context *pctx);
void vc4_dump_surface(struct pipe_surface *psurf);

#endif // VC4_RESOURCE_H
