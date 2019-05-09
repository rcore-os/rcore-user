#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define DEPTH 4
#define SLEEP_TIME 1

int main(int argc, char **argv) {

    if (argc != 2) {
      fprintf(stderr, "Usage: %s <num>\n", argv[0]);
      exit(2);
    }
	int num=atoi(argv[1]);
	if (num<0) {
      fprintf(stderr, "num error %d\n", num);
      exit(3);
    }
    
	for(int i=0;i<num;i++) {
      if( fork()==0) {
        printf("  idx %d, id %d  \n",i, getpid());
		exit(0);
      }
    } 
    printf("  main process  id %d   \n", getpid());
	exit(0);
}

