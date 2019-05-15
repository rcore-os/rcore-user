#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    println!("Faulting sys_exec");
    rcore_user::syscall::sys_exec(0 as *const u8, 0 as *const *const u8, 0 as *const *const u8);
}
