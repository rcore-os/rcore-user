use alloc::string::String;
use alloc::vec::Vec;
use core::fmt::{self, Write};

use crate::syscall::{sys_read, sys_write};

pub const STDIN: usize = 0;
pub const STDOUT: usize = 1;

#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => ({
        $crate::io::print(format_args!($($arg)*));
    });
}

#[macro_export]
macro_rules! println {
    ($fmt:expr) => (print!(concat!($fmt, "\n")));
    ($fmt:expr, $($arg:tt)*) => (print!(concat!($fmt, "\n"), $($arg)*));
}

pub fn print(args: fmt::Arguments) {
    StdOut.write_fmt(args).unwrap();
}

pub fn getc() -> u8 {
    let mut c = 0u8;
    loop {
        let len = sys_read(STDIN, &mut c, 1);
        match len {
            1 => return c,
            0 => continue,
            _ => panic!("read stdin len = {}", len),
        }
    }
}

const BEL: u8 = 0x07u8;
const BS: u8 = 0x08u8;
const LF: u8 = 0x0au8;
const CR: u8 = 0x0du8;
const ESC: u8 = 0x1bu8;
const DEL: u8 = 0x7fu8;

pub fn get_line(history: &mut Vec<Vec<u8>>) -> String {
    let mut cursor = 0;
    let mut line_vec = Vec::with_capacity(512);
    let mut history_index = history.len();
    loop {
        match getc() {
            BS | DEL => {
                // Backspace
                if cursor > 0 {
                    cursor -= 1;
                    line_vec.remove(cursor);

                    putc(BS);
                    for byte in &line_vec[cursor..] {
                        putc(*byte);
                    }
                    putc(b' ');
                    for _i in cursor..line_vec.len() {
                        putc(ESC);
                        putc(b'[');
                        putc(b'D');
                    }
                    putc(ESC);
                    putc(b'[');
                    putc(b'D');
                } else {
                    putc(BEL);
                }
            }
            CR | LF => {
                // Return
                putc(CR);
                putc(LF);
                break;
            }
            ESC => {
                match getc() {
                    b'[' => {
                        match getc() {
                            b'D' => {
                                // Left arrow
                                if cursor > 0 {
                                    cursor -= 1;
                                    putc(ESC);
                                    putc(b'[');
                                    putc(b'D');
                                } else {
                                    putc(BEL);
                                }
                            }
                            b'C' => {
                                // Right arrow
                                if cursor < line_vec.len() {
                                    cursor += 1;
                                    putc(ESC);
                                    putc(b'[');
                                    putc(b'C');
                                } else {
                                    putc(BEL);
                                }
                            }
                            direction @ b'A' | direction @ b'B' => {
                                if direction == b'A' && history_index > 0 {
                                    // Up arrow
                                    history_index -= 1;
                                } else if direction == b'B' && history.len() > 0 // usize underflow
                                    && history_index < history.len() - 1
                                {
                                    // Down arrow
                                    history_index += 1;
                                } else {
                                    putc(BEL);
                                    continue;
                                }

                                for _ in 0..line_vec.len() {
                                    putc(ESC);
                                    putc(b'[');
                                    putc(b'D');
                                }
                                for _ in 0..line_vec.len() {
                                    putc(b' ');
                                }
                                for _ in 0..line_vec.len() {
                                    putc(ESC);
                                    putc(b'[');
                                    putc(b'D');
                                }
                                line_vec = history[history_index].clone();
                                cursor = line_vec.len();
                                for byte in &line_vec {
                                    putc(*byte);
                                }
                            }
                            _ => {
                                putc(BEL);
                            }
                        }
                    }
                    _ => {
                        putc(BEL);
                    }
                }
            }
            byte if byte.is_ascii_graphic() || byte == b' ' => {
                line_vec.insert(cursor, byte);
                for byte in &line_vec[cursor..] {
                    putc(*byte);
                }
                cursor += 1;
                for _i in cursor..line_vec.len() {
                    putc(ESC);
                    putc(b'[');
                    putc(b'D');
                }
            }
            _ => {
                // unrecognized characters
                putc(BEL);
            }
        }
    }

    if line_vec.len() > 0 {
        history.push(line_vec.clone());
    }
    String::from_utf8(line_vec).unwrap_or_default()
}

pub fn putc(c: u8) {
    sys_write(STDOUT, &c, 1);
}

struct StdOut;

impl fmt::Write for StdOut {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        if sys_write(STDOUT, s.as_ptr(), s.len()) >= 0 {
            Ok(())
        } else {
            Err(fmt::Error::default())
        }
    }
}

/* VFS flags */
// TODO: use bitflags
// flags for open: choose one of these
pub const O_RDONLY: usize = 0; // open for reading only
pub const O_WRONLY: usize = 1; // open for writing only
pub const O_RDWR: usize = 2; // open for reading and writing
                             // then or in any of these:
pub const O_CREAT: usize = 0x00000004; // create file if it does not exist
pub const O_EXCL: usize = 0x00000008; // error if O_CREAT and the file exists
pub const O_TRUNC: usize = 0x00000010; // truncate file upon open
pub const O_APPEND: usize = 0x00000020; // append on each write
