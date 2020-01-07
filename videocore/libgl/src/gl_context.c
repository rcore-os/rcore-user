#include <fb.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>
#include <sys/ioctl.h>
#include <stdio.h>

#include <unistd.h>
#include <malloc.h>

#include "gl_context.h"
#include "pipe/p_context.h"
#include <math.h>
#include "gl_matrix.h"

/** Clamp X to [MIN,MAX] */
#define CLAMP(X, MIN, MAX) ((X) < (MIN) ? (MIN) : ((X) > (MAX) ? (MAX) : (X)))

struct gl_context *context = NULL;

static const GLfloat Identity[16] = {
   1.0, 0.0, 0.0, 0.0,
   0.0, 1.0, 0.0, 0.0,
   0.0, 0.0, 1.0, 0.0,
   0.0, 0.0, 0.0, 1.0
};

static void set_viewport_no_notify(struct gl_context *ctx, GLint x, GLint y,
				   GLsizei width, GLsizei height)
{
	struct pipe_viewport_state *viewport = &ctx->viewport;
	struct pipe_framebuffer_state *fb = &ctx->framebuffer;
	x = CLAMP(x, 0, fb->width);
	y = CLAMP(y, 0, fb->height);
	if (width > fb->width)
		width = fb->width;
	if (height > fb->height)
		height = fb->height;

	float half_width = 0.5f * width;
	float half_height = 0.5f * height;
	viewport->scale[0] = half_width;
	viewport->translate[0] = half_width + x;
	viewport->scale[1] = half_height;
	viewport->translate[1] = half_height + y;
}

static void set_default_transform_no_notify(struct gl_context *ctx) {
	ctx->transform_depth = 0;
	memset(&ctx->transform, 0, sizeof(ctx->transform));
}

static void set_depth_range_no_notify(struct gl_context *ctx, GLfloat n,
				      GLfloat f)
{
	struct pipe_viewport_state *viewport = &ctx->viewport;
	f = CLAMP(f, 0.0, 1.0);
	n = CLAMP(n, 0.0, 1.0);

	viewport->scale[2] = 0.5 * (f - n);
	viewport->translate[2] = 0.5 * (n + f);
}

struct gl_context *gl_current_context(void)
{
	return context;
}

struct gl_context *gl_context_create(void)
{
	struct gl_context *ctx;

	ctx = (struct gl_context *)malloc(sizeof(struct gl_context));
	if (ctx == NULL)
		return NULL;

	memset(ctx, 0, sizeof(struct gl_context));

	int fd = open("/dev/gpu0", O_RDWR);
	if (fd == 0)
		return NULL;

	ctx->screen.gpu_fd = fd;
	ctx->pipe = pipe_context_create(fd);
	if (ctx->pipe == NULL)
		return NULL;

	return ctx;
}

void gl_context_destroy(struct gl_context *ctx)
{
	if (ctx == NULL)
		return;

	struct gl_screen *screen = &ctx->screen;
	struct pipe_framebuffer_state *fb = &ctx->framebuffer;
	int i;

	ctx->pipe->resource_destroy(ctx->pipe, screen->color_buf);
	ctx->pipe->resource_destroy(ctx->pipe, screen->zs_buf);
	ctx->pipe->surface_destroy(ctx->pipe, fb->zsbuf);
	for (i = 0; i < fb->nr_cbufs; i++)
		ctx->pipe->surface_destroy(ctx->pipe, fb->cbufs[i]);

	ctx->pipe->destroy(ctx->pipe);

	if (ctx->screen.gpu_fd) {
		close(ctx->screen.gpu_fd);
	}
	if (ctx->screen.fb_fd) {
		close(ctx->screen.fb_fd);
	}

	free(ctx);
}

int gl_create_window(struct gl_context *ctx)
{
	struct gl_screen *screen = &ctx->screen;
	struct fb_var_screeninfo *var = &screen->var;

	int ret = 0;
	int fd = open("/dev/fb0", O_RDWR);
	if (fd == 0) {
		return -ENODEV;
	}

	if ((ret = ioctl(fd, FBIOGET_VSCREENINFO, var))) {
		printf("GLES: fb get vscreen info ioctl failure: %e.\n", ret);
		goto out;
	}

	uint8_t cpp = var->bits_per_pixel >> 3;
	uint32_t size = var->xres_virtual * var->yres_virtual * cpp;

	screen->fb_fd = fd;
	screen->screen_size = size;
	screen->double_buffer_offset = var->xres * var->yres * cpp;

	struct pipe_resource resource_temp;
	struct pipe_surface surface_temp;
	struct pipe_surface *color_surf[2];
	struct pipe_surface *zs_surf;
	int num_cbufs = 2, i;

	/* create color texture */
	{
		resource_temp.width0 = var->xres_virtual;
		resource_temp.height0 = var->yres_virtual;
		resource_temp.cpp = cpp;
		resource_temp.bind =
			(PIPE_BIND_RENDER_TARGET | PIPE_BIND_DISPLAY_TARGET);
		screen->color_buf =
			ctx->pipe->resource_create(ctx->pipe, &resource_temp);
		if (screen->color_buf == NULL) {
			printf("GLES: failed to create color texture.\n");
			ret = -ENOMEM;
			goto out;
		}
	}

	/* create color surface */
	{
		surface_temp.cpp = resource_temp.cpp;
		surface_temp.width = var->xres;
		surface_temp.height = var->yres;
		surface_temp.offset = screen->double_buffer_offset;
		color_surf[0] = ctx->pipe->create_surface(
			ctx->pipe, screen->color_buf, &surface_temp);
		if (color_surf[0] == NULL) {
			printf("GLES: failed to get color surface 0.\n");
			ret = -ENOMEM;
			goto out;
		}

		surface_temp.offset = 0;
		color_surf[1] = ctx->pipe->create_surface(
			ctx->pipe, screen->color_buf, &surface_temp);

		if (color_surf[1] == NULL) {
			printf("GLES: failed to get color surface 1.\n");
			ret = -ENOMEM;
			goto out;
		}
	}

	/* create Z texture */
	{
		resource_temp.width0 = var->xres;
		resource_temp.height0 = var->yres;
		resource_temp.cpp = sizeof(uint32_t);
		resource_temp.bind = PIPE_BIND_DEPTH_STENCIL;
		screen->zs_buf =
			ctx->pipe->resource_create(ctx->pipe, &resource_temp);
		if (screen->zs_buf == NULL) {
			printf("GLES: failed to create Z texture.\n");
			ret = -ENOMEM;
			goto out;
		}
		// ctx->pipe->resource_transfer_map(ctx->pipe, screen->zs_buf);
	}

	/* create Z surface */
	{
		surface_temp.cpp = resource_temp.cpp;
		surface_temp.width = var->xres;
		surface_temp.height = var->yres;
		surface_temp.offset = 0;
		zs_surf = ctx->pipe->create_surface(ctx->pipe, screen->zs_buf,
						    &surface_temp);
		if (zs_surf == NULL) {
			printf("GLES: failed to get Z surface.\n");
			ret = -ENOMEM;
			goto out;
		}
	}

	/* set framebuffer state */
	{
		struct pipe_framebuffer_state *fb = &ctx->framebuffer;
		fb->nr_cbufs = num_cbufs;
		fb->width = var->xres;
		fb->height = var->yres;
		for (i = 0; i < num_cbufs; i++)
			fb->cbufs[i] = color_surf[i];
		fb->zsbuf = zs_surf;
		ctx->pipe->set_framebuffer_state(ctx->pipe, fb);
	}

out:
	return ret;
}

int gl_default_state(struct gl_context *ctx)
{
	int ret = 0;

	/* current_color */
	{
		gl_current_color(ctx, 1.0f, 1.0f, 1.0f, 1.0f);
	}

	/* clear_state */
	{
		struct pipe_clear_state *clear_state = &ctx->clear_state;
		clear_state->depth = 1.0;
		clear_state->stencil = 0;
		memset(clear_state->color.f, 0, sizeof(union pipe_color_union));
	}

	/* depth_stencil_alpha */
	{
		struct pipe_depth_stencil_alpha_state *depth_stencil =
			&ctx->depth_stencil;
		depth_stencil->depth.enabled = 0;
		depth_stencil->depth.writemask = 1;
		depth_stencil->depth.func = PIPE_FUNC_LESS;
		ctx->pipe->set_depth_stencil_alpha_state(ctx->pipe,
							 depth_stencil);
	}

	/* Transform*/
	{
		set_default_transform_no_notify(ctx);
	}

	/* viewport */
	{
		set_viewport_no_notify(ctx, 0, 0, ctx->framebuffer.width,
				       ctx->framebuffer.height);
		set_depth_range_no_notify(ctx, 0, 1);
		ctx->pipe->set_viewport_state(ctx->pipe, &ctx->viewport);
	}

	/* fs */
	{
		if ((ret = ctx->pipe->create_fs_state(ctx->pipe))) {
			goto out;
		}
	}

out:
	return ret;
}

int gl_swap_buffers(struct gl_context *ctx)
{
	struct gl_screen *screen = &ctx->screen;
	struct fb_var_screeninfo *var = &screen->var;
	struct pipe_framebuffer_state *fb = &ctx->framebuffer;
	int ret = 0;

	var->yoffset = fb->cbufs[0]->offset;
	if ((ret = ioctl(ctx->screen.fb_fd, FBIOPAN_DISPLAY, var))) {
		printf("GLES: fb pan display ioctl failure: %e.\n", ret);
		return ret;
	}

	struct pipe_surface *tmp = fb->cbufs[0];
	fb->cbufs[0] = fb->cbufs[1];
	fb->cbufs[1] = tmp;
	ctx->pipe->set_framebuffer_state(ctx->pipe, fb);

	return ret;
}

void gl_current_color(struct gl_context *ctx, GLfloat red, GLfloat green,
		      GLfloat blue, GLfloat alpha)
{
	ctx->current_color =
		(union pipe_color_union){ red, green, blue, alpha };
}

void gl_error(struct gl_context *ctx, GLenum error)
{
	if (ctx && ctx->last_error == GL_NO_ERROR) {
		ctx->last_error = error;
	}
}

GLenum gl_get_error(struct gl_context *ctx)
{
	GLenum e = ctx->last_error;
	ctx->last_error = GL_NO_ERROR;
	return e;
}

void gl_clear(struct gl_context *ctx, GLbitfield mask)
{
	struct pipe_clear_state *clear_state = &ctx->clear_state;

	ctx->pipe->clear(ctx->pipe, mask, &clear_state->color,
			 clear_state->depth, clear_state->stencil);
}

void gl_flush(struct gl_context *ctx)
{
	ctx->pipe->flush(ctx->pipe);
}

void gl_set_enable(struct gl_context *ctx, GLenum cap, GLboolean state)
{
	switch (cap) {
	case GL_DEPTH_TEST:
		ctx->depth_stencil.depth.enabled = state;
		gl_depth_stencil_alpha(ctx);
		break;
	default:
		gl_error(ctx, GL_INVALID_ENUM);
	}
}

void gl_client_state(struct gl_context *ctx, GLenum array, GLboolean state)
{
	switch (array) {
	case GL_VERTEX_ARRAY:
		ctx->vertex_pointer_state.enabled = state;
		break;
	case GL_COLOR_ARRAY:
		ctx->color_pointer_state.enabled = state;
		break;
	default:
		gl_error(ctx, GL_INVALID_ENUM);
	}
}

void gl_pointer_array(struct gl_context *ctx,
		      struct pipe_vertex_array_state *state, GLint sizeMin,
		      GLint sizeMax, GLint size, GLenum type, GLsizei stride,
		      const void *pointer)
{
	if (size < sizeMin || size > sizeMax) {
		gl_error(ctx, GL_INVALID_VALUE);
		return;
	}
	if (type != GL_FLOAT) {
		gl_error(ctx, GL_INVALID_ENUM);
		return;
	}
	if (stride < 0) {
		gl_error(ctx, GL_INVALID_VALUE);
		return;
	}

	state->size = size;
	state->stride = stride;
	state->pointer = pointer;
}

void gl_depth_range(struct gl_context *ctx, GLfloat n, GLfloat f)
{
	set_depth_range_no_notify(ctx, n, f);
	ctx->pipe->set_viewport_state(ctx->pipe, &ctx->viewport);
}

void gl_viewport(struct gl_context *ctx, GLint x, GLint y, GLsizei width,
		 GLsizei height)
{
	set_viewport_no_notify(ctx, x, y, width, height);
	ctx->pipe->set_viewport_state(ctx->pipe, &ctx->viewport);
}

void gl_loadIdentity(struct gl_context *ctx)
{
	ctx->transform_depth = 1;
	memcpy(ctx->transform, Identity, sizeof(Identity));
}



void gl_depth_stencil_alpha(struct gl_context *ctx)
{
	ctx->pipe->set_depth_stencil_alpha_state(ctx->pipe,
						 &ctx->depth_stencil);
}

static inline struct pipe_resource *pipe_buffer_create(struct pipe_context *ctx,
						       unsigned bind,
						       unsigned size)
{
	struct pipe_resource buffer;
	memset(&buffer, 0, sizeof buffer);
	buffer.cpp = 1;
	buffer.bind = bind;
	buffer.width0 = size;
	buffer.height0 = 1;
	return ctx->resource_create(ctx, &buffer);
}

void gl_draw_arrays(struct gl_context *ctx, GLenum mode, GLint first,
		    GLsizei count)
{
	struct pipe_vertex_array_state *vertex_state =
		&ctx->vertex_pointer_state;
	struct pipe_vertex_array_state *color_state = &ctx->color_pointer_state;

	if (!vertex_state->enabled) {
		return;
	}

	struct pipe_draw_info info;
	struct pipe_vertex_buffer vb;
	struct pipe_resource *rsc;
	struct nv_shaded_vertex *buffer;
	uint32_t stride = sizeof(struct nv_shaded_vertex);
	uint32_t vertex_stride = vertex_state->stride ?
					 vertex_state->stride / sizeof(float) :
					 vertex_state->size;
	uint32_t color_stride = 0;

	rsc = pipe_buffer_create(ctx->pipe, PIPE_BIND_VERTEX_BUFFER,
				 stride * count);
	if (rsc == NULL) {
		gl_error(ctx, GL_OUT_OF_MEMORY);
		return;
	}

	buffer = (struct nv_shaded_vertex *)ctx->pipe->resource_transfer_map(
		ctx->pipe, rsc);

	int i, j;
	const float *pointer =
		(float *)vertex_state->pointer + first * vertex_stride;
	const float *scale = ctx->viewport.scale;
	const float *translate = ctx->viewport.translate;
	const float *color = ctx->current_color.f;
	if (color_state->enabled) {
		color_stride = color_state->stride ?
				       color_state->stride / sizeof(float) :
				       color_state->size;
		color = (float *)color_state->pointer + first * color_stride;
	}

	// if (ctx->transform_depth == 1) {
	// 	for (i = 0; i < 4; i++) {
	// 		for (j = 0;j < 4; j++)
	// 			printf("%f ", ctx->transform[i * 4 + j]);
	// 		printf("\n");
	// 	}
	// }

	for (i = 0; i < count; i++, pointer += vertex_stride) {
		GLfloat tem[4];
		tem[0] = pointer[0];
		tem[1] = pointer[1];
		if (vertex_state->size == 3) {
			tem[2] = pointer[2];
			tem[3] = 1.0f;
			if (ctx->transform_depth == 1) {
				//printf("before rotate: x: %f, y: %f, z: %f\n", tem[0], tem[1], tem[2]);
				matvec3(tem, ctx->transform, tem);
				//printf("after rotate: x: %f, y: %f, z: %f\n", tem[0], tem[1], tem[2]);
			}
		}

		buffer[i] = (struct nv_shaded_vertex){
			.x = (int16_t)((tem[0] * scale[0]) * 16),
			.y = (int16_t)((tem[1] * -scale[1]) * 16),
			.z = 0.0,
			.rhw = 1.0,
			.r = color[0],
			.g = color[1],
			.b = color[2],
		};
		if (vertex_state->size == 3) {
			buffer[i].z = tem[2] * scale[2] + translate[2];
		}
		color += color_stride;
	};

	memset(&info, 0, sizeof(struct pipe_draw_info));
	memset(&vb, 0, sizeof(struct pipe_vertex_buffer));

	info.mode = mode;
	info.start = 0;
	info.count = count;

	vb.stride = stride;
	vb.is_user_buffer = 1;
	vb.buffer_offset = 0;
	vb.buffer.resource = rsc;

	ctx->pipe->set_vertex_buffers(ctx->pipe, &vb);
	ctx->pipe->draw_vbo(ctx->pipe, &info);
	ctx->pipe->resource_destroy(ctx->pipe, rsc);
}

void gl_translatef(struct gl_context *ctx, GLfloat x, GLfloat y, GLfloat z)
{
	GLfloat *m = ctx->transform;
	m[12] = m[0] * x + m[4] * y + m[8]  * z + m[12];
   	m[13] = m[1] * x + m[5] * y + m[9]  * z + m[13];
   	m[14] = m[2] * x + m[6] * y + m[10] * z + m[14];
  	m[15] = m[3] * x + m[7] * y + m[11] * z + m[15];
}

void gl_Rotatef(struct gl_context *ctx, GLfloat angle, GLfloat x, GLfloat y, GLfloat z)
{
	GLfloat xx, yy, zz, xy, yz, zx, xs, ys, zs, one_c, s, c;
	GLfloat m[16];
	GLboolean optimized;
	int i, j;

   s = sinf( angle * M_PI / 180.0 );
   c = cosf( angle * M_PI / 180.0 );

   memcpy(m, Identity, sizeof(Identity));
   optimized = GL_FALSE;

#define M(row,col)  m[col*4+row]

   if (x == 0.0F) {
      if (y == 0.0F) {
         if (z != 0.0F) {
            optimized = GL_TRUE;
            /* rotate only around z-axis */
            M(0,0) = c;
            M(1,1) = c;
            if (z < 0.0F) {
               M(0,1) = s;
               M(1,0) = -s;
            }
            else {
               M(0,1) = -s;
               M(1,0) = s;
            }
         }
      }
      else if (z == 0.0F) {
         optimized = GL_TRUE;
         /* rotate only around y-axis */
         M(0,0) = c;
         M(2,2) = c;
         if (y < 0.0F) {
            M(0,2) = -s;
            M(2,0) = s;
         }
         else {
            M(0,2) = s;
            M(2,0) = -s;
         }
      }
   }
   else if (y == 0.0F) {
      if (z == 0.0F) {
         optimized = GL_TRUE;
         /* rotate only around x-axis */
         M(1,1) = c;
         M(2,2) = c;
         if (x < 0.0F) {
            M(1,2) = s;
            M(2,1) = -s;
         }
         else {
            M(1,2) = -s;
            M(2,1) = s;
         }
      }
   }

   if (!optimized) {
      const GLfloat mag = sqrtf(x * x + y * y + z * z);

      if (mag <= 1.0e-4F) {
         /* no rotation, leave mat as-is */
         return;
      }

      x /= mag;
      y /= mag;
      z /= mag;


      /*
       *     Arbitrary axis rotation matrix.
       *
       *  This is composed of 5 matrices, Rz, Ry, T, Ry', Rz', multiplied
       *  like so:  Rz * Ry * T * Ry' * Rz'.  T is the final rotation
       *  (which is about the X-axis), and the two composite transforms
       *  Ry' * Rz' and Rz * Ry are (respectively) the rotations necessary
       *  from the arbitrary axis to the X-axis then back.  They are
       *  all elementary rotations.
       *
       *  Rz' is a rotation about the Z-axis, to bring the axis vector
       *  into the x-z plane.  Then Ry' is applied, rotating about the
       *  Y-axis to bring the axis vector parallel with the X-axis.  The
       *  rotation about the X-axis is then performed.  Ry and Rz are
       *  simply the respective inverse transforms to bring the arbitrary
       *  axis back to its original orientation.  The first transforms
       *  Rz' and Ry' are considered inverses, since the data from the
       *  arbitrary axis gives you info on how to get to it, not how
       *  to get away from it, and an inverse must be applied.
       *
       *  The basic calculation used is to recognize that the arbitrary
       *  axis vector (x, y, z), since it is of unit length, actually
       *  represents the sines and cosines of the angles to rotate the
       *  X-axis to the same orientation, with theta being the angle about
       *  Z and phi the angle about Y (in the order described above)
       *  as follows:
       *
       *  cos ( theta ) = x / sqrt ( 1 - z^2 )
       *  sin ( theta ) = y / sqrt ( 1 - z^2 )
       *
       *  cos ( phi ) = sqrt ( 1 - z^2 )
       *  sin ( phi ) = z
       *
       *  Note that cos ( phi ) can further be inserted to the above
       *  formulas:
       *
       *  cos ( theta ) = x / cos ( phi )
       *  sin ( theta ) = y / sin ( phi )
       *
       *  ...etc.  Because of those relations and the standard trigonometric
       *  relations, it is pssible to reduce the transforms down to what
       *  is used below.  It may be that any primary axis chosen will give the
       *  same results (modulo a sign convention) using thie method.
       *
       *  Particularly nice is to notice that all divisions that might
       *  have caused trouble when parallel to certain planes or
       *  axis go away with care paid to reducing the expressions.
       *  After checking, it does perform correctly under all cases, since
       *  in all the cases of division where the denominator would have
       *  been zero, the numerator would have been zero as well, giving
       *  the expected result.
       */

      xx = x * x;
      yy = y * y;
      zz = z * z;
      xy = x * y;
      yz = y * z;
      zx = z * x;
      xs = x * s;
      ys = y * s;
      zs = z * s;
      one_c = 1.0F - c;

      /* We already hold the identity-matrix so we can skip some statements */
      M(0,0) = (one_c * xx) + c;
      M(0,1) = (one_c * xy) - zs;
      M(0,2) = (one_c * zx) + ys;
/*    M(0,3) = 0.0F; */

      M(1,0) = (one_c * xy) + zs;
      M(1,1) = (one_c * yy) + c;
      M(1,2) = (one_c * yz) - xs;
/*    M(1,3) = 0.0F; */

      M(2,0) = (one_c * zx) - ys;
      M(2,1) = (one_c * yz) + xs;
      M(2,2) = (one_c * zz) + c;
/*    M(2,3) = 0.0F; */

/*
      M(3,0) = 0.0F;
      M(3,1) = 0.0F;
      M(3,2) = 0.0F;
      M(3,3) = 1.0F;
*/
   }
#undef M
 //   	printf("------transform------\n");
	// for (i = 0; i < 4; i++) {
	// 	for (j = 0;j < 4; j++)
	// 		printf("%f ", ctx->transform[i * 4 + j]);
	// 	printf("\n");
	// }
 //   	printf("------transform------\n");
	// for (i = 0; i < 4; i++) {
	// 	for (j = 0;j < 4; j++)
	// 		printf("%f ", m[i * 4 + j]);
	// 	printf("\n");
	// }
    matmul34(ctx->transform, ctx->transform, m);
 //    printf("------transform------\n");
	// for (i = 0; i < 4; i++) {
	// 	for (j = 0;j < 4; j++)
	// 		printf("%f ", ctx->transform[i * 4 + j]);
	// 	printf("\n");
	// }
}
