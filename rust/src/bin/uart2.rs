#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;
use rcore_user::io::{putc, O_RDONLY};
use rcore_user::syscall::sys_open;
use rcore_user::syscall::sys_read;
use rcore_user::syscall::sys_write;
pub fn putc_uart2(fd: usize, c: u8) {
    sys_write(fd, &c, 1);
}

pub fn getc_uart2(fd: usize) -> u8 {
    let mut c = 0u8;
    loop {
        let len = sys_read(fd, &mut c, 1);
        match len {
            1 => return c,
            0 => continue,
            _ => panic!("read uart2 len = {}", len),
        }
    }
}
// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    let fd = sys_open("/dev/ttyS1", O_RDONLY);
    if (fd < 0) {
        panic!("no /dev/ttyS1");
    }
    let fd = fd as usize;
    println!("Start spinning.");
    loop {
        putc(getc_uart2(fd));
    }
}
