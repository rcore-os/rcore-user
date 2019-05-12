#![feature(alloc)]
#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;
extern crate alloc;

extern crate treebitmap;

use alloc::format;
use core::default::Default;
use core::mem::size_of;
use rcore_user::syscall::{sys_ioctl, sys_read, sys_sendto, sys_setsockopt, sys_socket};
use treebitmap::*;

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
    sha_data: [u8; 14],
}

#[repr(C)]
#[derive(Default)]
struct ArpReq {
    arp_pa: SockAddrIn,
    arp_ha: SockAddrHa,
    arp_flags: u32,
    arp_netmask: SockAddrIn,
    arp_dev: [u8; 16],
}

pub fn get_routing_table() -> IpLookupTable<Ipv4Addr, (u32, [u8; 6], &'static str)> {
    let mut table = IpLookupTable::new();
    // iface 0 10.0.0.0/24 00:16:31:ff:a4:9f enp0s4f0
    table.insert(
        Ipv4Addr::new(10, 0, 0, 0),
        24,
        (0, [0x00, 0x16, 0x31, 0xff, 0xa4, 0x9f], "enp0s4f0\0"),
    );
    // iface 1 10.0.1.0/24 54:51:9f:71:c0:01 enp0s5f0
    table.insert(
        Ipv4Addr::new(10, 0, 1, 0),
        24,
        (1, [0x54, 0x51, 0x9f, 0x71, 0xc0, 0x01], "enp0s5f0\0"),
    );

    table
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
    let packet_fd = sys_socket(17, 3, 0);
    // netlink socket, raw
    let netlink_fd = sys_socket(16, 3, 0);

    let table = get_routing_table();

    let mut buffer = [0u8; 2048];
    // set header included
    let included = 1u32;
    sys_setsockopt(
        capture_fd as usize,
        0,
        3,
        &included as *const u32 as usize,
        4,
    );

    let mut addr: SockAddrLl = Default::default();
    // packet
    addr.sll_family = 17;
    const ETHER_HEADER_LEN: usize = 6 + 6 + 2;
    // ethertype 0x0800 ipv4
    buffer[12] = 0x08;
    buffer[13] = 0x00;

    let mut arp: ArpReq = Default::default();
    // inet
    arp.arp_pa.sin_family = 2;
    loop {
        let len = sys_read(
            capture_fd as usize,
            buffer.as_mut_ptr().add(ETHER_HEADER_LEN),
            buffer.len(),
        ) as usize;
        println!("Got packet of len {}", len);
        // check ethertype and ip version ihl
        if ETHER_HEADER_LEN + len > 20
            && buffer[12] == 0x08
            && buffer[13] == 0x00
            && buffer[ETHER_HEADER_LEN + 0] == 0x45
        {
            // ipv4
            let ttl = buffer[ETHER_HEADER_LEN + 8];
            if ttl > 1 {
                if buffer[ETHER_HEADER_LEN + 19] == 2 {
                    // to myself
                    println!("packet to myself");
                    continue;
                }
                let lookup_ip = Ipv4Addr::new(
                    buffer[ETHER_HEADER_LEN + 16],
                    buffer[ETHER_HEADER_LEN + 17],
                    buffer[ETHER_HEADER_LEN + 18],
                    buffer[ETHER_HEADER_LEN + 19],
                );
                let route_match = table.longest_match(lookup_ip);
                match route_match {
                    Some((_, _, (out_if, mac, name))) => {
                        let dst_ip = (buffer[ETHER_HEADER_LEN + 19] as u32) << 24
                            | (buffer[ETHER_HEADER_LEN + 18] as u32) << 16
                            | (buffer[ETHER_HEADER_LEN + 17] as u32) << 8
                            | (buffer[ETHER_HEADER_LEN + 16] as u32);
                        arp.arp_pa.sin_addr = dst_ip;
                        arp.arp_dev[0..9].copy_from_slice(name.as_bytes());
                        // SIOCGARP
                        if sys_ioctl(arp_fd as usize, 0x8954, &arp as *const ArpReq as usize) < 0 {
                            println!("dst ip not in arp table, skipping");
                            continue;
                        }

                        let message = format!("from {}.{}.{}.{} {:02X}:{:02X}:{:02X}:{:02X}:{:02X}:{:02X} to {}.{}.{}.{} {:02X}:{:02X}:{:02X}:{:02X}:{:02X}:{:02X} dev {}:{} with ttl {}", buffer[ETHER_HEADER_LEN + 12],
                        buffer[ETHER_HEADER_LEN+ 13],
                        buffer[ETHER_HEADER_LEN+ 14],
                        buffer[ETHER_HEADER_LEN+ 15],
                        mac[0],
                        mac[1],
                        mac[2],
                        mac[3],
                        mac[4],
                        mac[5],
                        buffer[ETHER_HEADER_LEN+ 16],
                        buffer[ETHER_HEADER_LEN+ 17],
                        buffer[ETHER_HEADER_LEN+ 18],
                        buffer[ETHER_HEADER_LEN+ 19],
                        arp.arp_ha.sha_data[0],
                        arp.arp_ha.sha_data[1],
                        arp.arp_ha.sha_data[2],
                        arp.arp_ha.sha_data[3],
                        arp.arp_ha.sha_data[4],
                        arp.arp_ha.sha_data[5],
                        out_if,
                        name,
                        ttl,
                        );
                        println!("{}", message);

                        // fill dst and src mac
                        // todo: get mac from if instead of hard coding
                        buffer[0..6].copy_from_slice(&arp.arp_ha.sha_data[0..6]);
                        buffer[6..12].copy_from_slice(mac);
                        buffer[ETHER_HEADER_LEN + 8] = ttl - 1;
                        let checksum = (buffer[ETHER_HEADER_LEN + 10] as u16) << 8
                            | (buffer[ETHER_HEADER_LEN + 11] as u16);
                        buffer[ETHER_HEADER_LEN + 10] = ((checksum + 0x0100) >> 8) as u8;
                        buffer[ETHER_HEADER_LEN + 11] = (checksum + 0x0100) as u8;
                        addr.sll_ifindex = *out_if;
                        sys_sendto(
                            packet_fd as usize,
                            buffer.as_ptr(),
                            len as usize + ETHER_HEADER_LEN,
                            0,
                            &addr as *const SockAddrLl as usize,
                            size_of::<SockAddrLl>(),
                        );
                    }
                    None => continue,
                }
            }
        }
    }
}
