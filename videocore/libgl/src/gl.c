#include <GLES/gl.h>

#include "gl_context.h"

GL_API void GL_APIENTRY glClearColor(GLfloat red, GLfloat green, GLfloat blue,
				     GLfloat alpha)
{
	GET_CURRENT_CONTEXT(ctx);

	struct pipe_clear_state *clear_state = &ctx->clear_state;
	clear_state->color.f[0] = red;
	clear_state->color.f[1] = green;
	clear_state->color.f[2] = blue;
	clear_state->color.f[3] = alpha;
}

GL_API void GL_APIENTRY glClearDepthf(GLclampf depth)
{
	GET_CURRENT_CONTEXT(ctx);

	ctx->clear_state.depth = depth;
}

GL_API void GL_APIENTRY glClearStencil(GLint s)
{
	GET_CURRENT_CONTEXT(ctx);

	ctx->clear_state.stencil = s;
}

GL_API void GL_APIENTRY glColor4f(GLfloat red, GLfloat green, GLfloat blue,
				  GLfloat alpha)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_current_color(ctx, red, green, blue, alpha);
}

GL_API void GL_APIENTRY glClear(GLbitfield mask)
{
	GET_CURRENT_CONTEXT(ctx);

	if (mask & ~(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT |
		     GL_STENCIL_BUFFER_BIT)) {
		gl_error(ctx, GL_INVALID_VALUE);
		return;
	}

	GLbitfield bufferMask = 0;
	if (!ctx->depth_stencil.depth.writemask) {
		mask &= ~PIPE_CLEAR_DEPTH;
	}
	if (mask & GL_COLOR_BUFFER_BIT) {
		bufferMask |= PIPE_CLEAR_COLOR;
	}
	if (mask & GL_DEPTH_BUFFER_BIT) {
		bufferMask |= PIPE_CLEAR_DEPTH;
	}
	if (mask & GL_STENCIL_BUFFER_BIT) {
		bufferMask |= PIPE_CLEAR_STENCIL;
	}

	gl_clear(ctx, bufferMask);
}

GL_API void GL_APIENTRY glColorPointer(GLint size, GLenum type, GLsizei stride,
				       const void *pointer)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_pointer_array(ctx, &ctx->color_pointer_state, 4, 4, size, type,
			 stride, pointer);
}

GL_API void GL_APIENTRY glDepthRangef(GLfloat n, GLfloat f)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_depth_range(ctx, n, f);
}

GL_API void GL_APIENTRY glDepthFunc(GLenum func)
{
	GET_CURRENT_CONTEXT(ctx);

	if (func < GL_NEVER || func > GL_ALWAYS) {
		gl_error(ctx, GL_INVALID_ENUM);
		return;
	}
	ctx->depth_stencil.depth.func = func;
	gl_depth_stencil_alpha(ctx);
}

GL_API void GL_APIENTRY glDepthMask(GLboolean flag)
{
	GET_CURRENT_CONTEXT(ctx);

	ctx->depth_stencil.depth.writemask = flag;
	gl_depth_stencil_alpha(ctx);
}

GL_API void GL_APIENTRY glDisable(GLenum cap)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_set_enable(ctx, cap, GL_FALSE);
}

GL_API void GL_APIENTRY glDisableClientState(GLenum array)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_client_state(ctx, array, GL_FALSE);
}

GL_API void GL_APIENTRY glDrawArrays(GLenum mode, GLint first, GLsizei count)
{
	GET_CURRENT_CONTEXT(ctx);

	if (mode < GL_POINTS || mode > GL_TRIANGLE_FAN) {
		gl_error(ctx, GL_INVALID_ENUM);
		return;
	}
	if (count < 0) {
		gl_error(ctx, GL_INVALID_VALUE);
		return;
	}

	gl_draw_arrays(ctx, mode, first, count);
}

GL_API void GL_APIENTRY glDrawElements(GLenum mode, GLsizei count, GLenum type,
				       const void *indices)
{
}

GL_API void GL_APIENTRY glEnable(GLenum cap)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_set_enable(ctx, cap, GL_TRUE);
}

GL_API void GL_APIENTRY glEnableClientState(GLenum array)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_client_state(ctx, array, GL_TRUE);
}

GL_API void GL_APIENTRY glFlush(void)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_flush(ctx);
}

GL_API GLenum GL_APIENTRY glGetError(void)
{
	GET_CURRENT_CONTEXT(ctx);

	return gl_get_error(ctx);
}

GL_API void GL_APIENTRY glVertexPointer(GLint size, GLenum type, GLsizei stride,
					const void *pointer)
{
	GET_CURRENT_CONTEXT(ctx);

	gl_pointer_array(ctx, &ctx->vertex_pointer_state, 2, 3, size, type,
			 stride, pointer);
}

GL_API void GL_APIENTRY glViewport(GLint x, GLint y, GLsizei width,
				   GLsizei height)
{
	GET_CURRENT_CONTEXT(ctx);

	if (width < 0 || height < 0) {
		gl_error(ctx, GL_INVALID_VALUE);
		return;
	}

	gl_viewport(ctx, x, y, width, height);
}
