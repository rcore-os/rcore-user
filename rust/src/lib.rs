#![no_std]
#![feature(llvm_asm)]
#![feature(lang_items)]
#![feature(panic_info_message)]
#![feature(linkage)]
#![feature(global_asm)]

extern crate alloc;
extern crate rlibc;

#[macro_use]
pub mod io;
pub mod lang_items;
pub mod syscall;
pub mod thread;
pub mod ulib;

#[cfg(target_arch = "riscv64")]
#[path = "arch/riscv64/mod.rs"]
pub mod arch;

#[cfg(not(target_arch = "riscv64"))]
#[path = "arch/generic.rs"]
pub mod arch;
use buddy_system_allocator::LockedHeap;

#[global_allocator]
static ALLOCATOR: LockedHeap = LockedHeap::empty();
