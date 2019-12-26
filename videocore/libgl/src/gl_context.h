#ifndef GL_CONTEXT_H
#define GL_CONTEXT_H

#include <fb.h>

#include <GLES/gl.h>

#include "pipe/p_state.h"

#define GET_CURRENT_CONTEXT(C) struct gl_context *C = gl_current_context()

struct gl_screen {
	int fb_fd;
	int gpu_fd;
	uint32_t screen_size;
	uint32_t double_buffer_offset;
	struct fb_var_screeninfo var;

	struct pipe_resource *color_buf, *zs_buf;
};

struct gl_context {
	struct gl_screen screen;
	struct pipe_context *pipe;

	struct pipe_viewport_state viewport;
	struct pipe_framebuffer_state framebuffer;
	struct pipe_clear_state clear_state;
	struct pipe_vertex_array_state vertex_pointer_state;
	struct pipe_vertex_array_state color_pointer_state;
	struct pipe_depth_stencil_alpha_state depth_stencil;

	union pipe_color_union current_color;
	GLenum last_error;

	GLfloat transform[16];
	int transform_depth;
};

// DELETE INLINE KEYWORD, WILL CAUSE PROBLEM?
struct gl_context *gl_current_context(void);

struct gl_context *gl_context_create(void);
void gl_context_destroy(struct gl_context *ctx);

int gl_create_window(struct gl_context *ctx);
int gl_default_state(struct gl_context *ctx);
int gl_swap_buffers(struct gl_context *ctx);

void gl_current_color(struct gl_context *ctx, GLfloat red, GLfloat green,
		      GLfloat blue, GLfloat alpha);
void gl_error(struct gl_context *ctx, GLenum error);
GLenum gl_get_error(struct gl_context *ctx);

void gl_clear(struct gl_context *ctx, GLbitfield mask);
void gl_flush(struct gl_context *ctx);
void gl_set_enable(struct gl_context *ctx, GLenum cap, GLboolean state);
void gl_client_state(struct gl_context *ctx, GLenum array, GLboolean state);
void gl_pointer_array(struct gl_context *ctx,
		      struct pipe_vertex_array_state *state, GLint sizeMin,
		      GLint sizeMax, GLint size, GLenum type, GLsizei stride,
		      const void *pointer);
void gl_depth_range(struct gl_context *ctx, GLfloat n, GLfloat f);
void gl_viewport(struct gl_context *ctx, GLint x, GLint y, GLsizei width,
		 GLsizei height);
void gl_depth_stencil_alpha(struct gl_context *ctx);
void gl_draw_arrays(struct gl_context *ctx, GLenum mode, GLint first,
		    GLsizei count);
void gl_loadIdentity(struct gl_context *ctx);
void gl_Rotatef(struct gl_context *ctx, GLfloat angle, GLfloat x, GLfloat y, GLfloat z);

#endif // GL_CONTEXT_H
