#ifndef PIPE_STATE_H
#define PIPE_STATE_H

#include <types.h>

#include "p_defines.h"

/**
 * Implementation limits
 */
#define PIPE_MAX_ATTRIBS          32
#define PIPE_MAX_CLIP_PLANES       8
#define PIPE_MAX_COLOR_BUFS        8
#define PIPE_MAX_CONSTANT_BUFFERS 32
#define PIPE_MAX_SAMPLERS         18 /* 16 public + 2 driver internal */
#define PIPE_MAX_SHADER_INPUTS    80 /* 32 GENERIC + 32 PATCH + 16 others */
#define PIPE_MAX_SHADER_OUTPUTS   80 /* 32 GENERIC + 32 PATCH + 16 others */
#define PIPE_MAX_SHADER_SAMPLER_VIEWS 32
#define PIPE_MAX_SHADER_BUFFERS   32
#define PIPE_MAX_SHADER_IMAGES    32
#define PIPE_MAX_TEXTURE_LEVELS   16
#define PIPE_MAX_SO_BUFFERS        4
#define PIPE_MAX_SO_OUTPUTS       64
#define PIPE_MAX_VIEWPORTS        16
#define PIPE_MAX_CLIP_OR_CULL_DISTANCE_COUNT 8
#define PIPE_MAX_CLIP_OR_CULL_DISTANCE_ELEMENT_COUNT 2

struct pipe_viewport_state {
	float scale[3];
	float translate[3];
};

struct pipe_depth_state {
	unsigned enabled : 1; /**< depth test enabled? */
	unsigned writemask : 1; /**< allow depth buffer writes? */
	unsigned func : 3; /**< depth test func (PIPE_FUNC_x) */
	unsigned bounds_test : 1; /**< depth bounds test enabled? */
	float bounds_min; /**< minimum depth bound */
	float bounds_max; /**< maximum depth bound */
};

struct pipe_stencil_state {
	unsigned enabled : 1; /**< stencil[0]: stencil enabled, stencil[1]: two-side enabled */
	unsigned func : 3; /**< PIPE_FUNC_x */
	unsigned fail_op : 3; /**< PIPE_STENCIL_OP_x */
	unsigned zpass_op : 3; /**< PIPE_STENCIL_OP_x */
	unsigned zfail_op : 3; /**< PIPE_STENCIL_OP_x */
	unsigned valuemask : 8;
	unsigned writemask : 8;
};

struct pipe_alpha_state {
	unsigned enabled : 1;
	unsigned func : 3; /**< PIPE_FUNC_x */
	float ref_value; /**< reference value */
};

struct pipe_depth_stencil_alpha_state {
	struct pipe_depth_state depth;
	struct pipe_stencil_state stencil[2]; /**< [0] = front, [1] = back */
	struct pipe_alpha_state alpha;
};

struct pipe_framebuffer_state {
	unsigned width, height;

	/** multiple color buffers for multiple render targets */
	unsigned nr_cbufs;
	struct pipe_surface *cbufs[PIPE_MAX_COLOR_BUFS];

	struct pipe_surface *zsbuf; /**< Z/stencil buffer */
};

/**
 * A view into a texture that can be bound to a color render target /
 * depth stencil attachment point.
 */
struct pipe_surface {
	struct pipe_resource *texture; /**< resource into which this is a view  */
	struct pipe_context *context; /**< context this surface belongs to */

	/* XXX should be pipe_format */
	uint32_t cpp; /**< bytes per pixel */

	uint32_t width; /**< logical width in pixels */
	uint32_t height; /**< logical height in pixels */
	uint32_t offset;
};

/**
 * A memory object/resource such as a vertex buffer or texture.
 */
struct pipe_resource {
	/* XXX should be pipe_format */
	uint32_t cpp; /**< bytes per pixel */

	uint32_t width0;
	uint32_t height0;

	uint32_t bind; /**< bitmask of PIPE_BIND_x */
};

/**
 * A vertex buffer.
 */
struct pipe_vertex_buffer {
	uint16_t stride; /**< stride to same attrib in next vertex, in bytes */
	bool is_user_buffer;
	unsigned buffer_offset; /**< offset to start of data in buffer, in bytes */

	union {
		struct pipe_resource *resource; /**< the actual buffer */
		const void *user; /**< pointer to a user buffer */
	} buffer;
};

/**
 * Information to describe a draw_vbo call.
 */
struct pipe_draw_info {
	uint8_t index_size; /**< if 0, the draw is not indexed. */
	enum pipe_prim_type mode : 8; /**< the mode of the primitive */
	unsigned has_user_indices : 1; /**< if true, use index.user_buffer */

	unsigned start;
	unsigned count; /**< number of vertices */

	union {
		//   struct pipe_resource *resource;  /**< real buffer */
		const void *user; /**< pointer to a user buffer */
	} index;
};

struct pipe_clear_state {
	union pipe_color_union color;
	double depth;
	unsigned stencil;
};

struct pipe_vertex_array_state {
	uint8_t size;
	uint16_t stride;
	bool enabled;
	const void *pointer;
};

#endif // PIPE_STATE_H
