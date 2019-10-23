#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <linux/fb.h>

#if !defined(__riscv)

#include <bad_apple.h>

#define WIN_SIZE 256
#define VID_W 800
#define VID_H 600

typedef unsigned int pixel_t;

int width, height, bpp;
volatile char* frame_buf;

unsigned char win[WIN_SIZE];
int win_e = 0;
int win_n = 0;
const unsigned char *buf = BAD_APPLE_BIN;

int inf = 0;
int x = 0;
int y = 0;
int pos = 0;

static inline void put_in_win(unsigned char c) {
    if (win_n < WIN_SIZE) {
        //cprintf("put_in_win A %hhx\n", c);
        win[win_n] = c;
        win_n ++;
    } else {
        //cprintf("put_in_win B %hhx\n", c);
        win[win_e] = c;
        win_e = (win_e + 1) % WIN_SIZE;
    }
}

void printwin() {
    for (int i = 0; i < win_n; i++) {
        printf("%hhx ", win[(i + win_e) % WIN_SIZE]);
    }
    printf("\n");
}

static inline void out_byte(pixel_t b) {
    if (x < height && y < width)
        *((pixel_t*) &frame_buf[(x * width + y) * bpp]) = b;
    y += 4;
    if (y == VID_W) {
        x = (x + 1) % VID_H;
        y = 0;
    }
}

static inline void expand_pixel(unsigned char color) {
    pixel_t packed_color = color > 0 ? (1llu << (bpp * 8)) - 1 : 0;
    out_byte(packed_color);
}

void decompress(int n) {
    int i, j, old_win;
    unsigned char idx, length, byte;
    int real;
    for (i = 0; i < n; i += 3) {
        idx = buf[i];
        length = buf[i+1];
        byte = buf[i+2];
        //cprintf("triplet: %d %d %d \n", idx, length, byte);
        // cprintf("%d %d %d\n", idx, length, byte);
        old_win = win_e;
        real = (int) length;
        if (real) {
            real += 1;
        }
        for (j = 0; j < real; j++) {
            unsigned char c = win[(old_win + idx + j) % WIN_SIZE];
            //cprintf("from win %hhx\n", c);
            expand_pixel(c >> 4);
            expand_pixel(c & 0xf);
            put_in_win(c);
        }
        expand_pixel(byte >> 4);
        expand_pixel(byte & 0xf);
        put_in_win(byte);
        //printwin();
    }
    return;
}

int main() {
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

    printf("%d, %d, %d\n", width, height, bpp * 8);

    decompress(BAD_APPLE_SIZE);
    printf("%d\n", inf);
    return 0;
}

#else

int main() {
    printf("This program can not be run on RISCV platform.\n");
    return 0;
}

#endif
