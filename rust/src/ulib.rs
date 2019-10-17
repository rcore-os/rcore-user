

use crate::syscall::{sys_sleep, sys_vfork, sys_wait, sys_get_time, sys_exit, enlarge_heap};



pub fn sleep(time: usize) -> i32 {
    sys_sleep(time)
}

pub fn gettime_msec() -> u32{
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
    println!("BUG: exit failed.");
    while true {};
}