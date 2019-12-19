#ifndef VC4_DRM_H
#define VC4_DRM_H

#include <types.h>

#define DRM_IOCTL_VC4_SUBMIT_CL                         0x00
#define DRM_IOCTL_VC4_WAIT_SEQNO                        0x01
#define DRM_IOCTL_VC4_WAIT_BO                           0x02
#define DRM_IOCTL_VC4_CREATE_BO                         0x03
#define DRM_IOCTL_VC4_MMAP_BO                           0x04
#define DRM_IOCTL_VC4_CREATE_SHADER_BO                  0x05
#define DRM_IOCTL_VC4_GET_HANG_STATE                    0x06
#define DRM_IOCTL_VC4_GET_PARAM                         0x07
#define DRM_IOCTL_VC4_SET_TILING                        0x08
#define DRM_IOCTL_VC4_GET_TILING                        0x09
#define DRM_IOCTL_VC4_LABEL_BO                          0x0a
#define DRM_IOCTL_VC4_FREE_BO                           0x0b

struct drm_vc4_submit_rcl_surface {
	__u32 hindex; /* Handle index, or ~0 if not present. */
	__u32 offset; /* Offset to start of buffer. */
	/*
	 * Bits for either render config (color_write) or load/store packet.
	 * Bits should all be 0 for MSAA load/stores.
	 */
	__u16 bits;

#define VC4_SUBMIT_RCL_SURFACE_READ_IS_FULL_RES		(1 << 0)
	__u16 flags;
};

struct drm_vc4_submit_cl {
	/* Pointer to the binner command list.
	 *
	 * This is the first set of commands executed, which runs the
	 * coordinate shader to determine where primitives land on the screen,
	 * then writes out the state updates and draw calls necessary per tile
	 * to the tile allocation BO.
	 */
	__u64 bin_cl;

	/* Pointer to the shader records.
	 *
	 * Shader records are the structures read by the hardware that contain
	 * pointers to uniforms, shaders, and vertex attributes.  The
	 * reference to the shader record has enough information to determine
	 * how many pointers are necessary (fixed number for shaders/uniforms,
	 * and an attribute count), so those BO indices into bo_handles are
	 * just stored as __u32s before each shader record passed in.
	 */
	__u64 shader_rec;

	/* Pointer to uniform data and texture handles for the textures
	 * referenced by the shader.
	 *
	 * For each shader state record, there is a set of uniform data in the
	 * order referenced by the record (FS, VS, then CS).  Each set of
	 * uniform data has a __u32 index into bo_handles per texture
	 * sample operation, in the order the QPU_W_TMUn_S writes appear in
	 * the program.  Following the texture BO handle indices is the actual
	 * uniform data.
	 *
	 * The individual uniform state blocks don't have sizes passed in,
	 * because the kernel has to determine the sizes anyway during shader
	 * code validation.
	 */
	__u64 uniforms;
	__u64 bo_handles;

	/* Size in bytes of the binner command list. */
	__u32 bin_cl_size;
	/* Size in bytes of the set of shader records. */
	__u32 shader_rec_size;
	/* Number of shader records.
	 *
	 * This could just be computed from the contents of shader_records and
	 * the address bits of references to them from the bin CL, but it
	 * keeps the kernel from having to resize some allocations it makes.
	 */
	__u32 shader_rec_count;
	/* Size in bytes of the uniform state. */
	__u32 uniforms_size;

	/* Number of BO handles passed in (size is that times 4). */
	__u32 bo_handle_count;

	/* RCL setup: */
	__u16 width;
	__u16 height;
	__u8 min_x_tile;
	__u8 min_y_tile;
	__u8 max_x_tile;
	__u8 max_y_tile;
	struct drm_vc4_submit_rcl_surface color_read;
	struct drm_vc4_submit_rcl_surface color_write;
	struct drm_vc4_submit_rcl_surface zs_read;
	struct drm_vc4_submit_rcl_surface zs_write;
	struct drm_vc4_submit_rcl_surface msaa_color_write;
	struct drm_vc4_submit_rcl_surface msaa_zs_write;
	__u32 clear_color[2];
	__u32 clear_z;
	__u8 clear_s;

	__u32 pad:24;

#define VC4_SUBMIT_CL_USE_CLEAR_COLOR			(1 << 0)
	__u32 flags;

	/* Returned value of the seqno of this render job (for the
	 * wait ioctl).
	 */
	__u64 seqno;
};

struct drm_vc4_create_bo {
	__u32 size;
	/** Returned GEM handle for the BO. */
	__u32 handle;
#define VC4_CREATE_BO_IS_FRAMEBUFFER			(1 << 0)
	uint32_t flags;
};

struct drm_vc4_mmap_bo {
	/** Handle for the object being mapped. */
	__u32 handle;
	/** offset into the drm node to use for subsequent mmap call. */
	__u64 offset;
};

struct drm_vc4_free_bo {
	/** Handle for the object to free. */
	__u32 handle;
};

#endif // VC4_DRM_H
