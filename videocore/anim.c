/**
 * Test simple animation
 */

#include <EGL/egl.h>
#include <GLES/gl.h>
#include <stdio.h>
#include <sys/time.h>

EGLDisplay dpy;
EGLDisplay ctx;

static GLfloat vertexs[] = {
	-1, -1,
	0, -1,
	-0.5, 0,
};

static GLfloat colors[] = {
	1, 0, 0, 1,
	0, 1, 0, 1,
	0, 0, 1, 1,
};

void init()
{
	glClearColor(0.64f, 0.81f, 0.38f, 1.0f);
}

GLfloat u = 0.01, v = 0.01;

void draw(int frame)
{
	int i;
	for (i = 0; i < sizeof(vertexs) / sizeof(GLfloat); i += 2) {
		vertexs[i] += u;
		vertexs[i + 1] += v;
	}

	glClear(GL_COLOR_BUFFER_BIT);

	glVertexPointer(2, GL_FLOAT, 0, vertexs);
	glColorPointer(4, GL_FLOAT, 0, colors);

	glEnableClientState(GL_VERTEX_ARRAY);

	if (frame < 50) {
		glColor4f(1, 0.5, 0, 1);
	} else {
		glEnableClientState(GL_COLOR_ARRAY);
	}

	glDrawArrays(GL_TRIANGLES, 0, 3);

	glDisableClientState(GL_COLOR_ARRAY);
	glDisableClientState(GL_VERTEX_ARRAY);

	glFlush();
	eglSwapBuffers(dpy);
}

int main(int argc, char *argv[])
{
	printf("Test animation...\n");

	dpy = eglGetDisplay(EGL_DEFAULT_DISPLAY);
	ctx = eglCreateContext(dpy);

	if (!eglMakeCurrent(dpy, ctx)) {
		return 1;
	}

	init();

	struct timeval tv_begin, tv_end;
	struct timezone tz;

	gettimeofday(&tv_begin, &tz);

	int i;
	for (i = 0; i < 100; i++)
		draw(i);

	gettimeofday(&tv_end, &tz);

	eglDestroyContext(dpy, ctx);

	float times = 1.0 * (tv_end.tv_sec - tv_begin.tv_sec) + (tv_end.tv_usec - tv_begin.tv_usec) / 1000000.0;

	printf("whole time: %f s\n", times);
	printf("frequency: %f\n", 100.0 / times);

	return 0;
}
