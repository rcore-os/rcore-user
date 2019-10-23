#ifndef PIPE_DEFINES_H
#define PIPE_DEFINES_H

/**
 * Inequality functions.  Used for depth test, stencil compare, alpha
 * test, shadow compare, etc.
 */
#define PIPE_FUNC_NEVER    0
#define PIPE_FUNC_LESS     1
#define PIPE_FUNC_EQUAL    2
#define PIPE_FUNC_LEQUAL   3
#define PIPE_FUNC_GREATER  4
#define PIPE_FUNC_NOTEQUAL 5
#define PIPE_FUNC_GEQUAL   6
#define PIPE_FUNC_ALWAYS   7

/**
 * Clear buffer bits
 */
#define PIPE_CLEAR_DEPTH        (1 << 0)
#define PIPE_CLEAR_STENCIL      (1 << 1)
#define PIPE_CLEAR_COLOR0       (1 << 2)
#define PIPE_CLEAR_COLOR1       (1 << 3)
#define PIPE_CLEAR_COLOR2       (1 << 4)
#define PIPE_CLEAR_COLOR3       (1 << 5)
#define PIPE_CLEAR_COLOR4       (1 << 6)
#define PIPE_CLEAR_COLOR5       (1 << 7)
#define PIPE_CLEAR_COLOR6       (1 << 8)
#define PIPE_CLEAR_COLOR7       (1 << 9)
/** Combined flags */
/** All color buffers currently bound */
#define PIPE_CLEAR_COLOR        (PIPE_CLEAR_COLOR0 | PIPE_CLEAR_COLOR1 | \
                                 PIPE_CLEAR_COLOR2 | PIPE_CLEAR_COLOR3 | \
                                 PIPE_CLEAR_COLOR4 | PIPE_CLEAR_COLOR5 | \
                                 PIPE_CLEAR_COLOR6 | PIPE_CLEAR_COLOR7)
#define PIPE_CLEAR_DEPTHSTENCIL (PIPE_CLEAR_DEPTH | PIPE_CLEAR_STENCIL)

/**
 * Resource binding flags -- state tracker must specify in advance all
 * the ways a resource might be used.
 */
#define PIPE_BIND_DEPTH_STENCIL        (1 << 0) /* create_surface */
#define PIPE_BIND_RENDER_TARGET        (1 << 1) /* create_surface */
#define PIPE_BIND_BLENDABLE            (1 << 2) /* create_surface */
#define PIPE_BIND_SAMPLER_VIEW         (1 << 3) /* create_sampler_view */
#define PIPE_BIND_VERTEX_BUFFER        (1 << 4) /* set_vertex_buffers */
#define PIPE_BIND_INDEX_BUFFER         (1 << 5) /* draw_elements */
#define PIPE_BIND_CONSTANT_BUFFER      (1 << 6) /* set_constant_buffer */
#define PIPE_BIND_DISPLAY_TARGET       (1 << 7) /* flush_front_buffer */
#define PIPE_BIND_TRANSFER_WRITE       (1 << 8) /* transfer_map */
#define PIPE_BIND_TRANSFER_READ        (1 << 9) /* transfer_map */
#define PIPE_BIND_STREAM_OUTPUT        (1 << 10) /* set_stream_output_buffers */
#define PIPE_BIND_CURSOR               (1 << 11) /* mouse cursor */
#define PIPE_BIND_CUSTOM               (1 << 12) /* state-tracker/winsys usages */
#define PIPE_BIND_GLOBAL               (1 << 13) /* set_global_binding */
#define PIPE_BIND_SHADER_BUFFER        (1 << 14) /* set_shader_buffers */
#define PIPE_BIND_SHADER_IMAGE         (1 << 15) /* set_shader_images */
#define PIPE_BIND_COMPUTE_RESOURCE     (1 << 16) /* set_compute_resources */
#define PIPE_BIND_COMMAND_ARGS_BUFFER  (1 << 17) /* pipe_draw_info.indirect */

struct nv_shaded_vertex {
	uint16_t x, y;
	float z, rhw;
	float r, g, b;
};

union pipe_color_union {
	float f[4];
	int i[4];
	unsigned int ui[4];
};

/**
 * Primitive types:
 */
enum pipe_prim_type {
   PIPE_PRIM_POINTS,
   PIPE_PRIM_LINES,
   PIPE_PRIM_LINE_LOOP,
   PIPE_PRIM_LINE_STRIP,
   PIPE_PRIM_TRIANGLES,
   PIPE_PRIM_TRIANGLE_STRIP,
   PIPE_PRIM_TRIANGLE_FAN,
   PIPE_PRIM_QUADS,
   PIPE_PRIM_QUAD_STRIP,
   PIPE_PRIM_POLYGON,
   PIPE_PRIM_LINES_ADJACENCY,
   PIPE_PRIM_LINE_STRIP_ADJACENCY,
   PIPE_PRIM_TRIANGLES_ADJACENCY,
   PIPE_PRIM_TRIANGLE_STRIP_ADJACENCY,
   PIPE_PRIM_PATCHES,
   PIPE_PRIM_MAX,
};

#endif
