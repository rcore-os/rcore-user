#define _GNU_SOURCE
#include <assert.h>
#include <unistd.h>

int main(void) {
    void *b;
    char *p, *end;

    b = sbrk(0);
    p = (char *)b;
    end = p + 0x1000000;
    brk(end);
    while (p < end) {
        *(p++) = 1;
    }
    brk(b);
    return 0;
}
