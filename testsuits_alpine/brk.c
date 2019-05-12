/* sbrk and brk example */
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main(int argc, char ** argv)
{
    int *curr_brk, *tmp_brk = NULL;
    int num,i;
    if(argc >1) { num=atoi(argv[1]);}
    printf("Welcome to sbrk example:%d  num %d\n", getpid(),num);
    for(i=0;i<num;i++) {

    /* sbrk(0) gives current program break location */
    tmp_brk = curr_brk = sbrk(0);
    printf("%d: Program Break Location1:%p\n", i, curr_brk);
    /* brk(addr) increments/decrements program break location */
    brk((char*)curr_brk + 4096);
    curr_brk = sbrk(0);
    printf("%d: Program break Location2:%p\n", i, curr_brk);
	*(curr_brk-20)=1;
 //   brk(tmp_brk);
 //   curr_brk = sbrk(0);
 //   printf("Program Break Location3:%p\n", curr_brk);
    }
    return 0;
}
