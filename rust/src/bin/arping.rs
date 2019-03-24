#![feature(alloc)]
#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;

extern crate alloc;

use alloc::boxed::Box;
use alloc::vec;
use alloc::vec::Vec;
use isomorphic_drivers::net::ethernet::intel::ixgbe;
use isomorphic_drivers::provider;
use rcore_user::syscall::*;

#[derive(Copy, Clone)]
pub struct Provider;

impl Provider {
    pub fn new() -> Box<Provider> {
        Box::new(Provider {})
    }
}

impl provider::Provider for Provider {
    /// Get page size
    fn get_page_size(&self) -> usize {
        4096
    }

    // Translate virtual address to physical address
    fn translate_va(&self, va: usize) -> usize {
        let mut pa = [0u64; 1];
        sys_get_paddr(&[va as u64], &mut pa[..]);
        pa[0] as usize
    }

    // Bulk translate virtual addresses to physical addresses for performance
    fn translate_vas(&self, vas: &[usize]) -> Vec<usize> {
        let mut pas = vec![0u64; vas.len()];
        let mut vec_vas = vec![0u64; vas.len()];
        for va in vas.iter() {
            vec_vas.push(*va as u64);
        }
        sys_get_paddr(&vec_vas[..], &mut pas[..]);
        let mut res = vec![0usize; vas.len()];
        for pa in pas {
            res.push(pa as usize);
        }
        res
    }
}

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    println!("I am going to map IXGBE driver to user space");
    println!("Kernel network stack should not use it anymore");
    let addr = sys_map_pci_device(0x8086, 0x10fb);
    println!("IXGBE addr at {:#X}", addr);
    let ixgbe = ixgbe::IXGBEDriver::init(Provider::new(), addr as usize, 0x20000);
    println!("IXGBE driver up");
    loop {
        println!("IXGBE driver sending data");
        let data = [
            0xff, 0xff, 0xff, 0xff, 0xff, 0xff, // mac
            0x00, 0x16, 0x31, 0xff, 0xa4, 0x9f, // mac
            0x08, 0x06, // arp
            0x00, 0x01, 0x08, 0x00, 0x06, 0x04, 0x00, 0x01, 0xff, 0xff, 0xff, 0xff, 0xff,
            0xff, // mac
            0x0a, 0x00, 0x00, 0x02, // ip
            0x00, 0x16, 0x31, 0xff, 0xa4, 0x9f, // mac
            0x0a, 0x00, 0x00, 0x01,
        ]; // ip
        ixgbe.send(&data);
        sys_sleep(1);
    }
}
