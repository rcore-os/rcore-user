#![no_std]
#![no_main]
#![allow(non_upper_case_globals)]
#![allow(dead_code)]

extern crate alloc;
#[macro_use]
extern crate rcore_user;

use alloc::string::String;
use rcore_user::syscall::*;

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

#[repr(i32)]
pub enum EPollCtlOp {
    ADD = 1, /* Add a file descriptor to the interface.  */
    DEL = 2, /* Remove a file descriptor from the interface.  */
    MOD = 3, /* Change file descriptor epoll_event structure.  */
}

#[repr(u16)]
pub enum AddressFamily {
    /// Unspecified
    Unspecified = 0,
    /// Unix domain sockets
    Unix = 1,
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

fn create_socket(id: u16) -> Option<(usize, SockAddrIn)> {
    let mut servaddr: SockAddrIn = SockAddrIn {
        sin_family: AddressFamily::Internet as u16,
        sin_port: id,
        sin_addr: 0,
        sin_zero: [0u8; 8],
    };

    let listenfd = sys_socket(
        AddressFamily::Internet as usize,
        SocketType::Stream as usize,
        0,
    ) as usize;

    if listenfd as i32 == -1 {
        println!("can't create socket");
        return None;
    }

    let reuseaddr: u32 = 1;
    if sys_setsockopt(listenfd, 1, 2, &reuseaddr as *const u32 as usize, 4) == -1 {
        println!("setsockopt error");
        return None;
    }

    if sys_bind(
        listenfd,
        &servaddr as *const SockAddrIn,
        core::mem::size_of::<SockAddrIn>(),
    ) == -1
    {
        println!("bind error");
        return None;
    }

    if sys_listen(listenfd, 5) == -1 {
        println!("listen error");
        return None;
    }
    return Some((listenfd, servaddr));
}

fn test_ppoll() {
    let (mut listensocket, mut servaddr) = create_socket(18463).unwrap();
    println!(
        "create socket {}  , listening on 0.0.0.0, port 8008, use telnet to connect",
        listensocket
    );

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
    let timeout = TimeSpec { sec: 0, nsec: 5000 };
    const BUF_SZ: usize = 1024;
    let mut buf_read = [0u8; BUF_SZ];

    let ret = sys_ppoll(fds.as_mut_ptr(), 2, &timeout);

    if ret < 0 {
        panic!("sys_ppoll failed: {}", ret);
    } else if ret == 0 {
        println!("poll run out of time: {}ms ", timeout.nsec);
    } else {
        if (fds[0].revents & PollEvents::IN) != 0 {
            println!("stdin is readable: ");
            sys_read(0, buf_read.as_mut_ptr(), BUF_SZ);
            println!("input: {}", String::from_utf8_lossy(&buf_read));
        }

        if (fds[1].revents & PollEvents::IN) != 0 {
            println!("network is readable");
            let mut client: SockAddrIn = SockAddrIn {
                sin_family: 0,
                sin_port: 0,
                sin_addr: 0,
                sin_zero: [0u8; 8],
            };
            let mut lenaddr: u32 = 16u32;
            let conn = sys_accept(listensocket, &mut client, &mut lenaddr);

            assert_ne!(conn, -1, "accept error");

            sys_recvfrom(
                conn as usize,
                buf_read.as_mut_ptr(),
                BUF_SZ as usize,
                0,
                &mut servaddr,
                &mut lenaddr,
            );
            println!("recv data: {}", String::from_utf8_lossy(&buf_read));
        }
    }
}

fn test_epoll() {
    let (mut listensocket_8008, mut servaddr_8008) = create_socket(18463).unwrap();
    let (mut listensocket_8007, mut servaddr_8007) = create_socket(18207).unwrap();

    println!(
        "create socket {} {} , listening on 0.0.0.0, port 8007 and 8008",
        listensocket_8007, listensocket_8008
    );

    let epfd = sys_epoll_create1(0);
    if epfd < 0 {
        panic!("epoll_create error");
    } else {
        println!("epoll_create : {}", epfd);
    }

    const MAX_EVENTS: usize = 10;
    let mut ev: EpollEvent = EpollEvent::default();
    let mut events: [EpollEvent; MAX_EVENTS] = Default::default();

    ev.events = EpollEvent::IN;
    ev.data.fd = listensocket_8007 as i32;
    if sys_epoll_ctl(
        epfd as usize,
        EPollCtlOp::ADD as usize,
        listensocket_8007 as usize,
        &ev,
    ) == -1
    {
        panic!("epoll_ctl add socket error");
    }

    ev.events = EpollEvent::IN | EpollEvent::ET;
    ev.data.fd = listensocket_8008 as i32;
    if sys_epoll_ctl(
        epfd as usize,
        EPollCtlOp::ADD as usize,
        listensocket_8008 as usize,
        &ev,
    ) == -1
    {
        panic!("epoll_ctl add socket error");
    }

    ev.events = EpollEvent::IN;
    ev.data.fd = 0;
    if sys_epoll_ctl(epfd as usize, EPollCtlOp::ADD as usize, 0, &ev) == -1 {
        panic!("epoll_ctl add socket error");
    }

    let timeout: i32 = 5000;
    const BUF_SZ: usize = 1024;
    let mut buf_read = [0u8; BUF_SZ];

    let ret = sys_epoll_pwait(
        epfd as usize,
        events.as_mut_ptr(),
        MAX_EVENTS,
        timeout as i32 as usize,
        0,
    );

    if ret < 0 {
        panic!("error happened");
    } else if ret == 0 {
        println!("poll run out of time: {}ms ", timeout);
    } else {
        let ret = sys_epoll_pwait(
            epfd as usize,
            events.as_mut_ptr(),
            MAX_EVENTS,
            timeout as usize,
            0,
        );

        println!("epoll return value: {}", ret);
        for i in 0..ret {
            unsafe {
                println!("fd: {}", events[i as usize].data.fd);
                if events[i as usize].data.fd == 0 {
                    println!("stdin is readable: ");
                    sys_read(0, buf_read.as_mut_ptr(), BUF_SZ);
                    println!("input: {}", String::from_utf8_lossy(&buf_read));
                }
                if events[i as usize].data.fd == listensocket_8007 as i32 {
                    println!("port 8007 is readable");
                    let mut client: SockAddrIn = SockAddrIn {
                        sin_family: 0,
                        sin_port: 0,
                        sin_addr: 0,
                        sin_zero: [0u8; 8],
                    };
                    let mut lenaddr: u32 = 16u32;
                    let conn = sys_accept(listensocket_8007, &mut client, &mut lenaddr);

                    assert_ne!(conn, -1, "accept error");
                    sys_recvfrom(
                        conn as usize,
                        buf_read.as_mut_ptr(),
                        BUF_SZ as usize,
                        0,
                        &mut servaddr_8007,
                        &mut lenaddr,
                    );
                    println!("recv data: {}", String::from_utf8_lossy(&buf_read));
                }
                if events[i as usize].data.fd == listensocket_8008 as i32 {
                    println!("port 8008 is readable");
                    let mut client: SockAddrIn = SockAddrIn {
                        sin_family: 0,
                        sin_port: 0,
                        sin_addr: 0,
                        sin_zero: [0u8; 8],
                    };
                    let mut lenaddr: u32 = 16u32;
                    let conn = sys_accept(listensocket_8008, &mut client, &mut lenaddr);

                    assert_ne!(conn, -1, "accept error");
                    sys_recvfrom(
                        conn as usize,
                        buf_read.as_mut_ptr(),
                        BUF_SZ as usize,
                        0,
                        &mut servaddr_8008,
                        &mut lenaddr,
                    );
                    println!("recv data: {}", String::from_utf8_lossy(&buf_read));
                }
            }
        }
    }
}

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    //    test_ppoll();
    test_epoll();
}
