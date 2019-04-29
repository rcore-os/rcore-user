#include <stdio.h>
int main()
{
  int child, grandson;
  char *sargs[] = { "/bin/echo", "Son ", "Hello", "World!", NULL};
  char *gargs[] = { "/bin/echo", "Grandson ", "Hello", "World!", NULL};

  if (!(child = fork()))
  {
        /* child */
	printf("child:s1:  pid %d: %d is my father\n", getpid(), getppid());
	if(!(grandson=fork()))
	{
	   printf("grandson: pid %d: %d is my father\n", getpid(), getppid());
	   execve("/bin/echo", gargs, NULL);
	   printf("pid %d: I am back, something is wrong!\n", getpid());
        }else{
	   printf("child:s2: pid %d: %d is my father\n", getpid(), getppid());
	   wait4(grandson, NULL, 0, NULL);
	   execve("/bin/echo", sargs, NULL);
	   printf("pid %d: I am back, something is wrong!\n", getpid());
	}
  }
  else
  {
	int myself = getpid();
	printf("parent: pid %d: %d is my son\n", myself, child);
	wait4(child, NULL, 0, NULL);
	printf("pid %d: done\n", myself);
  }
  return 0;
}
