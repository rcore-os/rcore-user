#include <stdio.h>
#include <sys/sem.h>
#include <unistd.h>

/*struct sembuf {
    unsigned short sem_num;
    short sem_op;
    short sem_flg;
};*/

void set(struct sembuf* s, int del, int flg) {
    s[0].sem_num = 0;
    s[0].sem_op = del;
    s[0].sem_flg = flg;
}


int nsems = 2;
int flag = IPC_CREAT|0666;
int time = 3;
    
struct sembuf lok[1];
struct sembuf unlok[1];
struct sembuf undolok[1];

void test_general (int t) {
    int pid = fork();
    printf("fork: %d\n", pid);
    if (pid == 0) {
        // child
        printf("Child Will Lock!\n");
        semop(t, lok, 1);
        printf("Child Lock!\n");
        sleep(time);
        printf("Child Will Unlock!\n");
        semop(t, unlok, 1);
        printf("Child Unlock!\n");
    } else {
        //parent
        printf("Parent Will Lock!\n");
        semop(t, lok, 1);
        printf("Parent Lock!\n");
        sleep(time);
        printf("Parent Will Unlock!\n");
        semop(t, unlok, 1);
        printf("Parent Unlock!\n");
    }
}

void test_undo (int t) {
    int pid = fork();
    printf("fork: %d\n", pid);
    if (pid == 0) {
        // child
        printf("Child Will Lock!\n");
        semop(t, undolok, 1);
        printf("Child Lock!\n");
        sleep(time);
        /*printf("Child Will Unlock!\n");
        semop(t, unlok, 1);
        printf("Child Unlock!\n");*/
    } else {
        //parent
        printf("Parent Will Lock!\n");
        semop(t, undolok, 1);
        printf("Parent Lock!\n");
        sleep(time);
        /*printf("Parent Will Unlock!\n");
        semop(t, unlok, 1);
        printf("Parent Unlock!\n");*/
    }
}

int main(void) {
    printf("I am %d.\n", getpid());

    int t = semget(20101023, nsems, flag);
    printf("semget: %d\n", t);

    set(lok, -1, 0);
    set(undolok, -1, SEM_UNDO);
    set(unlok, 1, 0);
    printf("semctl: %d\n", semctl(t, 0, SETVAL, 1));

    test_undo(t);
    
    printf("Succeed!\n");
    return 0;
}