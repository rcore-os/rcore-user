#include <err.h>
#include <errno.h>
#include <stdio.h>

#include <EGL/egl.h>

#include "gl_context.h"

EGLDisplay eglGetDisplay(EGLNativeDisplayType display_id)
{
	return (EGLDisplay)1;
}

EGLContext eglCreateContext(EGLDisplay dpy)
{
	int ret = 0;
	if (dpy == EGL_NO_DISPLAY) {
		ret = -EINVAL;
		goto out;
	}

	struct gl_context *context = gl_context_create();
	if (context == NULL) {
		ret = -ENOMEM;
		goto out;
	}
	if ((ret = gl_create_window(context))) {
		goto out;
	}
	if ((ret = gl_default_state(context))) {
		goto out;
	}

out:
	if (ret) {
		printf("GLES: eglCreateContext() failed.\n");
	}
	return ret ? EGL_NO_CONTEXT : context;
}

EGLBoolean eglMakeCurrent(EGLDisplay dpy, EGLContext ctx)
{
	if (dpy == EGL_NO_DISPLAY || ctx == EGL_NO_CONTEXT) {
		return 0;
	}

	extern struct gl_context *context;
	context = (struct gl_context *)ctx;

	return 1;
}

EGLBoolean eglDestroyContext(EGLDisplay dpy, EGLContext ctx)
{
	if (ctx == EGL_NO_CONTEXT) {
		return 0;
	}

	struct gl_context *context = (struct gl_context *)ctx;
	gl_context_destroy(context);

	return 1;
}

EGLBoolean eglSwapBuffers(EGLDisplay dpy)
{
	GET_CURRENT_CONTEXT(context);

	if (gl_swap_buffers(context)) {
		return 0;
	}

	return 1;
}
