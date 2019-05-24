#include <defs.h>
#include <unistd.h>
#include <stdarg.h>
#include <syscall.h>
#include <stat.h>
#include <dirent.h>


#define MAX_ARGS            5

static inline int
syscall(int num, ...) {
    va_list ap;
    va_start(ap, num);
    size_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, size_t);
    }
    va_end(ap);

#if defined(__x86_64__)
    register long r10 __asm__("r10") = a[3];
    register long r8 __asm__("r8") = a[4];

    asm volatile (
        "syscall"
        : "=a" (ret)
        : "a" (num),
          "D" (a[0]),
          "S" (a[1]),
          "d" (a[2]),
          "r" (r10),
          "r" (r8)
        : "rcx", "r11", "memory");
#elif defined(__riscv_xlen)
    register long a7 __asm__("a7") = num;
	register long a0 __asm__("a0") = a[0];
	register long a1 __asm__("a1") = a[1];
	register long a2 __asm__("a2") = a[2];
	register long a3 __asm__("a3") = a[3];
	register long a4 __asm__("a4") = a[4];
	register long a5 __asm__("a5") = a[5];
    asm volatile (
    "ecall\n"
    : "+r"(a0)
    : "r"(a7), "r"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5)
    : "memory"
    );
    ret = a0;
#elif defined(__aarch64__)
    asm volatile (
        "ldr w8, %1\n"
        "ldr x0, %2\n"
        "ldr x1, %3\n"
        "ldr x2, %4\n"
        "ldr x3, %5\n"
        "ldr x4, %6\n"
        "svc 0\n"
        "str w0, %0"
         : "=m" (ret)
         : "m" (num),
           "m" (a[0]),
           "m" (a[1]),
           "m" (a[2]),
           "m" (a[3]),
           "m" (a[4])
        : "cc", "memory"
      );
#elif defined(__mips__)
// mips n32 abi
	register long a0 __asm__("$4") = a[0];
	register long a1 __asm__("$5") = a[1];
	register long a2 __asm__("$6") = a[2];
	register long a3 __asm__("$7") = a[3];
    register long a4 __asm__("$8") = a[4];
    register long a5 __asm__("$9") = a[5];
	register long v0 __asm__("$2");
	__asm__ __volatile__ (
		"addu $2,$0,%2 ; syscall"
		: "=&r"(v0), "=r"(a3)
        : "ir"(num), "0"(v0), "1"(a3), "r"(a0), "r"(a1), "r"(a2), "r"(a3), "r"(a4), "r"(a5)
		: "$1", "$3", "$10", "$11", "$12", "$13",
		  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
    ret = a3 ? -v0 : v0;
#endif
    return ret;
}

int
sys_exit(int error_code) {
    return syscall(SYS_exit, error_code);
}

int
sys_fork(void) {
    const int SIGCHILD = 17;
    return syscall(SYS_clone, CLONE_VFORK | CLONE_VM | SIGCHILD, 0);
}

int
sys_wait(int pid, int *store) {
    return syscall(SYS_wait, pid, store);
}

int
sys_yield(void) {
    return syscall(SYS_yield);
}

int
sys_kill(int pid) {
    return syscall(SYS_kill, pid);
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
}

int
sys_pgdir(void) {
    return syscall(SYS_pgdir);
}

void
sys_set_priority(uint32_t priority)
{
    syscall(SYS_set_priority, priority);
}

int
sys_sleep(unsigned int time) {
    return syscall(SYS_sleep, time);
}

int
sys_gettime(void) {
    return syscall(SYS_gettime);
}

int
sys_exec(const char *name, int argc, const char **argv) {
    return syscall(SYS_exec, name, argc, argv);
}

int
sys_open(const char *path, uint32_t open_flags) {
    const int AT_FDCWD = -100;
    return syscall(SYS_openat, AT_FDCWD, path, open_flags);
}

int
sys_close(int fd) {
    return syscall(SYS_close, fd);
}

int
sys_read(int fd, void *base, size_t len) {
    return syscall(SYS_read, fd, base, len);
}

int
sys_write(int fd, void *base, size_t len) {
    return syscall(SYS_write, fd, base, len);
}

int
sys_seek(int fd, off_t pos, int whence) {
    return syscall(SYS_seek, fd, pos, whence);
}

int
sys_fstat(int fd, struct stat *stat) {
    return syscall(SYS_fstat, fd, stat);
}

int
sys_fsync(int fd) {
    return syscall(SYS_fsync, fd);
}

int
sys_getcwd(char *buffer, size_t len) {
    return syscall(SYS_getcwd, buffer, len);
}

int
sys_getdirentry(int fd, struct dirent *dirent) {
    return syscall(SYS_getdirentry64, fd, dirent);
}

int
sys_dup(int fd1, int fd2) {
    return syscall(SYS_dup3, fd1, fd2);
}

void *
sys_mmap(void *addr, size_t len, int prot, int flags, int fd, size_t offset) {
    return syscall(SYS_mmap, addr, len, prot, flags, fd, offset);
}
