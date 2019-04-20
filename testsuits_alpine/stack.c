#include <stdio.h>
#include <stdlib.h>
void test(int i)
{
    char temp[1024*1024] = {0};
    
    temp[0] = i;
    temp[0] ++;
    printf("%s %d num = %d!\r\n", __FUNCTION__, __LINE__, temp[0]);
    test(temp[0]);
}
int main(void)
{
    test(0);
    return 0;
}
