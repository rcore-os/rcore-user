#include <stdio.h>
#include <string.h>
#include <ulib.h>
#include <unistd.h>
#include <syscall.h>

#if defined(__mips__) || defined(__x86_64__)

#if defined(__x86_64__)
#define WIDTH 1024
#define HEIGHT 768
#define BPP 3
#else
#define WIDTH 800
#define HEIGHT 600
#define BPP 1
#endif

char buf[WIDTH * BPP];

volatile char* frame_buf = (volatile char*) 0xA2000000;
int w = WIDTH, h = HEIGHT, x, y, i;
//each iteration, it calculates: newz = oldz*oldz + p, where p is the current pixel, and oldz stars at the origin
float pr, pi; //real and imaginary part of the pixel p
float newRe, newIm, oldRe, oldIm; //real and imaginary parts of new and old z


void plot(float moveX, float moveY, float zoom, int maxIterations, int skip) {
    cprintf("plot\n");
    //loop through every pixel
    volatile char *line_addr = frame_buf;
    for (y = 0; y < h; y++) {
        if (y % skip) {
            memcpy(line_addr, line_addr - WIDTH * BPP, WIDTH * BPP);
            line_addr += WIDTH * BPP;
            continue;
        }
        for (x = 0; x < w; x++) {
            if (x % skip) {
                for (i = 0;i < BPP;i++) {
                    buf[x * BPP + i] = buf[(x - 1) * BPP + i];
                }
                continue;
            }
            // calculate the initial real and imaginary part of z, based on the pixel location and zoom and position values
            pr = 1.5f * (x - w / 2) / (0.5f * zoom * w) + moveX;
            pi = (y - h / 2) / (0.5f * zoom * h) + moveY;
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

            for (i = 0;i < BPP;i++) {
                buf[x * BPP + i] = (color << 5) | (color << 2) | (color >> 1);
            }
        }
        memcpy(line_addr, buf, WIDTH * BPP);
        line_addr += WIDTH * BPP;
    }
}

int main(void) {
#if defined(__x86_64__)
    int fd = sys_open("/dev/fb0", O_WRONLY);
    frame_buf = (volatile char *)sys_mmap(0, WIDTH * HEIGHT * BPP, PROT_WRITE, 0, fd, 0);
#endif
    float zoom = 1, moveX = -0.5, moveY = 0; //you can change these to zoom and change position
    int maxIterations = 255; //after how much iterations the function should stop
    int skip = 4;
    int c;
    plot(moveX, moveY, zoom, maxIterations, skip);

    while ((c = getchar()) > 0) {
        cprintf(" %d\n", c);
        if (c == 'x') {
            skip = 1;
        } else if (c == 'h') {
            moveX -= 0.2f / zoom;
            cprintf("moveX left\n");
        } else if (c == 'l') {
            moveX += 0.2f / zoom;
            cprintf("moveX right\n");
        } else if (c == 'j') {
            moveY += 0.2f / zoom;
            cprintf("moveX down\n");
        } else if (c == 'k') {
            moveY -= 0.2f / zoom;
            cprintf("moveX up\n");
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
            cprintf("x - HD\n");
            cprintf("h - Move left\n");
            cprintf("j - Move down\n");
            cprintf("k - Move up\n");
            cprintf("l - Move right\n");
            cprintf("[ - Zoom out\n");
            cprintf("] - Zoom in\n");
            cprintf("q - Quit\n");
            cprintf("r - Reset\n");
            cprintf("p - Print this help\n");
        } else {
            cprintf("Unrecognized input: %d.\n", c);
        }
        plot(moveX, moveY, zoom, maxIterations, skip);
        skip = 4;
        c = 0;
        cprintf(">");
    }
    return 0;
}

#else

int main(void) {
    cprintf("This program can only run on platforms with floating point support.\n");
    return 0;
}

#endif
