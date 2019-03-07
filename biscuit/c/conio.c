#include <common.h>

int main(int argc, char **argv)
{
	while (1) {
        printf("input:");
        char buf[1024];
		char *ret = gets(buf);
		if (!ret)
			break;
		printf("got: %s\n", ret);
	}

	return 0;
}
