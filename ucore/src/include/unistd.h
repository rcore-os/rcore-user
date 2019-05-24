#ifndef __LIBS_UNISTD_H__
#define __LIBS_UNISTD_H__

#define T_SYSCALL           0x80

/* syscall number */
#if defined(__x86_64__) || defined(__i386__)

#define SYS_exit            60
#define SYS_fork            57
#define SYS_wait            61
#define SYS_exec            59
#define SYS_clone           56
#define SYS_yield           24
#define SYS_sleep           35
#define SYS_kill            62
#define SYS_gettime         96
#define SYS_getpid          39
#define SYS_mmap            9
#define SYS_munmap          11
#define SYS_shmem           -1
#define SYS_pgdir           -1
#define SYS_openat          257
#define SYS_close           3
#define SYS_read            0
#define SYS_write           1
#define SYS_seek            8
#define SYS_fstat           5
#define SYS_fsync           74
#define SYS_getcwd          79
#define SYS_getdirentry64   217
#define SYS_dup3            292
/* ONLY FOR LAB6 */
#define SYS_set_priority    141

#elif defined(__mips__)
#define MIPS_SYSCALL        4000
#define SYS_exit            (MIPS_SYSCALL + 1)
#define SYS_fork            (MIPS_SYSCALL + 2)
#define SYS_wait            (MIPS_SYSCALL + 114)
#define SYS_exec            (MIPS_SYSCALL + 11)
#define SYS_clone           (MIPS_SYSCALL + 120)
#define SYS_yield           (MIPS_SYSCALL + 162)
#define SYS_sleep           (MIPS_SYSCALL + 166)
#define SYS_kill            (MIPS_SYSCALL + 37)
#define SYS_gettime         (MIPS_SYSCALL + 78)
#define SYS_getpid          (MIPS_SYSCALL + 20)
#define SYS_mmap            (MIPS_SYSCALL + 90)
#define SYS_munmap          (MIPS_SYSCALL + 91)
#define SYS_shmem           (-1)
#define SYS_pgdir           (-1)
#define SYS_openat          (MIPS_SYSCALL + 288)
#define SYS_close           (MIPS_SYSCALL + 6)
#define SYS_read            (MIPS_SYSCALL + 3)
#define SYS_write           (MIPS_SYSCALL + 4)
#define SYS_seek            (MIPS_SYSCALL + 18)
#define SYS_fstat           (MIPS_SYSCALL + 198)
#define SYS_fsync           (MIPS_SYSCALL + 118)
#define SYS_getcwd          (MIPS_SYSCALL + 203)
#define SYS_getdirentry64   (MIPS_SYSCALL + 219)
#define SYS_dup3            (MIPS_SYSCALL + 327)
/* ONLY FOR LAB6 */
#define SYS_set_priority    141

#else

#define SYS_exit            93
#define SYS_fork            -1
#define SYS_wait            260
#define SYS_exec            221
#define SYS_clone           220
#define SYS_yield           124
#define SYS_sleep           101
#define SYS_kill            129
#define SYS_gettime         169
#define SYS_getpid          172
#define SYS_mmap            222
#define SYS_munmap          215
#define SYS_shmem           -1
#define SYS_pgdir           -1
#define SYS_openat          56
#define SYS_close           57
#define SYS_read            63
#define SYS_write           64
#define SYS_seek            62
#define SYS_fstat           80
#define SYS_fsync           82
#define SYS_getcwd          17
#define SYS_getdirentry64   61
#define SYS_dup3            24
/* ONLY FOR LAB6 */
#define SYS_set_priority    140

#endif

/* SYS_fork flags */
#define CLONE_VM            0x00000100  // set if VM shared between processes
#define CLONE_THREAD        0x00000200  // thread group
#define CLONE_FS            0x00000800  // set if shared between processes
#define CLONE_VFORK         0x00004000  // set if the parent wants the child to wake it up on mm_release

/* VFS flags */
// flags for open: choose one of these
#define O_RDONLY            0           // open for reading only
#define O_WRONLY            1           // open for writing only
#define O_RDWR              2           // open for reading and writing
// then or in any of these:
#define O_CREAT             0x00000004  // create file if it does not exist
#define O_EXCL              0x00000008  // error if O_CREAT and the file exists
#define O_TRUNC             0x00000010  // truncate file upon open
#define O_APPEND            0x00000020  // append on each write
// additonal related definition
#define O_ACCMODE           3           // mask for O_RDONLY / O_WRONLY / O_RDWR

#define NO_FD               -0x9527     // invalid fd

/* lseek codes */
#define LSEEK_SET           0           // seek relative to beginning of file
#define LSEEK_CUR           1           // seek relative to current position in file
#define LSEEK_END           2           // seek relative to end of file

#define FS_MAX_DNAME_LEN    31
#define FS_MAX_FNAME_LEN    255
#define FS_MAX_FPATH_LEN    4095

#define EXEC_MAX_ARG_NUM    32
#define EXEC_MAX_ARG_LEN    4095

#define PROT_WRITE           2

#endif /* !__LIBS_UNISTD_H__ */

