#include <common.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	printf("syncing...");
	sync();
	printf("done. rebooting...\n");
	reboot(RB_AUTOBOOT);
	return 0;
}
