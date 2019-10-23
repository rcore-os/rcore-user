#include <fcntl.h>
#include <malloc.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <stdio.h>

#include "vc4_cl.h"
#include "vc4_drm.h"
#include "vc4_bufmgr.h"

struct vc4_bo *vc4_bo_alloc(struct vc4_context *vc4, size_t size)
{
	struct drm_vc4_create_bo create;
	struct vc4_bo *bo = NULL;
	int ret;

	if (!size)
		return NULL;

	size = ROUNDUP(size, 4096);

	bo = (struct vc4_bo *)malloc(sizeof(struct vc4_bo));
	if (bo == NULL) {
		return NULL;
	}

	memset(bo, 0, sizeof(struct vc4_bo));
	memset(&create, 0, sizeof(create));
	create.size = size;
	ret = ioctl(vc4->fd, DRM_IOCTL_VC4_CREATE_BO, &create);
	if (ret != 0) {
		printf("GLES: alloc bo ioctl failure: %e.\n", ret);
		free(bo);
		return NULL;
	}

	bo->vc4 = vc4;
	bo->size = size;
	bo->handle = create.handle;

	vc4_bo_reference_init(bo, 1);

	list_init(&bo->bo_link);
	list_add_before(&vc4->bo_list, &bo->bo_link);

	return bo;
}

struct vc4_bo *vc4_bo_alloc_fb(struct vc4_context *vc4)
{
	struct drm_vc4_create_bo create;
	struct vc4_bo *bo = NULL;
	int ret;

	bo = (struct vc4_bo *)malloc(sizeof(struct vc4_bo));
	if (bo == NULL) {
		return NULL;
	}

	memset(bo, 0, sizeof(struct vc4_bo));
	memset(&create, 0, sizeof(create));
	create.flags = VC4_CREATE_BO_IS_FRAMEBUFFER;
	ret = ioctl(vc4->fd, DRM_IOCTL_VC4_CREATE_BO, &create);
	if (ret != 0) {
		printf("GLES: alloc framebuffer bo ioctl failure: %e.\n", ret);
		free(bo);
		return NULL;
	}

	bo->vc4 = vc4;
	bo->size = create.size;
	bo->handle = create.handle;

	vc4_bo_reference_init(bo, 1);

	list_init(&bo->bo_link);
	list_add_before(&vc4->bo_list, &bo->bo_link);

	return bo;
}

void vc4_bo_free(struct vc4_bo *bo)
{
	int ret;

	if (bo == NULL) {
		return;
	}

	if (bo->map) {
		munmap(bo->map, bo->size);
	}

	struct drm_vc4_free_bo f;
	memset(&f, 0, sizeof(f));

	f.handle = bo->handle;
	ret = ioctl(bo->vc4->fd, DRM_IOCTL_VC4_FREE_BO, &f);
	if (ret != 0) {
		printf("GLES: free bo ioctl failure: %e.\n", ret);
	}

	free(bo);
}

void *vc4_bo_map(struct vc4_bo *bo)
{
	int ret;

	if (bo == NULL) {
		return NULL;
	}

	if (bo->map)
		return bo->map;

	struct drm_vc4_mmap_bo map;
	memset(&map, 0, sizeof(map));

	map.handle = bo->handle;
	ret = ioctl(bo->vc4->fd, DRM_IOCTL_VC4_MMAP_BO, &map);
	if (ret != 0) {
		printf("GLES: map ioctl failure: %e.\n", ret);
		return NULL;
	}

	bo->map = (void *)map.offset;

	return bo->map;
}
