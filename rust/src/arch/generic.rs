//! Unimplemented platforms.

#[no_mangle]
extern "C" fn rcore_user_thread_init() {
    panic!("thread not implemented on this platform!");
}

#[no_mangle]
extern "C" fn rcore_user_thread_clone_impl(
    f: usize,
    flags: usize,
    stack: usize,
    arg: usize,
    ptid: *mut u32,
    ctid: *mut u32,
    tls: usize,
) {
    panic!("clone_impl unimplemented!");
}

#[no_mangle]
extern "C" fn rcore_user_thread_unmmap_and_exit(_stack: usize, _stack_size: usize) -> ! {
    panic!("thread epilogue not implemented.");
}
