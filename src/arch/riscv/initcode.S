#include "arch.h"

.text
.globl _start
_start:
    # set gp
.option push
.option norelax
1:  auipc gp, %pcrel_hi(__global_pointer$)
    addi  gp, gp, %pcrel_lo(1b)
.option pop

    # call user-program function
    LOAD a0, 0(sp)
    addi a1, sp, (__riscv_xlen / 8)
    call umain
1:  j 1b
