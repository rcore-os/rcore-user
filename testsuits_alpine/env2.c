#include<stdlib.h>
#include<stdio.h>
#include<unistd.h>

//extern char **environ;
//char **env = environ;
int main(int argc, char * argv [] , char ** environ)
{
puts("child, evn2----------------------\n");
while(*environ){
   puts(*environ);   
   environ++;
}

char * p;
puts("----------------------\n");
if((p=getenv("USER")))
printf("USER =%s\n",p);
setenv("USER","TEST",1);
printf("USER=%s\n",getenv("USER"));
unsetenv("USER");
printf("USER=%s\n",getenv("USER"));
setenv("USER","TEST",1);
return 0;
}
