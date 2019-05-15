.text
.globl _start
_start:
    # set ebp for backtrace
    movq $0x0, %rbp

    # move down the esp register
    # since it may cause page fault in backtrace
    subq $0x20, %rsp

    # call user-program function
    # according to fastcall ABI, the first 6 parameters are in registes
    # so we do not need to copy (argc, argv) as on i386
    call umain

    
