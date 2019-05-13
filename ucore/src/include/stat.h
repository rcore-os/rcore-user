#ifndef __LIBS_STAT_H__
#define __LIBS_STAT_H__

#include <defs.h>

#if defined(__x86_64__) || defined(__i386__)
struct stat {
    uint64_t	st_dev;
    uint64_t    st_ino;
    uint64_t    st_nlinks;      // number of hard links

    uint32_t	st_mode;        // protection mode and file type
    uint32_t	st_uid;
    uint32_t	st_gid;
    uint32_t	_pad0;

    uint64_t	st_rdev;
    uint64_t	st_size;        // file size (bytes)
    uint64_t	st_blksize;
    uint64_t	st_blocks;      // number of blocks file is using

    uint64_t	st_atime;
    uint64_t	st_atimensec;
    uint64_t	st_mtime;
    uint64_t	st_mtimensec;
    uint64_t	st_ctime;
    uint64_t	st_ctimensec;
};
#else
struct stat {
    uint64_t	st_dev;
    uint64_t	st_ino;
    uint32_t	st_mode;        // protection mode and file type
    uint32_t	st_nlinks;      // number of hard links

    uint32_t	st_uid;
    uint32_t	st_gid;
    uint64_t	st_rdev;
    uint64_t	__pad;

    uint64_t	st_size;        // file size (bytes)
    uint32_t	st_blksize;
    uint32_t	__pad2;
    uint64_t	st_blocks;      // number of blocks file is using

    uint64_t	st_atime;
    uint64_t	st_atimensec;
    uint64_t	st_mtime;
    uint64_t	st_mtimensec;
    uint64_t	st_ctime;
    uint64_t	st_ctimensec;
};
#endif

#define S_IFMT  00170000
#define S_IFSOCK 0140000
#define S_IFLNK	 0120000
#define S_IFREG  0100000
#define S_IFBLK  0060000
#define S_IFDIR  0040000
#define S_IFCHR  0020000
#define S_IFIFO  0010000

#define S_ISLNK(m)	(((m) & S_IFMT) == S_IFLNK)
#define S_ISREG(m)	(((m) & S_IFMT) == S_IFREG)
#define S_ISDIR(m)	(((m) & S_IFMT) == S_IFDIR)
#define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
#define S_ISBLK(m)	(((m) & S_IFMT) == S_IFBLK)
#define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
#define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)

#endif /* !__LIBS_STAT_H__ */

