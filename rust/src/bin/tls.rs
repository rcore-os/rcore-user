#![no_std]
#![no_main]
#![feature(asm)]

#[macro_use]
extern crate rcore_user;

use rcore_user::syscall::{sys_arch_prctl, sys_fork, sys_getpid, sys_sleep};

fn set_tls(tls: usize, pid: usize) {
    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    unsafe {
        asm!("mv tp, $0" : : "r"(tls));
    }
    #[cfg(target_arch = "x86_64")]
    unsafe {
        static mut DATA: [usize; 1024] = [0; 1024];
        DATA[pid] = tls;
        // set fs base
        sys_arch_prctl(0x1002, &DATA[pid] as *const usize as usize);
    }
}

fn get_tls() -> usize {
    let mut tls: usize = 0;
    #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
    unsafe {
        asm!("mv $0, tp" : "=r"(tls) :);
    }
    #[cfg(target_arch = "x86_64")]
    unsafe {
        asm!("mov %fs:0, $0" : "=r"(tls) :);
    }
    tls
}

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    println!("I am going to set TLS specific registers");
    println!("And see if it changes between context switch");
    sys_fork();
    sys_fork();
    let pid = sys_getpid();
    for i in 0..10 {
        let magic = 0xcafebabe;
        set_tls(magic + i, pid as usize);
        sys_sleep(1);
        assert_eq!(get_tls(), magic + i);
        println!("pid {} time {}: working", pid, i);
    }
}
