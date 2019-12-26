/**
 * Test depth testing
 *
 * left-top: green in front of red, red in front of blue.
 * right-bottom: yellow in front of orange at the bottom,
 *               orange in front of yellow at the top.
 */

#include <EGL/egl.h>
#include <GLES/gl.h>
#include <stdio.h>

EGLDisplay dpy;
EGLDisplay ctx;

static GLfloat vertexs[] = {
	-0.5, -0.5, 0.5,
	0.5, -0.5, 0.5,
	0.5, 0.5, 0.5,
	-0.5, 0.5, 0.5,

	-0.75, -0.75, 0.4,
	-0.25, -0.75, 0.4,
	-0.25, 0.25, 0.4,
	-0.75, 0.25, 0.4,

	0.25, -0.75, 0.6,
	0.75, -0.75, 0.6,
	0.75, 0.25, 0.6,
	0.25, 0.25, 0.6,

	-0.8, -0.9, 0.2,
	-0.2, -0.9, 0.2,
	0.2, 0.9, 0.5,
	-0.9, 0.9, 0.5,

	0.2, -0.9, 0.4,
	-0.2, 0.8, 0.4,
	0.9, 0.8, 0.4,
	0.8, -0.9, 0.4,
};

void init()
{
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LESS);
	glClearColor(0.64f, 0.81f, 0.38f, 1.0f);
	glClearDepthf(1);
}

void draw()
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glVertexPointer(3, GL_FLOAT, 0, vertexs);
	glEnableClientState(GL_VERTEX_ARRAY);

	{
		glViewport(0, 0, 640, 320);

		glColor4f(1, 0, 0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 0, 4);

		glColor4f(0, 1, 0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 4, 4);

		glColor4f(0, 0, 1, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 8, 4);
	}
	{
		glViewport(640, 320, 640, 320);

		glColor4f(1, 1, 0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 12, 4);

		glColor4f(1, 0.5, 0, 1);
		glDrawArrays(GL_TRIANGLE_FAN, 16, 4);
	}

	glDisableClientState(GL_VERTEX_ARRAY);

	glFlush();
	eglSwapBuffers(dpy);
}

int main(int argc, char *argv[])
{
	printf("Test depth testing...\n");

	dpy = eglGetDisplay(EGL_DEFAULT_DISPLAY);
	ctx = eglCreateContext(dpy);

	if (!eglMakeCurrent(dpy, ctx)) {
		return 1;
	}

	init();

	draw();

	eglDestroyContext(dpy, ctx);

	return 0;
}
