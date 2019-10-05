#ifndef __LIBS_X86_H__
#define __LIBS_X86_H__

#include <defs.h>

#define do_div(n,base) ({					\
	uint32_t __base = (base);				\
	uint32_t __rem;						\
	__rem = ((uint64_t)(n)) % __base;			\
	(n) = ((uint64_t)(n)) / __base;				\
	__rem;							\
 })

#endif /* !__LIBS_X86_H__ */

