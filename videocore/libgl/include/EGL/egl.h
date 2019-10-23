#ifndef __egl_h_
#define __egl_h_

typedef unsigned int EGLBoolean;
typedef unsigned int EGLenum;
typedef unsigned int EGLNativeDisplayType;
typedef void *EGLConfig;
typedef void *EGLContext;
typedef void *EGLDisplay;
typedef void *EGLSurface;
typedef void *EGLClientBuffer;

#define EGL_DEFAULT_DISPLAY		((EGLNativeDisplayType)0)
#define EGL_NO_CONTEXT			((EGLContext)0)
#define EGL_NO_DISPLAY			((EGLDisplay)0)
#define EGL_NO_SURFACE			((EGLSurface)0)

EGLDisplay eglGetDisplay(EGLNativeDisplayType display_id);
EGLContext eglCreateContext(EGLDisplay dpy);
EGLBoolean eglMakeCurrent(EGLDisplay dpy, EGLContext ctx);
EGLBoolean eglDestroyContext(EGLDisplay dpy, EGLContext ctx);
EGLBoolean eglSwapBuffers(EGLDisplay dpy);

#endif
