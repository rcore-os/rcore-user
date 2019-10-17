#![no_std]
#![no_main]
#![allow(non_upper_case_globals)]
#![allow(dead_code)]

extern crate alloc;
#[macro_use]
extern crate rcore_user;

use alloc::string::String;
use rcore_user::syscall::{sys_read, sys_setsockopt, sys_socket, sys_accept, sys_bind, sys_listen, sys_recvfrom};
use rcore_user::syscall::{sys_poll, sys_ppoll};


#[repr(C)]
#[derive(Debug)]
pub struct PollEvents(u16);

impl PollEvents {
    /// There is data to read.
    pub const IN: u16 = 0x0001;
    /// Writing is now possible.
    pub const OUT: u16 = 0x0004;
    /// Error condition (return only)
    pub const ERR: u16 = 0x0008;
    /// Hang up (return only)
    pub const HUP: u16 = 0x0010;
    /// Invalid request: fd not open (return only)
    pub const INVAL: u16 = 0x0020;
}


#[repr(C)]
#[derive(Debug)]
pub struct PollFd {
    fd: u32,
    events: u16,
    revents: u16,
}



#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct TimeSpec {
    sec: usize,
    nsec: usize,
}

#[repr(C)]
#[derive(Debug)]
pub struct SockAddrIn {
    pub sin_family: u16,
    pub sin_port: u16,
    pub sin_addr: u32,
    pub sin_zero: [u8; 8],
}



#[repr(C)]
#[derive(Debug)]
pub struct AddressFamily(u16);
impl AddressFamily {
    /// Unspecified
    pub const Unspecified: u16 = 0;
    /// Unix domain sockets
    pub const Unix: u16 = 1;
    /// Internet IP Protocol
    pub const Internet: u16 = 2;
    /// Netlink
    pub const Netlink: u16 = 16;
    /// Packet family
    pub const Packet: u16 = 17;
}

#[repr(C)]
#[derive(Debug)]
pub struct SocketType;

impl SocketType {
    /// Stream
    pub const Stream: u8 = 1;
    /// Datagram
    pub const Datagram: u8 = 2;
    /// Raw
    pub const Raw: u8 = 3;
}



fn poll(ufds: *mut PollFd, nfds: usize, timeout: usize) -> i32{
    sys_poll(ufds as *const u32 as usize, nfds, timeout)
}

fn ppoll(ufds: *mut PollFd, nfds: usize, timeout: *const TimeSpec) -> i32 {
    sys_ppoll(ufds as *const u32 as usize, nfds, timeout as *const u32 as usize)
}




fn create_socket(id :u16) -> (usize, SockAddrIn) {
    let mut servaddr: SockAddrIn = SockAddrIn{
        sin_family: 0,
        sin_port: 0,
        sin_addr: 0,
        sin_zero: [0u8; 8],
    };;
    servaddr.sin_family = AddressFamily::Internet;
    servaddr.sin_port = id;
    servaddr.sin_addr = 0;
        
    let listenfd = sys_socket(AddressFamily::Internet as usize, SocketType::Stream as usize, 0) as usize;
 
    if listenfd as i32 == -1 {
        println!("can create socket");
    }
 
    let reuseaddr = 1u32;
    if sys_setsockopt(listenfd, 1, 2, &reuseaddr as *const u32 as usize, 4) == -1{
        println!("setsockopt error");
    }
  
    if sys_bind(listenfd, &servaddr as *const SockAddrIn as usize , 16) == -1{
        println!("bind error");
    }
 
    if sys_listen(listenfd, 5) == -1{
        println!("listen error");
    }
 
    return (listenfd, servaddr);
}

fn test_ppoll(){
    let _ = create_socket(18207);

    let (listensocket, servaddr) = create_socket(18463);
    println!("create socket {}  , listening on 0.0.0.0, port 8008, use telnet to connect", listensocket);

    let std_fd = PollFd {
        fd: 0,
        events: PollEvents::IN | PollEvents::ERR,
        revents: 0,
    };

    let socket_fd = PollFd {
        fd: listensocket as u32,
        events: PollEvents::IN | PollEvents::ERR,
        revents: 0, 
    };

    let mut fds = [std_fd, socket_fd];
    let timeout = 3000;
    const buf_sz: usize = 1024;
    let mut buf_read = [0u8; buf_sz];
	

	let ret = poll(fds.as_mut_ptr(), 2, timeout as i32 as usize);
	
    if ret < 0{
        println!("error happened");
    } if ret == 0{
    	println!("poll run out of time: {}ms ", timeout);
    }else {
        if (fds[0].revents & PollEvents::IN) != 0 {
            println!("stdin is readable: ");
            sys_read(0, buf_read.as_mut_ptr(), buf_sz);
            println!("input: {}", String::from_utf8_lossy(&buf_read));
        }

        if (fds[1].revents & PollEvents::IN) != 0 {
            println!("network is readable");
            let client: SockAddrIn = SockAddrIn{
                sin_family:0,
                sin_port: 0,
                sin_addr: 0,
                sin_zero: [0u8; 8],
            };
            let lenaddr: u32 = 16u32;
            let conn = sys_accept(listensocket, &client as *const SockAddrIn as usize, &lenaddr as *const u32 as usize);

            if conn == -1 {
                println!("accept error");
            }


            sys_recvfrom(conn as usize, buf_read.as_ptr() as usize, buf_sz as usize, 0,
                &servaddr as *const SockAddrIn as usize, &lenaddr as *const u32 as usize);
            println!("recv data: {}", String::from_utf8_lossy(&buf_read));
        }


    }
}


// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main(){
    test_ppoll();

}
