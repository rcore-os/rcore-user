#include <stdio.h>
#include <file.h>
#include <unistd.h>

#ifdef __mips__

// the c file is included ON PURPOSE
#include <bad_apple.c>


#define OFFLOAD

#define WIN_SIZE 256
#define READ_BUF 30000
#define VID_W 800 
#define VID_H 600
#define SCREEN_W 800
#define SCREEN_H 600

volatile char* frame_buf = (volatile char*) 0xA2000000;

unsigned char win[WIN_SIZE];
int win_e = 0;
int win_n = 0;
unsigned char *buf = BAD_APPLE_BIN;

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
        cprintf("%hhx ", win[(i + win_e) % WIN_SIZE]);
    }
    cprintf("\n");
}

static inline void out_byte(unsigned int b) {
    *((int*) &frame_buf[x * SCREEN_W + y]) = b;
    y += 4;
    if (y == VID_W) {
        x = (x + 1) % VID_H;
        y = 0;
    }
}

static inline void expand_byte(unsigned short b) {
    #ifdef OFFLOAD
    *((short*) &frame_buf[x * SCREEN_W + y]) = (b >> 4);
    y += 4;
    if (y == VID_W) {
        x = (x + 1) % VID_H;
        y = 0;
    }
    *((short*) &frame_buf[x * SCREEN_W + y]) = b;
    y += 4;
    if (y == VID_W) {
        x = (x + 1) % VID_H;
        y = 0;
    }
    #else
    //cprintf("inflated: %d %hhx \n", inf, b);
    inf += 1;
    unsigned char mask = 128;
    unsigned int inflate_buf = 0;
    for (int i = 0; i < 4; i++) {
        inflate_buf |= (((mask >> i) & b) ? 0xff : 0x00) << (8*i);
    }
    out_byte(inflate_buf);
    inflate_buf = 0;
    mask = 8;
    for (int i = 0; i < 4; i++) {
        inflate_buf |= (((mask >> i) & b) ? 0xff : 0x00) << (8*i);
    }
    out_byte(inflate_buf);
    return;
    #endif
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
            expand_byte((unsigned short) c);
            put_in_win(c);
        }
        expand_byte(byte);
        put_in_win(byte);
        //printwin();
    }
    return;
}

int main() {
    decompress(BAD_APPLE_SIZE);
    cprintf("%d\n", inf);
    return 0;
}

#else

int main() {
    cprintf("This program can only be run on MIPS platform.\n");
    return 0;
}

#endif