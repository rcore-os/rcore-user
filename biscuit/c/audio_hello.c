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
    fprintf(stdout, "stdout test ok\n");
    fprintf(stderr, "audio test ok\n'");

	return 0;
}
