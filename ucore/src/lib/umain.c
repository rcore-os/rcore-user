#include <ulib.h>
#include <unistd.h>
#include <file.h>
#include <stat.h>

int main(int argc, char *argv[]);

void
umain(int argc, char *argv[]) {
    int ret = main(argc, argv);
    exit(ret);
}
