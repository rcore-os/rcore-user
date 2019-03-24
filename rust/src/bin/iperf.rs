#![feature(alloc)]
#![no_std]
#![no_main]

#[macro_use]
extern crate rcore_user;

extern crate alloc;

use alloc::boxed::Box;
use alloc::collections::BTreeMap;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;
use isomorphic_drivers::net::ethernet::intel::ixgbe;
use isomorphic_drivers::provider;
use rcore_user::syscall::*;

use smoltcp::iface::*;
use smoltcp::phy;
use smoltcp::phy::*;
use smoltcp::socket::*;
use smoltcp::time::*;
use smoltcp::wire::*;
use smoltcp::Result;

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

#[derive(Clone)]
struct IXGBEDriver {
    inner: ixgbe::IXGBEDriver,
}

pub struct IXGBERxToken(Vec<u8>);
pub struct IXGBETxToken(IXGBEDriver);

impl<'a> phy::Device<'a> for IXGBEDriver {
    type RxToken = IXGBERxToken;
    type TxToken = IXGBETxToken;

    fn receive(&'a mut self) -> Option<(Self::RxToken, Self::TxToken)> {
        if self.inner.can_send() {
            if let Some(data) = self.inner.recv() {
                Some((IXGBERxToken(data), IXGBETxToken(self.clone())))
            } else {
                None
            }
        } else {
            None
        }
    }

    fn transmit(&'a mut self) -> Option<Self::TxToken> {
        if self.inner.can_send() {
            Some(IXGBETxToken(self.clone()))
        } else {
            None
        }
    }

    fn capabilities(&self) -> DeviceCapabilities {
        let mut caps = DeviceCapabilities::default();
        caps.max_transmission_unit = ixgbe::IXGBEDriver::get_mtu(); // max MTU
                                                                    //caps.max_transmission_unit = 1500; // max MTU
        caps.max_burst_size = Some(256);
        // IP Rx checksum is offloaded with RXCSUM
        caps.checksum.ipv4 = Checksum::Tx;
        caps
    }
}

impl phy::RxToken for IXGBERxToken {
    fn consume<R, F>(self, _timestamp: Instant, f: F) -> Result<R>
    where
        F: FnOnce(&[u8]) -> Result<R>,
    {
        f(&self.0)
    }
}

impl phy::TxToken for IXGBETxToken {
    fn consume<R, F>(self, _timestamp: Instant, len: usize, f: F) -> Result<R>
    where
        F: FnOnce(&mut [u8]) -> Result<R>,
    {
        let mut buffer = [0u8; ixgbe::IXGBEDriver::get_mtu()];
        let result = f(&mut buffer[..len]);
        if result.is_ok() {
            (self.0).inner.send(&buffer[..len]);
        }
        result
    }
}

#[derive(Copy, Clone, Debug, PartialEq)]
enum State {
    BEGIN,
    CONTROL_SOCKET_CONNECT,
    CONTROL_COOKIE_SENT,
    JSON_CONFIG_SENT,
    CREATE_STREAMS,
    DATA_SOCKET_CONNECT,
    DATA_COOKIE_SENT,
    TEST_START,
    TEST_RUNNING,
}

// IMPORTANT: Must define main() like this
#[no_mangle]
pub fn main() {
    enlarge_heap();
    println!("I am going to map IXGBE driver to user space");
    println!("Kernel network stack should not use it anymore");
    let addr = sys_map_pci_device(0x8086, 0x10fb);
    println!("IXGBE addr at {:#X}", addr);
    let ixgbe = ixgbe::IXGBEDriver::init(Provider::new(), addr as usize, 0x20000);
    println!("IXGBE driver up");
    println!("IXGBE driver waiting for link up");
    while !ixgbe.is_link_up() {}
    println!("IXGBE driver link is up");

    let ethernet_addr = ixgbe.get_mac();
    let ip_addrs = [IpCidr::new(IpAddress::v4(10, 0, 0, 2), 24)];
    let neighbor_cache = NeighborCache::new(BTreeMap::new());
    let mut iface = EthernetInterfaceBuilder::new(IXGBEDriver { inner: ixgbe })
        .ethernet_addr(EthernetAddress::from_bytes(&ethernet_addr.as_bytes()))
        .ip_addrs(ip_addrs)
        .neighbor_cache(neighbor_cache)
        .finalize();

    // 37 byte ascii cookie
    let cookie = String::from("cafebabed00dbeefELFGIF89aPKGET/HTTP/\0").into_bytes();
    assert_eq!(cookie.len(), 37);
    // Json config
    let json = String::from(r##"{"tcp":true,"omit":0,"time":10,"parallel":1,"len":2147483647,"pacing_timer":1000,"client_version":"3.6"}"##).into_bytes();
    println!("Waiting for 3s");
    sys_sleep(3);
    println!("Simulating iperf3 client to 10.0.0.1");

    // tcp for control, tcp2 for data
    let tcp_rx_buffer = TcpSocketBuffer::new(vec![0; 204800]);
    let tcp_tx_buffer = TcpSocketBuffer::new(vec![0; 204800]);
    let tcp_socket = TcpSocket::new(tcp_rx_buffer, tcp_tx_buffer);

    let tcp2_rx_buffer = TcpSocketBuffer::new(vec![0; 204800]);
    let tcp2_tx_buffer = TcpSocketBuffer::new(vec![0; 204800]);
    let tcp2_socket = TcpSocket::new(tcp2_rx_buffer, tcp2_tx_buffer);

    let mut sockets = SocketSet::new(vec![]);
    let tcp_handle = sockets.add(tcp_socket);
    let tcp2_handle = sockets.add(tcp2_socket);

    let mut tick = 0;
    let mut state = State::BEGIN;
    let mut last_state = State::BEGIN;
    let data = [0u8; 204800];
    loop {
        tick += 1;
        iface.poll(&mut sockets, Instant::from_millis(tick * 1000_000));
        {
            let mut socket = sockets.get::<TcpSocket>(tcp_handle);
            if let State::BEGIN = state {
                socket
                    .connect(
                        IpEndpoint::new(IpAddress::v4(10, 0, 0, 1), 5201),
                        IpEndpoint::new(IpAddress::v4(10, 0, 0, 2), 5201),
                    )
                    .unwrap();
                state = State::CONTROL_SOCKET_CONNECT;
            } else if let State::CONTROL_SOCKET_CONNECT = state {
                if socket.may_send() {
                    socket.send_slice(&cookie).unwrap();
                    state = State::CONTROL_COOKIE_SENT;
                }
            } else if let State::CONTROL_COOKIE_SENT = state {
                let mut recv = [0u8; 1];
                if socket.may_recv() {
                    socket.recv_slice(&mut recv).unwrap();
                    if recv[0] == 9 {
                        // param exchange
                        // dword len
                        let len = json.len();
                        let mut len_data = [0u8; 4];
                        len_data[3] = len as u8;
                        socket.send_slice(&len_data).unwrap();
                        socket.send_slice(&json).unwrap();
                        state = State::JSON_CONFIG_SENT;
                    }
                }
            } else if let State::JSON_CONFIG_SENT = state {
                let mut recv = [0u8; 1];
                if socket.may_recv() {
                    socket.recv_slice(&mut recv).unwrap();
                    if recv[0] == 10 {
                        // create streams
                        state = State::CREATE_STREAMS;
                    }
                }
            } else if let State::DATA_COOKIE_SENT = state {
                let mut recv = [0u8; 1];
                if socket.may_recv() {
                    socket.recv_slice(&mut recv).unwrap();
                    if recv[0] == 1 {
                        // test start
                        state = State::TEST_START;
                    }
                }
            } else if let State::TEST_START = state {
                let mut recv = [0u8; 1];
                if socket.may_recv() {
                    socket.recv_slice(&mut recv).unwrap();
                    if recv[0] == 2 {
                        // test running
                        state = State::TEST_RUNNING;
                    }
                }
            }
        }

        {
            let mut socket = sockets.get::<TcpSocket>(tcp2_handle);
            if let State::CREATE_STREAMS = state {
                socket
                    .connect(
                        IpEndpoint::new(IpAddress::v4(10, 0, 0, 1), 5201),
                        IpEndpoint::new(IpAddress::v4(10, 0, 0, 2), 5202),
                    )
                    .unwrap();
                state = State::DATA_SOCKET_CONNECT;
            } else if let State::DATA_SOCKET_CONNECT = state {
                if socket.may_send() {
                    socket.send_slice(&cookie).unwrap();
                    state = State::DATA_COOKIE_SENT;
                }
            } else if let State::TEST_RUNNING = state {
                if socket.can_send() {
                    socket.send_slice(&data).unwrap();
                }
            }
        }
        if state != last_state {
            println!("{:?} -> {:?}", last_state, state);
        }
        last_state = state;
    }
}
