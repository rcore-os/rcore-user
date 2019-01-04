.text
.globl _start
_start:
    # call user-program function
    ldr x0, [sp]
    add x1, sp, #8
    bl umain
1:  b 1b
