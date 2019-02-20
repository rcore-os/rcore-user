// See LICENSE for license details.

#ifndef __LIBS_AARCH64_H__
#define __LIBS_AARCH64_H__

#define do_div(n, base)                              \
    ({                                               \
        int __res;                                   \
        __res = ((unsigned long)n) % (unsigned)base; \
        n = ((unsigned long)n) / (unsigned)base;     \
        __res;                                       \
    })

#endif
