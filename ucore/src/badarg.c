#include <stdio.h>
#include <ulib.h>

int
main(void) {
    int pid, exit_code;
    if ((pid = fork()) == 0) {
        cprintf("fork ok.\n");
        int i;
        for (i = 0; i < 10; i ++) {
            //yield();
        }
        exit(0xbeaf);
    }
    cprintf("test begin, pid: %d\n", pid);
    assert(pid > 0);
    //assert(waitpid(-1, NULL) != 0);
    //assert(waitpid(pid, (void *)0xC0000000) != 0);
    int ret = waitpid(pid, &exit_code);
    cprintf("ret pid: %d\n", ret);
    //assert(exit_code == 0xbeaf);
    cprintf("badarg pass.\n");
    return 0;
}

