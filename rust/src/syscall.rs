#[inline(always)]
fn sys_call(syscall_id: SyscallId, arg0: usize, arg1: usize, arg2: usize, arg3: usize, arg4: usize, arg5: usize) -> i32 {
    let id = syscall_id as usize;
    let ret: i32;

    unsafe {
        #[cfg(any(target_arch = "riscv32", target_arch = "riscv64"))]
            asm!("ecall"
            : "={x10}" (ret)
            : "{x17}" (id), "{x10}" (arg0), "{x11}" (arg1), "{x12}" (arg2), "{x13}" (arg3), "{x14}" (arg4), "{x15}" (arg5)
            : "memory"
            : "volatile");
        #[cfg(target_arch = "x86")]
            asm!("int 0x80"
            : "={eax}" (ret)
            : "{eax}" (id), "{edx}" (arg0), "{ecx}" (arg1), "{ebx}" (arg2), "{edi}" (arg3), "{esi}" (arg4)
            : "memory"
            : "intel" "volatile");
        #[cfg(target_arch = "x86_64")]
            asm!("syscall"
            : "={rax}" (ret)
            : "{rax}" (id), "{rdi}" (arg0), "{rsi}" (arg1), "{rdx}" (arg2), "{r10}" (arg3), "{r8}" (arg4), "{r9}" (arg5)
            : "memory"
            : "intel" "volatile");
        #[cfg(target_arch = "aarch64")]
            asm!("svc 0"
            : "={x0}" (ret)
            : "{x8}" (id), "{x0}" (arg0), "{x1}" (arg1), "{x2}" (arg2), "{x3}" (arg3), "{x4}" (arg4), "{x5}" (arg5)
            : "memory"
            : "volatile");
    }
    ret
}

pub fn sys_exit(code: usize) -> ! {
    sys_call(SyscallId::Exit, code, 0, 0, 0, 0, 0);
    unreachable!()
}


pub fn sys_exec(name: *const u8, argv: *const *const u8, envp: *const *const u8) -> i32 {
    sys_call(SyscallId::Exec, name as usize, argv as usize, envp as usize, 0, 0, 0)
}

pub fn sys_write(fd: usize, base: *const u8, len: usize) -> i32 {
    sys_call(SyscallId::Write, fd, base as usize, len, 0, 0, 0)
}

pub fn sys_read(fd: usize, base: *mut u8, len: usize) -> i32 {
    sys_call(SyscallId::Read, fd, base as usize, len, 0, 0, 0)
}

pub fn sys_open(path: &str, flags: usize) -> i32 {
    // UNSAFE: append '\0' to the string
    use core::mem::replace;
    let end = unsafe { &mut *(path.as_ptr().offset(path.len() as isize) as *mut u8) };
    let backup = replace(end, 0);
    let ret = sys_call(SyscallId::Open, path.as_ptr() as usize, flags, 0, 0, 0, 0);
    *end = backup;
    ret
}

pub fn sys_close(fd: usize) -> i32 {
    sys_call(SyscallId::Close, fd, 0, 0, 0, 0, 0)
}

pub fn sys_dup2(fd1: usize, fd2: usize) -> i32 {
    sys_call(SyscallId::Dup2, fd1, fd2, 0, 0, 0, 0)
}

/// Fork the current process. Return the child's PID.
pub fn sys_fork() -> i32 {
    sys_call(SyscallId::Fork, 0, 0, 0, 0, 0, 0)
}

/// Wait the process exit.
/// Return the PID. Store exit code to `code` if it's not null.
pub fn sys_wait(pid: usize, code: *mut i32) -> i32 {
    sys_call(SyscallId::Wait, pid, code as usize, 0, 0, 0, 0)
}

pub fn sys_yield() -> i32 {
    sys_call(SyscallId::Yield, 0, 0, 0, 0, 0, 0)
}

/// Kill the process
pub fn sys_kill(pid: usize) -> i32 {
    sys_call(SyscallId::Kill, pid, 0, 0, 0, 0, 0)
}

/// Get the current process id
pub fn sys_getpid() -> i32 {
    sys_call(SyscallId::GetPid, 0, 0, 0, 0, 0, 0)
}

#[repr(C)]
#[derive(Debug, Copy, Clone)]
pub struct TimeSpec {
    sec: u64,
    nsec: u64,
}

pub fn sys_sleep(time: usize) -> i32 {
    let ts = TimeSpec {
        sec: time as u64,
        nsec: 0
    };
    sys_call(SyscallId::Sleep, &ts as *const TimeSpec as usize, 0, 0, 0, 0, 0)
}

pub fn sys_get_time() -> i32 {
    sys_call(SyscallId::GetTime, 0, 0, 0, 0, 0, 0)
}

pub fn sys_set_priority(priority: usize) -> i32 {
    sys_call(SyscallId::SetPriority, priority, 0, 0, 0, 0, 0)
}

pub fn sys_arch_prctl(code: i32, addr: usize) -> i32 {
    sys_call(SyscallId::ArchPrctl, code as usize, addr, 0, 0, 0, 0)
}

#[allow(dead_code)]
enum SyscallId {
    Read = 0,
    Write = 1,
    Open = 2,
    Close = 3,
    Fstat = 4,
    Seek = 8,
    Mmap = 9,
    Munmap = 11,
    Yield = 24,
    Dup2 = 33,
    Sleep = 35,
    GetPid = 39,
    Clone = 56,
    Fork = 57,
    Exec = 59,
    Exit = 60,
    Wait = 61,
    Kill = 62,
    Fsync = 74,
    GetDirEntry = 78,
    GetCwd = 79,
    GetTime = 96,
    SetPriority = 141,
    ArchPrctl = 158,
}
