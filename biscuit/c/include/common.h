#define __NEED_uintptr_t

#include <arpa/inet.h>
#include <dirent.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/kdev_t.h>
#include <pthread.h>
#include <poll.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/uio.h>
#include <sys/param.h>
#include <sys/un.h>
#include <sys/reboot.h>
#include <sys/resource.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <spawn.h>
#include <unistd.h>
#include <uchar.h>

#define WAIT_ANY (-1)
#include <limits.h>
#define uchar unsigned char
