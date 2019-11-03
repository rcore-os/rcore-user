#![no_std]
#![no_main]
#![feature(alloc)]

extern crate alloc;
#[macro_use]
extern crate rcore_user;

use alloc::vec::Vec;
use core::ptr;

use rcore_user::io::get_line;
use rcore_user::ulib::{exit, fork, gettime_msec, sleep, waitpid};

fn sleepy(pid: usize) {
    let time: usize = 1;
    for i in 0..10 {
        sleep(time);
        println!("sleep {} x {} slices.", i + 1, time);
    }
    exit(0);
}

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    let time = gettime_msec();
    let mut pid1: usize = 0;
    let mut exit_code = 0;

    let pid1 = fork() as usize;

    if pid1 == 0 {
        sleepy(pid1);
    } else {
        println!("child id is {}", pid1);
    }

    assert_eq!(waitpid(pid1, &mut exit_code), pid1 as i32);
    assert_eq!(exit_code, 0);

    println!(
        "use {} msecs: {} to {}.",
        gettime_msec() - time,
        time,
        gettime_msec()
    );
    println!("sleep pass.");
}
