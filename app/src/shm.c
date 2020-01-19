#include <assert.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/shm.h>
#include <sys/stat.h>
#include <unistd.h>

int time = 2;

void work(int pid) {
  // init
  int t = shmget(20101023, sizeof(int) * 10, 0666 | IPC_CREAT);
  printf("pid=%d shmget=%d\n", pid, t);

  if (pid == 0) {
    int *p = malloc(
        8192); // force shmat to allocate different address for two process.
    printf("pid=%d block_addr=%p\n", pid, p);
  }
  int *arr = shmat(t, NULL, 0);

  if (pid != 0) {
    // parent
    arr[0] = 3;
    arr[1] = 7;
  }

  sleep(time);

  if (pid == 0) {
    // child
    arr[2] = arr[0] + arr[1];
    arr[3] = arr[0] * arr[1];
  }

  sleep(time);

  if (pid != 0) {
    // parent
    printf("pid=%d addr=%p sum=%d mul=%d\n", pid, arr, arr[2], arr[3]);
    assert(arr[2] == 10);
    assert(arr[3] == 21);
    arr[2] = arr[0] * arr[1];
    arr[3] = arr[0] + arr[1];
  }

  sleep(time);

  if (pid == 0) {
    // child
    printf("pid=%d addr=%p mul=%d sum=%d\n", pid, arr, arr[2], arr[3]);
    assert(arr[2] == 21);
    assert(arr[3] == 10);
  }

  shmdt(arr);
}

void test_shm() {
  int pid = fork();
  work(pid);
}

int main(void) {
  printf("I am %d.\n", getpid());
  test_shm();
  printf("Succeed!\n");
  return 0;
}
