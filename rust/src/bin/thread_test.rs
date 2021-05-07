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
use rcore_user::thread;
use spin::Mutex;
static LOGGER_LOCK: Mutex<()> = Mutex::new(());
use rcore_user::syscall::sys_clone;
use rcore_user::ulib::sleep;

#[no_mangle]
pub fn main() {
    thread::init();
    println!("Test threads using clone() call.");
    let counter = Arc::new(AtomicUsize::new(10));
    for i in 0usize..10 {
        let counter_c = Arc::clone(&counter);
        let joinhandle = thread::spawn(move || {
            let guard = LOGGER_LOCK.lock();
            println!("Thread {} start working.", i);
            sleep(1);
            println!("Thread {} stop working.", i);
            counter_c.fetch_sub(1, Relaxed);
            i + 10
        });
        println!("Start thread {}", i);
        if i % 2 == 1 {
            let r = joinhandle.join().expect("Thread execution error");
            println!("Join thread {}, ret = {}", i, r);
        }
    }
    while counter.load(Relaxed) > 0 {
        // spin
    }
}
