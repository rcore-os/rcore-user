#![no_std]
#![feature(asm)]
#![feature(alloc)]
#![feature(lang_items)]
#![feature(panic_info_message)]
#![feature(linkage)]
#![feature(compiler_builtins_lib)]

extern crate alloc;

#[macro_use]
pub mod io;
pub mod lang_items;
pub mod syscall;
pub mod ulib;

use buddy_system_allocator::LockedHeap;

#[global_allocator]
static ALLOCATOR: LockedHeap = LockedHeap::empty();

use crate::syscall::{sys_sleep, sys_vfork, sys_wait, sys_get_time, sys_exit};

pub fn sleep(time: usize) -> i32 {
    sys_sleep(time)
}
