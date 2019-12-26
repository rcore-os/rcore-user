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
	//front
	0.5, 0.5, 0.5,
	-0.5, 0.5, 0.5,
	-0.5, -0.5, 0.5,
	0.5, -0.5, 0.5,

	//top
	0.5, 0.5, 0.5,
	-0.5, 0.5, 0.5,
	-0.5, 0.5, -0.5,
	0.5, 0.5, -0.5,

	//left
	-0.5, 0.5, 0.5,
	-0.5, 0.5, -0.5,
	-0.5, -0.5, -0.5,
	-0.5, -0.5, 0.5,

	//back
	0.5, 0.5, -0.5,
	-0.5, 0.5, -0.5,
	-0.5, -0.5, -0.5,
	0.5, -0.5, -0.5,

	//right
	0.5, 0.5, 0.5,
	0.5, 0.5, -0.5,
	0.5, -0.5, -0.5,
	0.5, -0.5, 0.5,

	//down
	0.5, -0.5, 0.5,
	-0.5, -0.5, 0.5,
	-0.5, -0.5, -0.5,
	0.5, -0.5, -0.5,
};

const GLfloat colors[] = {
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,

	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,

	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,

	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,

	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,

	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
	1, 1, 1, 1,
};

void init()
{
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LESS);
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClearDepthf(1);
}

GLfloat u = 0.01, v = 0.01;

void draw(float angle)
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glVertexPointer(3, GL_FLOAT, 0, vertexs);
	glColorPointer(4, GL_FLOAT, 0, colors);
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_COLOR_ARRAY);

	glLoadIdentity();
	glRotatef(angle, 0.0, 1.0, 0.0);
	glRotatef(30.0, 1.0, 0.0, 0.0);

	glDrawArrays(GL_LINE_LOOP, 0, 4);
	glDrawArrays(GL_LINE_LOOP, 4, 4);
	glDrawArrays(GL_LINE_LOOP, 8, 4);
	glDrawArrays(GL_LINE_LOOP, 12, 4);
	glDrawArrays(GL_LINE_LOOP, 16, 4);
	glDrawArrays(GL_LINE_LOOP, 20, 4);

	glDisableClientState(GL_VERTEX_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);

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

	float delta = 0.1;
	float angle = 0.0;
	while (angle <= 360.0) {
		draw(angle);
		angle += delta;
	}
	// for (i = 0; i < 100; i++)
	// 	draw(i);

	gettimeofday(&tv_end, &tz);

	eglDestroyContext(dpy, ctx);

	float times = 1.0 * (tv_end.tv_sec - tv_begin.tv_sec) + (tv_end.tv_usec - tv_begin.tv_usec) / 1000000.0;

	printf("whole time: %f s\n", times);
	printf("frequency: %f\n", 360.0 / times);

	return 0;
}