#include <regdef.h>

.text
.globl __start
.global _start

# seems different toolchains look for different entry points
_start:
__start:
    # call user-program function
    lw    a0, 0(sp)
    addiu a1, sp, 8
    b     umain
    nop
