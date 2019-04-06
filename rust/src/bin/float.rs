#![no_std]
#![no_main]
#![feature(asm)]

#[macro_use]
extern crate rcore_user;

use rcore_user::syscall::*;

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    println!("Going to test floating point arithmetics");
    println!("And see if it works with context switch");
    sys_vfork();
    sys_vfork();
    let pid = sys_getpid();
    for i in 0..10 {
        let a = pid as f32;
        let b = 1.0_f32;
        let c_1 = a + b;
        sys_sleep(1);
        let c_2 = (pid + 1) as f32;
        if c_1 - c_2 < 1e-4 && c_1 - c_2 > -1e-4 {
            println!("pid {} time {}: working", pid, i);
        }
    }
}
