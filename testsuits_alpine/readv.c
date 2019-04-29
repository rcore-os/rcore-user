#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/uio.h>
char head[1024],foo[48], bar[51], baz[49];
struct iovec iov[3];
int main ()
{


        ssize_t nr;
        int fd, i;

        fd = open ("hello.sh", O_RDONLY);
        if (fd==-1){
                perror ("open");
                return 1;
        }
	    nr=read(fd, head, sizeof(head));
	    if(nr==-1) {
            perror("read");
            return 2;
        }

        printf ("read size %d, head: %s\n", nr, (char *) head);

        /* set up our iovec structures */
        iov[0].iov_base = foo;
        iov[0].iov_len = sizeof (foo);
        iov[1].iov_base = bar;
        iov[1].iov_len = sizeof (bar);
        iov[2].iov_base = baz;
        iov[2].iov_len = sizeof (baz);

        /* read into the structures with a single call */
        nr = readv (fd, iov, 3);
        if (nr==-1) {
                perror ("readv");
                return 1;
        }

        for (i = 0; i < 3; i++)
                printf ("IOV%d: size:%d %s\n", i, nr, (char *) iov[i].iov_base);

        if (close (fd)) {
                perror ("close");
                return 1;
        }

        return 0;
}
