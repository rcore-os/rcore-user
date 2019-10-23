#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <linux/fb.h>

#if !defined(__riscv)

char *buf;

int width, height, bpp;
volatile char *frame_buf;
int x, y, i;
//each iteration, it calculates: newz = oldz*oldz + p, where p is the current pixel, and oldz stars at the origin
float pr, pi;                     //real and imaginary part of the pixel p
float newRe, newIm, oldRe, oldIm; //real and imaginary parts of new and old z


void plot(float moveX, float moveY, float zoom, int maxIterations, int skip) {
    printf("plot\n");
    //loop through every pixel
    volatile char *line_addr = frame_buf;
    for (y = 0; y < height; y++) {
        if (y % skip) {
            memcpy(line_addr, line_addr - width * bpp, width * bpp);
            line_addr += width * bpp;
            continue;
        }
        for (x = 0; x < width; x++) {
            if (x % skip) {
                for (i = 0; i < bpp; i++) {
                    buf[x * bpp + i] = buf[(x - 1) * bpp + i];
                }
                continue;
            }
            // calculate the initial real and imaginary part of z, based on the pixel location and zoom and position values
            pr = 1.5f * (x - width / 2) / (0.5f * zoom * width) + moveX;
            pi = (y - height / 2) / (0.5f * zoom * height) + moveY;
            newRe = newIm = oldRe = oldIm = 0; //these should start at 0,0
            //"i" will represent the number of iterations
            int i;
            //start the iteration process
            for (i = 0; i < maxIterations; i++) {
                //remember value of previous iteration
                oldRe = newRe;
                oldIm = newIm;
                //the actual iteration, the real and imaginary part are calculated
                newRe = oldRe * oldRe - oldIm * oldIm + pr;
                newIm = 2.0f * oldRe * oldIm + pi;
                //if the point is outside the circle with radius 2: stop
                if ((newRe * newRe + newIm * newIm) > 4)
                    break;
            }

            int color = i * 255 / maxIterations;

            for (i = 0; i < bpp; i++) {
                buf[x * bpp + i] = (color << 5) | (color << 2) | (color >> 1);
            }
        }
        memcpy(line_addr, buf, width * bpp);
        line_addr += width * bpp;
    }
}

int main(void) {
    struct fb_var_screeninfo vinfo;
    int fd = open("/dev/fb0", O_WRONLY);
    if (!fd) {
        printf("Error: cannot open framebuffer device.\n");
        exit(1);
    }

    if (ioctl(fd, FBIOGET_VSCREENINFO, &vinfo)) {
        printf("Error: cannot reading fb variable information.\n");
        exit(1);
    }

    bpp = vinfo.bits_per_pixel / 8;
    width = vinfo.xres;
    height = vinfo.yres;
    frame_buf = (volatile char *)mmap(0, width * height * bpp, PROT_WRITE, MAP_SHARED, fd, 0);
    if (frame_buf == (void *)-1) {
        printf("Error: cannot map framebuffer memory.\n");
        exit(1);
    }
    close(fd);

    buf = malloc(width * height * bpp);
    printf("%d, %d, %d\n", width, height, bpp * 8);

    float zoom = 1, moveX = -0.5, moveY = 0; //you can change these to zoom and change position
    int maxIterations = 255;                 //after how much iterations the function should stop
    int skip = 4;
    int c;
    plot(moveX, moveY, zoom, maxIterations, skip);

    while ((c = getchar()) > 0) {
        printf(" %d\n", c);
        if (c == 'x') {
            skip = 1;
        } else if (c == 'a') {
            moveX -= 0.2f / zoom;
            printf("moveX left\n");
        } else if (c == 'd') {
            moveX += 0.2f / zoom;
            printf("moveX right\n");
        } else if (c == 's') {
            moveY += 0.2f / zoom;
            printf("moveX down\n");
        } else if (c == 'w') {
            moveY -= 0.2f / zoom;
            printf("moveX up\n");
        } else if (c == ']') {
            zoom += 3;
        } else if (c == '[') {
            zoom -= 3;
            if (zoom <= 1)
                zoom = 1;
        } else if (c == 'q') {
            break;
        } else if (c == 'r') {
            zoom = 1;
            moveX = -0.5;
            moveY = 0;
        } else if (c == 'p') {
            printf("x - HD\n");
            printf("a - Move left\n");
            printf("s - Move down\n");
            printf("w - Move up\n");
            printf("d - Move right\n");
            printf("[ - Zoom out\n");
            printf("] - Zoom in\n");
            printf("q - Quit\n");
            printf("r - Reset\n");
            printf("p - Print this help\n");
        } else {
            printf("Unrecognized input: %d.\n", c);
        }
        plot(moveX, moveY, zoom, maxIterations, skip);
        skip = 4;
        c = 0;
        printf(">");
    }
    return 0;
}

#else

int main(void) {
    printf("This program can only run on platforms with floating point support.\n");
    return 0;
}

#endif
