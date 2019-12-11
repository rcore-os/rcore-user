use crate::syscall::{enlarge_heap, sys_exit, sys_get_time, sys_sleep, sys_vfork, sys_wait};

pub fn sleep(time: usize) -> i32 {
    sys_sleep(time)
}

pub fn gettime_msec() -> u32 {
    sys_get_time() as u32
}

pub fn fork() -> i32 {
    sys_vfork()
}

pub fn waitpid(pid: usize, code: *mut i32) -> i32 {
    sys_wait(pid, code)
}

pub fn exit(error_code: usize) {
    sys_exit(error_code);
    panic!("BUG: exit failed");
}
