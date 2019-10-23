#ifndef PIPE_CONTEXT_H
#define PIPE_CONTEXT_H

#include "p_defines.h"

struct pipe_viewport_state;
struct pipe_depth_stencil_alpha_state;
struct pipe_framebuffer_state;
struct pipe_surface;
struct pipe_vertex_buffer;
struct pipe_resource;
struct pipe_draw_info;

struct pipe_context {
	void (*destroy)(struct pipe_context *ctx);
	void (*draw_vbo)(struct pipe_context *ctx, struct pipe_draw_info *info);
	void (*clear)(struct pipe_context *ctx, unsigned buffers,
		      const union pipe_color_union *color, double depth,
		      unsigned stencil);
	void (*flush)(struct pipe_context *ctx);

	void (*set_depth_stencil_alpha_state)(
		struct pipe_context *,
		const struct pipe_depth_stencil_alpha_state *);

	int (*create_fs_state)(struct pipe_context *);

	void (*set_framebuffer_state)(struct pipe_context *,
				      const struct pipe_framebuffer_state *);

	void (*set_viewport_state)(struct pipe_context *,
				   const struct pipe_viewport_state *);
	void (*set_vertex_buffers)(struct pipe_context *pctx,
				   const struct pipe_vertex_buffer *vb);

	struct pipe_resource *(*resource_create)(
		struct pipe_context *pctx, const struct pipe_resource *tmpl);
	void (*resource_destroy)(struct pipe_context *pctx,
				 struct pipe_resource *prsc);
	void *(*resource_transfer_map)(struct pipe_context *pctx,
				       struct pipe_resource *prsc);

	struct pipe_surface *(*create_surface)(
		struct pipe_context *pctx, struct pipe_resource *ptex,
		const struct pipe_surface *surf_tmpl);
	void (*surface_destroy)(struct pipe_context *pctx,
				struct pipe_surface *psurf);
};

struct pipe_context *pipe_context_create(int fd);

#endif // PIPE_CONTEXT_H
