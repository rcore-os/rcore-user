#![no_std]
#![no_main]
#![allow(non_upper_case_globals)]
#![allow(dead_code)]

extern crate alloc;
#[macro_use]
extern crate rcore_user;

use alloc::string::String;
use rcore_user::syscall::{sys_read, sys_setsockopt, sys_socket, sys_accept, sys_bind, sys_listen, sys_recvfrom};
use rcore_user::syscall::{sys_ppoll, sys_epoll_create1, sys_epoll_ctl, sys_epoll_pwait};

#[cfg(any(target_arch = "x86_64", target_arch = "mips"))]
use rcore_user::syscall::{sys_poll};


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
union EPOLLDATAT {
    ptr: u64,
    fd: i32,
    v32: u32,
    v64: u64,
}

#[repr(packed)]
pub struct EpollEvent {
    events: u32,    /* Epoll events */
    data: EPOLLDATAT,      /* User data variable */
}

impl core::default::Default for EpollEvent {
    fn default() -> EpollEvent {
        EpollEvent {
            events: 0, 
            data: EPOLLDATAT {
                ptr : 0
            }
        }
    }
}


#[repr(i32)]
pub enum EPollCtlOp {
    EPOLLCTLADD = 1,    /* Add a file descriptor to the interface.  */
    EPOLLCTLDEL = 2,    /* Remove a file descriptor from the interface.  */
    EPOLLCTLMOD = 3,    /* Change file descriptor epoll_event structure.  */
}

impl EpollEvent {
    const EPOLLIN: u32 = 0x001;
    const EPOLLPRI: u32 = 0x002;
    const EPOLLOUT: u32 = 0x004;
    const EPOLLRDNORM: u32 = 0x040;
    const EPOLLRDBAND: u32 = 0x080;
    const EPOLLWRNORM: u32 = 0x100;
    const EPOLLWRBAND: u32 = 0x200;
    const EPOLLMSG: u32 = 0x400;
    const EPOLLERR: u32 = 0x008;
    const EPOLLHUP: u32 = 0x010;
    const EPOLLRDHUP: u32 = 0x2000;
    const EPOLLEXCLUSIVE: u32 = 1 << 28;
    const EPOLLWAKEUP: u32 = 1 << 29;
    const EPOLLONESHOT: u32 = 1 << 30;
    const EPOLLET: u32 = 1 << 31;
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

#[repr(u16)]
pub enum AddressFamily{
    /// Unspecified
    Unspecified = 0,
    /// Unix domain sockets
    Unix= 1,
    /// Internet IP Protocol
    Internet = 2,
    /// Netlink
     Netlink = 16,
    /// Packet family
     Packet = 17,
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



// fn poll(ufds: *mut PollFd, nfds: usize, timeout: usize) -> i32{
//     sys_poll(ufds , nfds, timeout)
// }

// fn ppoll(ufds: *mut PollFd, nfds: usize, timeout: *const TimeSpec) -> i32 {
//     sys_ppoll(ufds as *const u32 as usize, nfds, timeout as *const u32 as usize)
// }




fn create_socket(id :u16) -> (usize, SockAddrIn) {
    let mut servaddr: SockAddrIn = SockAddrIn{
        sin_family: 0,
        sin_port: 0,
        sin_addr: 0,
        sin_zero: [0u8; 8],
    };;
    servaddr.sin_family = AddressFamily::Internet as u16;
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
    let timeout = 5000;
    const buf_sz: usize = 1024;
    let mut buf_read = [0u8; buf_sz];
	

	let ret = sys_poll(fds.as_mut_ptr() as *const u32 as usize, 2, timeout as i32 as usize);
	
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

fn test_epoll(){
    let (listensocket_8008, servaddr_8008) = create_socket(18463);

    let (listensocket_8007, servaddr_8007) = create_socket(18207);
    println!("create socket {} {} , listening on 0.0.0.0, port 8007 and 8008", listensocket_8007, listensocket_8008);

    let epfd = sys_epoll_create1(0);
    if epfd < 0 {
        println!("epoll_create error");
    } else {
        println!("epoll_create : {}", epfd);
    }

    const MAX_EVENTS: usize = 10;
    let mut ev: EpollEvent = EpollEvent::default();
    let mut events: [EpollEvent; MAX_EVENTS] = Default::default();

    ev.events = EpollEvent::EPOLLIN;
    ev.data.fd = listensocket_8007 as i32;
    if sys_epoll_ctl(epfd as usize, EPollCtlOp::EPOLLCTLADD as usize, listensocket_8007 as usize, &ev as *const EpollEvent as usize) == -1 {
        println!("epoll_ctl add socket error");
    }

    ev.events = EpollEvent::EPOLLIN;
    ev.data.fd = listensocket_8008 as i32;
    if sys_epoll_ctl(epfd as usize, EPollCtlOp::EPOLLCTLADD as usize, listensocket_8008 as usize, &ev as *const EpollEvent as usize) == -1 {
        println!("epoll_ctl add socket error");
    }

    ev.events = EpollEvent::EPOLLIN;
    ev.data.fd = 0;
    if sys_epoll_ctl(epfd as usize, EPollCtlOp::EPOLLCTLADD as usize, 0, &ev as *const EpollEvent as usize) == -1 {
        println!("epoll_ctl add socket error");
    }

    let timeout = 5000;
    const buf_sz: usize = 1024;
    let mut buf_read = [0u8; buf_sz];
    
    let ret = sys_epoll_pwait(epfd as usize, events.as_mut_ptr() as *const EpollEvent as usize, MAX_EVENTS, timeout as i32 as usize, 0);
    
    if ret < 0{
        println!("error happened");
    } else if ret == 0 {
        println!("poll run out of time: {}ms ", timeout);
    } else {
        println!("epoll return value: {}", ret);
        for i in 0..ret {
            unsafe {
                println!("fd: {}", events[i as usize].data.fd);
                if events[i as usize].data.fd == 0 {
                    println!("stdin is readable: ");
                    sys_read(0, buf_read.as_mut_ptr(), buf_sz);
                    println!("input: {}", String::from_utf8_lossy(&buf_read));
                }
                if events[i as usize].data.fd == listensocket_8007 as i32 {
                    println!("port 8007 is readable");
                    let client: SockAddrIn = SockAddrIn{
                        sin_family:0,
                        sin_port: 0,
                        sin_addr: 0,
                        sin_zero: [0u8; 8],
                    };
                    let lenaddr: u32 = 16u32;
                    let conn = sys_accept(listensocket_8007, &client as *const SockAddrIn as usize, &lenaddr as *const u32 as usize);

                    if conn == -1 {
                        println!("accept error");
                    }
                    sys_recvfrom(conn as usize, buf_read.as_ptr() as usize, buf_sz as usize, 0,
                        &servaddr_8007 as *const SockAddrIn as usize, &lenaddr as *const u32 as usize);
                    println!("recv data: {}", String::from_utf8_lossy(&buf_read));
                }
                if events[i as usize].data.fd == listensocket_8008 as i32 {
                    println!("port 8008 is readable");
                    let client: SockAddrIn = SockAddrIn{
                        sin_family:0,
                        sin_port: 0,
                        sin_addr: 0,
                        sin_zero: [0u8; 8],
                    };
                    let lenaddr: u32 = 16u32;
                    let conn = sys_accept(listensocket_8008, &client as *const SockAddrIn as usize, &lenaddr as *const u32 as usize);

                    if conn == -1 {
                        println!("accept error");
                    }

                    let mut ev: EpollEvent = EpollEvent::default();
                    ev.events = EpollEvent::EPOLLIN;
                    ev.data.fd = conn;
                    if sys_epoll_ctl(epfd as usize, EPollCtlOp::EPOLLCTLADD as usize, conn as usize, &ev as *const EpollEvent as usize) == -1 {
                        println!("epoll_ctl add socket error");
                    }

                    let ret = sys_epoll_pwait(epfd as usize, events.as_mut_ptr() as *const EpollEvent as usize, MAX_EVENTS, timeout as i32 as usize, 0);
                    println!("second epoll return {}", ret);
    
                    sys_recvfrom(conn as usize, buf_read.as_ptr() as usize, buf_sz as usize, 0,
                        &servaddr_8008 as *const SockAddrIn as usize, &lenaddr as *const u32 as usize);
                    println!("recv data: {}", String::from_utf8_lossy(&buf_read));
                }
            }
        }
    }
}



// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main(){
//    test_ppoll();
    test_epoll();
}
