#include "vc4_context.h"
#include <string.h>

static void vc4_set_framebuffer_state(
	struct pipe_context *pctx,
	const struct pipe_framebuffer_state *framebuffer)
{
	struct vc4_context *vc4 = vc4_context(pctx);
	vc4->framebuffer = *framebuffer;
	vc4->dirty |= VC4_DIRTY_FRAMEBUFFER;
}

static void vc4_set_viewport_state(struct pipe_context *pctx,
				   const struct pipe_viewport_state *viewport)
{
	struct vc4_context *vc4 = vc4_context(pctx);
	vc4->viewport = *viewport;
	vc4->dirty |= VC4_DIRTY_VIEWPORT;
}

static void vc4_set_vertex_buffers(struct pipe_context *pctx,
				   const struct pipe_vertex_buffer *vb)
{
	struct vc4_context *vc4 = vc4_context(pctx);
	vc4->vertexbuf = *vb;
	vc4->dirty |= VC4_DIRTY_VTXBUF;
}

static void vc4_set_depth_stencil_alpha_state(
	struct pipe_context *pctx,
	const struct pipe_depth_stencil_alpha_state *cso)
{
	struct vc4_context *vc4 = vc4_context(pctx);
	struct vc4_depth_stencil_alpha_state *so = &vc4->zsa;

	so->base = *cso;
	memset(so->config_bits, 0, sizeof(so->config_bits));

	/* We always keep the early Z state correct, since a later state using
	 * early Z may want it.
	 */
	so->config_bits[2] |= VC4_CONFIG_BITS_EARLY_Z_UPDATE;

	if (cso->depth.enabled) {
		if (cso->depth.writemask) {
			so->config_bits[1] |= VC4_CONFIG_BITS_Z_UPDATE;
		}
		so->config_bits[1] |=
			(cso->depth.func << VC4_CONFIG_BITS_DEPTH_FUNC_SHIFT);

		/* We only handle early Z in the < direction because otherwise
		 * we'd have to runtime guess which direction to set in the
		 * render config.
		 */
		if (cso->depth.func == PIPE_FUNC_LESS ||
		    cso->depth.func == PIPE_FUNC_LEQUAL) {
			so->config_bits[2] |= VC4_CONFIG_BITS_EARLY_Z;
		}
	} else {
		so->config_bits[1] |=
			(PIPE_FUNC_ALWAYS << VC4_CONFIG_BITS_DEPTH_FUNC_SHIFT);
	}

	vc4->dirty |= VC4_DIRTY_ZSA;
}

void vc4_state_init(struct pipe_context *pctx)
{
	pctx->set_framebuffer_state = vc4_set_framebuffer_state;
	pctx->set_viewport_state = vc4_set_viewport_state;
	pctx->set_vertex_buffers = vc4_set_vertex_buffers;

	pctx->set_depth_stencil_alpha_state = vc4_set_depth_stencil_alpha_state;
}
