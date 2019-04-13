#include <common.h>
#include <stdio.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/ioctl.h>

int main(int argc, char **argv)
{
	printf("hello audio world!\n");
    int fd;
    // fprintf(stderr, "test on gpio (stderr -> Audio)");

    fd = open("/dev/stdout", O_WRONLY);
    if (fd < 0) {
        fprintf(stdout, "fail to open /dev/stdout");
        return 1;
    }
    write(fd, "write through device file!\n", 27); 

    int fd_gpio;
    fd_gpio = open("/dev/gpio", O_WRONLY);
    if (fd_gpio < 0) {
        fprintf(stdout, "fail to open /dev/gpio");
        return 1;
    }
    if (ioctl(fd_gpio, 10, NULL) != 0) {
        fprintf(stdout, "fail to use ioctl on /dev/gpio");
        return 1;
    }
    write(fd_gpio, "1", 1);
    if (ioctl(fd_gpio, 20, NULL) != 0) {
        fprintf(stdout, "fail to use ioctl on /dev/gpio");
        return 1;
    }
    write(fd_gpio, "1", 1);

	return 0;
}
