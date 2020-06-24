#![no_std]
#![feature(llvm_asm)]
#![feature(lang_items)]
#![feature(panic_info_message)]
#![feature(linkage)]

extern crate alloc;
extern crate rlibc;

#[macro_use]
pub mod io;
pub mod lang_items;
pub mod syscall;
pub mod ulib;

use buddy_system_allocator::LockedHeap;

#[global_allocator]
static ALLOCATOR: LockedHeap = LockedHeap::empty();
