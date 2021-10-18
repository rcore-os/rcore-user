/*
To test that the Linux framebuffer is set up correctly, and that the device permissions
are correct, use the program below which opens the frame buffer and draws a gradient-
filled red square:
retrieved from:
Testing the Linux Framebuffer for Qtopia Core (qt4-x11-4.2.2)
http://cep.xor.aps.anl.gov/software/qt4-x11-4.2.2/qtopiacore-testingframebuffer.html
*/

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

int main()
{
    int fbfd = 0;
    size_t size, screensize;
    struct fb_var_screeninfo vinfo;
    struct fb_fix_screeninfo finfo;
    volatile char *fbp = 0;
    int x = 0, y = 0;
    long int location = 0;

    // Open the file for reading and writing
    fbfd = open("/dev/fb0", O_RDWR);
    if (fbfd == -1) {
        perror("Error: cannot open framebuffer device");
        exit(1);
    }
    printf("The framebuffer device was opened successfully.\n");

    // Get fixed screen information
    if (ioctl(fbfd, FBIOGET_FSCREENINFO, &finfo) == -1) {
        perror("Error reading fixed information");
        exit(2);
    }

    // Get variable screen information
    if (ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo) == -1) {
        perror("Error reading variable information");
        exit(3);
    }

    // Dump fixed screen information
    size = sizeof(struct fb_fix_screeninfo);
    printf("sizeof(struct fb_fix_screeninfo): %ld\n", size);
    for (int i = 0; i < size; i += 16) {
        printf("%02x: ", i);
        for (int j = 0; j < 16 && i + j < size; j++)
            printf("%02x ", *((unsigned char *)&finfo + i + j));
        puts("");
    }

    // Dump variable screen information
    size = sizeof(struct fb_var_screeninfo);
    printf("sizeof(struct fb_var_screeninfo): %ld\n", size);
    for (int i = 0; i < size; i += 16) {
        printf("%02x: ", i);
        for (int j = 0; j < 16 && i + j < size; j++)
            printf("%02x ", *((unsigned char *)&vinfo + i + j));
        puts("");
    }

    // Figure out the size of the screen in bytes
    screensize = vinfo.xres * vinfo.yres * vinfo.bits_per_pixel / 8;

    printf("%dx%d, %dbpp, screensize=%ld\n", vinfo.xres, vinfo.yres, vinfo.bits_per_pixel, screensize);

    // Map the device to memory
    fbp = (char *)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0);
    if (fbp == (void *)-1) {
        perror("Error: failed to map framebuffer device to memory");
        exit(4);
    }
    printf("The framebuffer device was mapped to memory successfully.\n");

    // Where we are going to put the pixel
    x = 100;
    y = 100;

    // Figure out where in memory to put the pixel
    for (y = 100; y < 300; y++)
        for (x = 100; x < 300; x++) {

            location = (x + vinfo.xoffset) * (vinfo.bits_per_pixel / 8) +
                       (y + vinfo.yoffset) * finfo.line_length;

            if (vinfo.bits_per_pixel == 32) {
                *(fbp + location) = 100;                     // Some blue
                *(fbp + location + 1) = 15 + (x - 100) / 2;  // A little green
                *(fbp + location + 2) = 200 - (y - 100) / 5; // A lot of red
                *(fbp + location + 3) = 0;                   // No transparency
            } else {
                // assume 16bpp
                int b = 10;
                int g = (x - 100) / 6;       // A little green
                int r = 31 - (y - 100) / 16; // A lot of red
                unsigned short int t = r << 11 | g << 5 | b;
                *((unsigned short int *)(fbp + location)) = t;
            }

        }
    munmap((void *)fbp, screensize);
    close(fbfd);
    return 0;
}
