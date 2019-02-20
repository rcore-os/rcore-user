#include <stdio.h>
#include <ulib.h>

int
main(void) {
#if defined(__x86_64__) || defined(__i386__)
    asm volatile("int $14");
    panic("FAIL: T.T\n");
#endif
}

