#ifndef __LIBS_TYPES_H__
#define __LIBS_TYPES_H__

#ifndef NULL
#define NULL ((void *)0)
#endif

#define CHAR_BIT        8

/* Represents true-or-false values */
typedef int bool;

#ifndef true
#define true 1
#endif

#ifndef false
#define false 0
#endif

/* Explicitly-sized versions of integer types */
typedef char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned int uint32_t;
typedef long long int64_t;
typedef unsigned long long uint64_t;

#if defined(__LP64__) || defined(__64BIT__) || defined(_LP64)
#ifndef __UCORE_64__
#define __UCORE_64__
#endif
#endif

/* *
 * We use pointer types to represent addresses,
 * uintptr_t to represent the numerical values of addresses.
 *
 * */


/* Pointers and addresses are 64 bits long in 64-bit platform. */
typedef long uintptr_t;

/* sem_t is used for semaphore id */
typedef uintptr_t sem_t;

typedef uint8_t __u8;
typedef uint16_t __u16;
typedef uint32_t __u32;
typedef uint64_t __u64;

/* *
 * Rounding operations (efficient when n is a power of 2)
 * Round down to the nearest multiple of n
 * */
#define ROUNDDOWN(a, n) ({                                          \
            size_t __a = (size_t)(a);                               \
            (typeof(a))(__a - __a % (n));                           \
        })

/* Round up to the nearest multiple of n */
#define ROUNDUP(a, n) ({                                            \
            size_t __n = (size_t)(n);                               \
            (typeof(a))(ROUNDDOWN((size_t)(a) + __n - 1, __n));     \
        })

/* Round up the result of dividing of n */
#define ROUNDUP_DIV(a, n) ({                                        \
            uint32_t __n = (uint32_t)(n);                           \
            (typeof(a))(((a) + __n - 1) / __n);                     \
        })

/* Return the offset of 'member' relative to the beginning of a struct type */
#define offsetof(type, member)                                      \
    ((size_t)(&((type *)0)->member))

/* *
 * to_struct - get the struct from a ptr
 * @ptr:    a struct pointer of member
 * @type:   the type of the struct this is embedded in
 * @member: the name of the member within the struct
 * */
#define to_struct(ptr, type, member)                               \
    ((type *)((char *)(ptr) - offsetof(type, member)))

#endif /* !__LIBS_TYPES_H__ */
