#include <stdio.h>

char a[4096]="\0";
FILE *fp;
void main(int argc, char** argv){
  if (argc >1)  {
	fp = fopen(argv[1], "r");
	int i=0;
	while (!feof(fp))
	{
		fscanf(fp, "%c", &a[i]);
		printf("%c",a[i]);
		i++;
	}
  } 
}
