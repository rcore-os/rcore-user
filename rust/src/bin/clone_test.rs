#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;
extern crate alloc;
use alloc::boxed::Box;
use alloc::sync::Arc;
use alloc::vec::Vec;
use core::sync::atomic::AtomicUsize;
use core::sync::atomic::Ordering::*;
use spin::Mutex;
static LOGGER_LOCK: Mutex<()> = Mutex::new(());
use rcore_user::syscall::sys_clone;
use rcore_user::ulib::sleep;
type Counter = (usize, Arc<AtomicUsize>);
extern "C" fn child_thread(arg: usize) -> i32 {
    let b = unsafe { Box::from_raw(arg as *mut _) };
    child_thread_impl(b);
    return 0;
}

fn child_thread_impl(arg: Box<Counter>) {
    let guard = LOGGER_LOCK.lock();
    println!("Thread {} start working.", arg.0);
    sleep(1);
    println!("Thread {} stop working.", arg.0);
    arg.1.fetch_sub(1, Relaxed);
}

#[repr(C, align(4096))]
struct Page([u8; 4096]);

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    println!("Test clone() call.");
    let counter = Arc::new(AtomicUsize::new(10));
    let mut v = Vec::new();
    for i in 0usize..10 {
        let arg: Box<Counter> = Box::new((i, Arc::clone(&counter)));
        let mut page = Box::new(Page([0; 4096]));
        let addr = &mut page.0[0] as *mut _ as usize;
        v.push(page); // violation of borrow checker semantics, but good.

        sys_clone(child_thread, addr + 4096, 0, Box::leak(arg) as *mut _ as _);
        println!("Cloned {}", i);
    }
    while counter.load(Relaxed) > 0 {
        // spin
    }
    println!("Clone call success.");
}
