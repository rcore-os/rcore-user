#include <stdio.h>
#include <stdlib.h>
int *temp[1024*1024];
void test(int i)
{
//    char temp[1024*1024] = {0};
    char *loc;
    temp[i]=malloc(1024*1024);
    *temp[i] =i;
    printf("%s %d num = %d!\r\n", __FUNCTION__, __LINE__, *temp[i]);
    i++;
    //if(i==10) return;
    test(i++);
}
int main(void)
{
    test(0);
    return 0;
}
