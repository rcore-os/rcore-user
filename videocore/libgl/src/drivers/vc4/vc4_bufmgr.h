#ifndef VC4_BUFMGR_H
#define VC4_BUFMGR_H

#include <list.h>
#include <types.h>
#include <atomic.h>

#include "vc4_context.h"

struct vc4_bo {
	atomic_t ref;
	struct vc4_context *vc4;
	size_t size;
	uint32_t handle;
	void *map;

	list_entry_t bo_link;
};

#define le2bo(le, member) to_struct((le), struct vc4_bo, member)

struct vc4_bo *vc4_bo_alloc(struct vc4_context *vc4, size_t size);
struct vc4_bo *vc4_bo_alloc_fb(struct vc4_context *vc4);
void vc4_bo_free(struct vc4_bo *bo);
void *vc4_bo_map(struct vc4_bo *bo);

static inline void vc4_bo_reference_init(struct vc4_bo *bo, unsigned count)
{
	atomic_set(&(bo->ref), count);
}

static inline void vc4_bo_reference(struct vc4_bo *bo)
{
	atomic_add_return(&(bo->ref), 1);
}

static inline void vc4_bo_unreference(struct vc4_bo *bo)
{
	if (bo && atomic_sub_return(&(bo->ref), 1) == 0) {
		list_del(&bo->bo_link);
		vc4_bo_free(bo);
	}
}

#endif // VC4_BUFMGR_H
