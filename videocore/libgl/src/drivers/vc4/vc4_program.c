#include <err.h>
#include <errno.h>
#include <types.h>
#include <string.h>

#include "vc4_bufmgr.h"
#include "vc4_context.h"

static int vc4_create_fs(struct pipe_context *pctx)
{
	struct vc4_context *vc4 = vc4_context(pctx);

	static const uint32_t ins[] = {
		0x00000000, 0xe0024967, /* load_imm r5, nop, 0x00000000 (0.000000) */
		0x958c0dad, 0x11724823, /* mov r0, vary ; mov r3.8d, r5 */
		0x818c0176, 0x10024821, /* fadd r0, r0, r5 ; mov r1, vary */
		0x818c0376, 0x40024862, /* sig_wait_score fadd r1, r1, r5 ; mov r2, vary */
		0x81000540, 0x114248a3, /* fadd r2, r2, r5 ; mov r3.8a, r0 */
		0x80000009, 0x115049e3, /* nop nop, r0, r0 ; mov r3.8b, r1 */
		0x80000012, 0x116049e3, /* nop nop, r0, r0 ; mov r3.8c, r2 */
		0x00000000, 0x100009e7, /* nop nop, r0, r0 ; nop nop, r0, r0 */
		0x150006c0, 0x30020ba7, /* sig_end mov tlb_color_all, r3 ; nop nop, r0, r0 */
		0x00000000, 0x100009e7, /* nop nop, r0, r0 ; nop nop, r0, r0 */
		0x00000000, 0x500009e7, /* sig_unlock_score nop nop, r0, r0 ; nop nop, r0, r0 */
	};

	struct vc4_bo *fs = vc4_bo_alloc(vc4, sizeof(ins));
	void *map = vc4_bo_map(fs);
	if (map == NULL) {
		return -ENOMEM;
	}
	memcpy(map, ins, sizeof(ins));

	struct vc4_bo *uniforms = vc4_bo_alloc(vc4, 0x1000);
	if (uniforms == NULL) {
		return -ENOMEM;
	}

	vc4->prog.fs = fs;
	vc4->uniforms = uniforms;

	return 0;
}

static void vc4_update_compiled_fs(struct vc4_context *vc4, uint8_t prim_mode)
{
	if (!(vc4->dirty &
	      (VC4_DIRTY_PRIM_MODE | VC4_DIRTY_BLEND | VC4_DIRTY_FRAMEBUFFER |
	       VC4_DIRTY_ZSA | VC4_DIRTY_RASTERIZER | VC4_DIRTY_FRAGTEX |
	     VC4_DIRTY_UNCOMPILED_FS))) {
		return;
	}

	uint32_t *map = vc4->prog.fs->map;
	if (vc4->zsa.base.depth.enabled) {
		/* mov tlb_z, rb15 ; nop nop, r0, r0 */
		map[14] = 0x1500ffc0;
		map[15] = 0x10020b27;
	} else {
		/* nop nop, r0, r0 ; nop nop, r0, r0 */
		map[14] = 0x00000000;
		map[15] = 0x100009e7;
	}
}

static void vc4_update_compiled_vs(struct vc4_context *vc4, uint8_t prim_mode)
{
}

void vc4_update_compiled_shaders(struct vc4_context *vc4, uint8_t prim_mode)
{
	vc4_update_compiled_fs(vc4, prim_mode);
	vc4_update_compiled_vs(vc4, prim_mode);
}

void vc4_program_init(struct pipe_context *pctx)
{
	pctx->create_fs_state = vc4_create_fs;
}
