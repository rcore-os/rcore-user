//fn ___clone_impl(f: usize, flags: usize, stack: usize, arg: usize, ptid: *mut u32, ctid: *mut u32, tls: usize);
//                 a0        a1            a2            a3          a4              a5              a6
// syscall:   SYS_CLONE  flags: usize, newsp: usize, parent_tid: *mut u32, child_tid: *mut u32, newtls: usize,
//            a7         a0            a1            a2                    a3                   a4

global_asm!(
    r#"
.global rcore_user_thread_clone_impl
rcore_user_thread_clone_impl:
    addi a2, a2, -16
    sd a0, 0(a2) # f
    sd a3, 8(a2) # arg
    mv a0, a1
    mv a1, a2
    mv a2, a4
    mv a3, a5
    mv a4, a6
    li a7, 220 # SYS_CLONE
    ecall
    beqz a0, 1f
    # parent
    ret
    # child
1:
    ld a1, 0(sp) # f
    ld a0, 8(sp) # arg
    jalr a1
    # exit
    li a7, 93 # SYS_EXIT
    ecall
"#
);

global_asm!(
    r#"
.global rcore_user_thread_unmmap_and_exit
rcore_user_thread_unmmap_and_exit:
# munmap
li a7, 215
ecall
# exit
li a0, 0
li a7, 93 # SYS_EXIT
ecall
"#
);

global_asm!(
    r#"
.global rcore_user_thread_init
rcore_user_thread_init:
    j rcore_user_thread_init_riscv
"#
);
#[no_mangle]
extern "C" fn rcore_user_thread_init_riscv() {}
