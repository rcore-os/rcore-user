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

int main(int argc, char **argv)
{
	printf("hello audio world!\n");
    int fd;
    fprintf(stderr, "test on gpio (stderr -> Audio)");
    fd = open("/dev/stdout", O_WRONLY);
    if (fd < 0) {
        fprintf(stdout, "fail to open /dev/stdout");
        return 1;
    }

    write(fd, "write through device file!\n", 27); 

	return 0;
}
