#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>

extern char **environ;
char **env ;
int main()
{
env= environ;
while(*environ){
   puts(*environ);   
   environ++;
}

char * p;
puts("----------------------\n");
if((p=getenv("USER")))
printf("USER =%s\n",p);
setenv("USER","test",1);
printf("USER=%s\n",getenv("USER"));
//unsetenv("USER");
//printf("USER=%s\n",getenv("USER"));
char * argv[]={"env2", NULL};
execve("./env2",argv,env);
return 0;
}
