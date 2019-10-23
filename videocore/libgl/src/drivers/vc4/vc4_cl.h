#ifndef VC4_CL_H
#define VC4_CL_H

#include <types.h>

#include "vc4_packet.h"

struct vc4_bo;
struct vc4_context;

struct vc4_cl {
	void *base;
	void *next;
	void *reloc_next;
	size_t size;
};

void vc4_init_cl(struct vc4_cl *cl);
void vc4_reset_cl(struct vc4_cl *cl);
void vc4_dump_cl(void *cl, size_t size, size_t cols, const char *name);
uint32_t vc4_gem_hindex(struct vc4_context *vc4, struct vc4_bo *bo);
void cl_ensure_space(struct vc4_cl *cl, uint32_t size);

struct __attribute__((__packed__)) unaligned_16 { uint16_t x; };
struct __attribute__((__packed__)) unaligned_32 { uint32_t x; };

static inline uint32_t cl_offset(struct vc4_cl *cl)
{
	return (char *)cl->next - (char *)cl->base;
}

static inline void cl_advance(struct vc4_cl *cl, uint32_t n)
{
	cl->next += n;
}

static inline void put_unaligned_32(void *ptr, uint32_t val)
{
	struct unaligned_32 *p = (void *)ptr;
	p->x = val;
}

static inline void put_unaligned_16(void *ptr, uint16_t val)
{
	struct unaligned_16 *p = (void *)ptr;
	p->x = val;
}

static inline uint32_t get_unaligned_32(void *ptr)
{
	struct unaligned_32 *p = (void *)ptr;
	return p->x;
}

static inline uint16_t get_unaligned_16(void *ptr)
{
	struct unaligned_16 *p = (void *)ptr;
	return p->x;
}

static inline void cl_u8(struct vc4_cl *cl, uint8_t n)
{
	*(uint8_t *)cl->next = n;
	cl_advance(cl, 1);
}

static inline void cl_u16(struct vc4_cl *cl, uint16_t n)
{
	put_unaligned_16(cl->next, n);
	cl_advance(cl, 2);
}

static inline void cl_u32(struct vc4_cl *cl, uint32_t n)
{
	put_unaligned_32(cl->next, n);
	cl_advance(cl, 4);
}

static inline void cl_aligned_u32(struct vc4_cl *cl, uint32_t n)
{
	*(uint32_t *)cl->next = n;
	cl_advance(cl, 4);
}

static inline void cl_f(struct vc4_cl *cl, float f)
{
	cl_u32(cl, *((uint32_t *)&f));
}

static inline void cl_aligned_f(struct vc4_cl *cl, float f)
{
	cl_aligned_u32(cl, *((uint32_t *)&f));
}

static inline void cl_start_reloc(struct vc4_cl *cl, uint32_t n)
{
	cl_u8(cl, VC4_PACKET_GEM_HANDLES);
	cl->reloc_next = cl->next;
	cl_u32(cl, 0); /* Space where hindex will be written. */
	cl_u32(cl, 0); /* Space where hindex will be written. */
}

static inline void cl_start_shader_reloc(struct vc4_cl *cl, uint32_t n)
{
	cl->reloc_next = cl->next;

	/* Reserve the space where hindex will be written. */
	cl_advance(cl, n * 4);
}

static inline void cl_reloc(struct vc4_cl *cl, struct vc4_context *vc4,
			    struct vc4_bo *bo, uint32_t offset)
{
	put_unaligned_32(cl->reloc_next, vc4_gem_hindex(vc4, bo));
	cl->reloc_next += 4;

	cl_u32(cl, offset);
}

#endif /* VC4_CL_H */
