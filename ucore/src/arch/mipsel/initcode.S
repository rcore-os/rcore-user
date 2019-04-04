#include <regdef.h>

.text
.globl _start
_start:
    # call user-program function
    lw    a0, 0(sp)
    addiu a1, sp, 8
    b     umain
    nop
