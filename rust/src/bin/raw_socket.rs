#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;

use rcore_user::syscall::{sys_socket, sys_read, sys_setsockopt, sys_sendto, sys_ioctl};
use core::mem::size_of;
use core::default::Default;

#[repr(C)]
#[derive(Default)]
pub struct SockAddrLl {
    sll_family: u16,
    sll_protocol: u16,
    sll_ifindex: u32,
    sll_hatype: u16,
    sll_pkttype: u8,
    sll_halen: u8,
    sll_addr: [u8; 8],
}

#[repr(C)]
#[derive(Default)]
pub struct SockAddrIn {
    sin_family: u16,
    sin_port: u16,
    sin_addr: u32,
    sin_zero: [u8; 8],
}

#[repr(C)]
#[derive(Default)]
pub struct SockAddrHa {
    sha_family: u16,
    sha_data: [u8; 14]
}

#[repr(C)]
#[derive(Default)]
struct ArpReq {
    arp_pa: SockAddrIn,
    arp_ha: SockAddrHa,
    arp_flags: u32,
    arp_netmask: SockAddrIn,
    arp_dev: [u8; 16]
}

// IMPORTANT: Must define main() like this
#[no_mangle]
pub unsafe fn main() {
    println!("Raw socket test");
    // raw socket, icmp
    let capture_fd = sys_socket(2, 3, 1);
    // inet socket, udp
    let arp_fd = sys_socket(2, 2, 0);
    // packet socket, raw
    let packet = sys_socket(17, 3, 0);
    let mut buffer = [0u8; 2048];
    // set header included
    let included = 1u32;
    sys_setsockopt(capture_fd as usize, 0, 3, &included as *const u32 as usize, 4);

    let mut addr: SockAddrLl = Default::default();
    // packet
    addr.sll_family = 17;
    const ETHER_HEADER_LEN: usize = 6+6+2;
    // ethertype 0x0800 ipv4
    buffer[12] = 0x08;
    buffer[13] = 0x00;

    let mut arp: ArpReq = Default::default();
    // inet
    arp.arp_pa.sin_family = 2;
    arp.arp_dev[0..9].copy_from_slice(&[b'e', b'n', b'p', b'0', b's', b'4', b'f', b'0', 0]);
    loop {
        let len = sys_read(capture_fd as usize, buffer.as_mut_ptr().add(ETHER_HEADER_LEN), buffer.len()) as usize;
        println!("Got packet of len {}", len);
        if ETHER_HEADER_LEN + len > 20 && buffer[ETHER_HEADER_LEN + 0] == 0x45 {
            // ipv4
            let ttl = buffer[ETHER_HEADER_LEN + 8];
            if ttl > 1 {
                println!("ttl {}", ttl);
                let dst_ip = (buffer[ETHER_HEADER_LEN + 19] as u32) << 24 |
                    (buffer[ETHER_HEADER_LEN + 18] as u32) << 16 |
                    (buffer[ETHER_HEADER_LEN + 17] as u32) << 8 |
                    (buffer[ETHER_HEADER_LEN + 16] as u32);
                println!("dst_ip {:#X}", dst_ip);
                arp.arp_pa.sin_addr = dst_ip;
                // SIOCGARP
                sys_ioctl(arp_fd as usize, 0x8954, &arp as *const ArpReq as usize);
                println!("dst_mac {:X?}", &arp.arp_ha.sha_data[0..6]);
    
                // fill src and dst mac
                // todo: get mac from if instead of hard coding
                buffer[0..6].copy_from_slice(&[0, 0x16, 0x31, 0xFF, 0xA4, 0x9F]);
                buffer[6..12].copy_from_slice(&arp.arp_ha.sha_data[0..6]);
                buffer[ETHER_HEADER_LEN + 8] = ttl - 1;
                let checksum = (buffer[ETHER_HEADER_LEN + 10] as u16) << 8 | (buffer[ETHER_HEADER_LEN + 11] as u16);
                buffer[ETHER_HEADER_LEN + 10] = ((checksum + 1) >> 8) as u8;
                buffer[ETHER_HEADER_LEN + 11] = checksum as u8;
                addr.sll_ifindex = 0;
                sys_sendto(packet as usize, buffer.as_ptr(), len as usize + ETHER_HEADER_LEN, 0, &addr as *const SockAddrLl as usize, size_of::<SockAddrLl>());
            }
        }
    }
}
