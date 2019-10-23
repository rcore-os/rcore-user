/**
 * Test more complex shapes
 */

#include <EGL/egl.h>
#include <GLES/gl.h>
#include <stdio.h>

EGLDisplay dpy;
EGLDisplay ctx;

const GLfloat vertexs[] = {
	-0.8, 0.1,
	-0.2, 0.1,
	-0.2, 0.7,
	-0.8, 0.7,

	-0.7, -0.6,
	-0.1, -0.6,
	-0.1, 0,
	-0.7, 0,

	-0.9, -0.7,
	-0.5, -0.7,
	-0.5, -0.3,
	-0.9, -0.3,

	0.1, -0.6,
	0.7, -0.6,
	0.4, -0.1,
	0.3, -0.4,
	0.9, -0.4,
	0.6, -0.9,

	0.4, 0.2,
	0.6, 0.2,
	0.7, 0.4,
	0.6, 0.6,
	0.4, 0.6,
	0.3, 0.4
};
const GLfloat colors[] = {
	1, 0, 0, 1,
	1, 0, 0, 1,
	1, 0, 0, 1,
	1, 0, 0, 1,

	0, 1, 0, 1,
	0, 1, 0, 1,
	0, 1, 0, 1,
	0, 1, 0, 1,

	0.2, 0.2, 0.2, 1,
	1, 1, 1, 1,
	0.2, 0.2, 0.2, 1,
	1, 1, 1, 1,

	0, 0, 1, 1,
	0, 0, 1, 1,
	0, 0, 1, 1,
	1, 0, 0, 1,
	0, 1, 0, 1,
	0, 0, 1, 1,

	1, 1, 0, 1,
	1, 1, 0, 1,
	1, 1, 0, 1,
	1, 1, 0, 1,
	1, 1, 0, 1,
	1, 1, 0, 1
};

void init()
{
	glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
	glViewport(420, 0, 1080, 1080);
}

void draw()
{
	glClear(GL_COLOR_BUFFER_BIT);

	glVertexPointer(2, GL_FLOAT, 0, vertexs);
	glColorPointer(4, GL_FLOAT, 0, colors);

	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);

	glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
	glDrawArrays(GL_TRIANGLE_FAN, 4, 4);
	glDrawArrays(GL_TRIANGLE_FAN, 8, 4);

	glDrawArrays(GL_TRIANGLES, 12, 6);

	glDrawArrays(GL_TRIANGLE_FAN, 18, 6);

	glFlush();
	eglSwapBuffers(dpy);
}

int main(int argc, char *argv[])
{
	printf("Test more shapes...\n");

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
