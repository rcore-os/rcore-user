#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/times.h>
#include <unistd.h>

typedef unsigned int __u32;
typedef unsigned short __u16;
typedef __signed__ int __s32;

// linux/input-event-codes.h
#define KEY_ESC 1
#define KEY_W 17
#define KEY_R 19
#define KEY_A 30
#define KEY_S 31
#define KEY_D 32

// #define BTN_LEFT 0x110
// #define BTN_RIGHT 0x111
// #define BTN_MIDDLE 0x112

// linux/fb.h
#define FBIOGET_VSCREENINFO 0x4600
#define FBIOGET_FSCREENINFO 0x4602

struct fb_bitfield
{
    __u32 offset;    /* beginning of bitfield	*/
    __u32 length;    /* length of bitfield		*/
    __u32 msb_right; /* != 0 : Most significant bit is */
                     /* right */
};

struct fb_var_screeninfo
{
    __u32 xres; /* visible resolution		*/
    __u32 yres;
    __u32 xres_virtual; /* virtual resolution		*/
    __u32 yres_virtual;
    __u32 xoffset; /* offset from virtual to visible */
    __u32 yoffset; /* resolution			*/

    __u32 bits_per_pixel; /* guess what			*/
    __u32 grayscale;      /* 0 = color, 1 = grayscale,	*/
    /* >1 = FOURCC			*/
    struct fb_bitfield red;   /* bitfield in fb mem if true color, */
    struct fb_bitfield green; /* else only length is significant */
    struct fb_bitfield blue;
    struct fb_bitfield transp; /* transparency			*/

    __u32 nonstd; /* != 0 Non standard pixel format */

    __u32 activate; /* see FB_ACTIVATE_*		*/

    __u32 height; /* height of picture in mm    */
    __u32 width;  /* width of picture in mm     */

    __u32 accel_flags; /* (OBSOLETE) see fb_info.flags */

    /* Timing: All values in pixclocks, except pixclock (of course) */
    __u32 pixclock;     /* pixel clock in ps (pico seconds) */
    __u32 left_margin;  /* time from sync to picture	*/
    __u32 right_margin; /* time from picture to sync	*/
    __u32 upper_margin; /* time from sync to picture	*/
    __u32 lower_margin;
    __u32 hsync_len;   /* length of horizontal sync	*/
    __u32 vsync_len;   /* length of vertical sync	*/
    __u32 sync;        /* see FB_SYNC_*		*/
    __u32 vmode;       /* see FB_VMODE_*		*/
    __u32 rotate;      /* angle we rotate counter clockwise */
    __u32 colorspace;  /* colorspace for FOURCC-based modes */
    __u32 reserved[4]; /* Reserved for future compatibility */
};

struct fb_fix_screeninfo
{
    char id[16];              /* identification string eg "TT Builtin" */
    unsigned long smem_start; /* Start of frame buffer mem */
    /* (physical address) */
    __u32 smem_len;           /* Length of frame buffer mem */
    __u32 type;               /* see FB_TYPE_*		*/
    __u32 type_aux;           /* Interleave for interleaved Planes */
    __u32 visual;             /* see FB_VISUAL_*		*/
    __u16 xpanstep;           /* zero if no hardware panning  */
    __u16 ypanstep;           /* zero if no hardware panning  */
    __u16 ywrapstep;          /* zero if no hardware ywrap    */
    __u32 line_length;        /* length of a line in bytes    */
    unsigned long mmio_start; /* Start of Memory Mapped I/O   */
    /* (physical address) */
    __u32 mmio_len; /* Length of Memory Mapped I/O  */
    __u32 accel;    /* Indicate to driver which	*/
    /*  specific chip/card we have	*/
    __u16 capabilities; /* see FB_CAP_*			*/
    __u16 reserved[2];  /* Reserved for future compatibility */
};

struct timeval
{
    size_t tv_sec;  /* Seconds.  */
    size_t tv_usec; /* Microseconds.  */
};

// linux/input.h
struct input_event
{
    struct timeval time;
    __u16 type;
    __u16 code;
    __s32 value;
};

int blksize;
int micefd, eventfd, fbfd;
long t, tt, delay;
unsigned char mice[3];
unsigned int *fbp, *ret;
struct tms tptr;
struct input_event event;
struct fb_var_screeninfo var_info;
struct fb_fix_screeninfo fix_info;

struct point
{
    int x;
    int y;
};

struct lnode
{
    struct point p;
    struct lnode *next;
};

struct point food;
struct lnode *head = NULL, *tail = NULL;

enum direction
{
    LEFT,
    RIGHT,
    UP,
    DOWN
};

enum direction dir;

void rectangle(int x, int y, int w, int h, /* unsigned */ int color)
{
    /* for (int i = 0; i < h; i++)
    {
        for (int j = 0; j < w; j++)
        {
            fbp[y * var_info.xres + x + j] = 0xffffffff;
        }
        y++;
    } */
    w = x + w >= var_info.xres ? var_info.xres - x : w;
    h = y + h >= var_info.yres ? var_info.yres - y : h;
    int idx = y * var_info.xres + x;
    for (int i = 0; i < h; i++)
    {
        memset(fbp + idx, color, w << 2);
        idx += var_info.xres;
    }
}

void flush()
{
    pwrite(fbfd, fbp, fix_info.smem_len, 0);
}

void push(struct point p)
{
    struct lnode *new = (struct lnode *)malloc(sizeof(struct lnode));
    new->p = p;
    new->next = NULL;
    if (head == NULL)
    {
        head = new;
        tail = new;
    }
    else
    {
        tail->next = new;
        tail = new;
    }
    rectangle(p.x, p.y, blksize, blksize, 0xFF);
}

void pop()
{
    struct lnode *temp = head;
    head = head->next;
    rectangle(temp->p.x, temp->p.y, blksize, blksize, 0);
    free(temp);
}

void place_food()
{
    for (;;)
    {
        food.x = (rand() % (var_info.xres - blksize) / blksize + 1) * blksize;
        food.y = (rand() % (var_info.yres - blksize) / blksize + 1) * blksize;
        struct lnode *temp = head;
        while (temp != NULL)
        {
            if (temp->p.x == food.x && temp->p.y == food.y)
                break;
            temp = temp->next;
        }
        if (temp == NULL)
            break;
    }
    rectangle(food.x, food.y, blksize, blksize, 0xFF);
}

int step()
{
    struct point p;
    p.x = tail->p.x;
    p.y = tail->p.y;
    switch (dir)
    {
    case LEFT:
        p.x -= blksize;
        break;
    case RIGHT:
        p.x += blksize;
        break;
    case UP:
        p.y -= blksize;
        break;
    case DOWN:
        p.y += blksize;
        break;
    }

    if (p.x < 0 || p.x >= var_info.xres || p.y < 0 || p.y >= var_info.yres)
        return 1;

    if (p.x == food.x && p.y == food.y)
        place_food();
    else
        pop();

    for (struct lnode *temp = head; temp != NULL; temp = temp->next)
    {
        if (temp->p.x == p.x && temp->p.y == p.y)
            return 1;
    }
    push(p);

    return 0;
}

int button_up(int s, int *k)
{
    if (s)
    {
        *k = 1;
    }
    else if (*k == 1)
    {
        *k = 0;
        return 1;
    }
    return 0;
}

int game()
{
    int ended = 0, paused = 0, d = 0, l = 0, r = 0, m = 0;
    for (;;)
    {
        if (read(micefd, &mice, sizeof(mice)) > 0)
        {
            if (button_up(mice[0] & 0x1, &l) && delay > 5)
                delay -= 5;
            if (button_up(mice[0] & 0x2, &r) && delay < 40)
                delay += 5;
            if (button_up(mice[0] & 0x4, &m))
                paused = ~paused;
        }

        if (read(eventfd, &event, sizeof(event)) > 0 && event.type == 1 && event.value == 1)
            switch (event.code)
            {
            case KEY_ESC:
                return 1;
            case KEY_R:
                return 0;
            case KEY_W:
            case KEY_A:
            case KEY_D:
            case KEY_S:
                d = event.code;
                break;
            }

        if (paused)
            continue;

        // sleep
        tt = times(&tptr);
        if (tt - t < delay)
            continue;
        t = tt;

        switch (d)
        {
        case KEY_W:
            if (dir == DOWN)
                ended = 1;
            dir = UP;
            break;
        case KEY_A:
            if (dir == RIGHT)
                ended = 1;
            dir = LEFT;
            break;
        case KEY_D:
            if (dir == LEFT)
                ended = 1;
            dir = RIGHT;
            break;
        case KEY_S:
            if (dir == UP)
                ended = 1;
            dir = DOWN;
            break;
        }

        d = 0;

        if (ended)
        {
            memset(fbp, 64, fix_info.smem_len);
            flush();
            continue;
        }

        if (step())
        {
            ended = 1;
            continue;
        };

        flush();

        // sleep(50);
    }
    return 0;
}

int main()
{
    // eventfd = open("/dev/input/event0", O_RDONLY | O_NONBLOCK);
    eventfd = open("/dev/input-event0", O_RDONLY | O_NONBLOCK);
    if (eventfd < 0)
    {
        printf("Error: cannot open input event device.\n");
        return 1;
    }
    printf("The input event device was opened successfully.\n");

    // micefd = open("/dev/input/mice", O_RDONLY | O_NONBLOCK);
    micefd = open("/dev/input-mice", O_RDONLY | O_NONBLOCK);
    if (micefd < 0)
    {
        printf("Error: cannot open mice device.\n");
        return 1;
    }
    printf("The mice device was opened successfully.\n");

    fbfd = open("/dev/fb0", O_RDWR);
    if (fbfd < 0)
    {
        printf("Error: cannot open framebuffer device.\n");
        return 1;
    }
    printf("The framebuffer device was opened successfully.\n");

    if (ioctl(fbfd, FBIOGET_VSCREENINFO, &var_info) < 0)
    {
        printf("Error: cannot read variable information.\n");
        close(fbfd);
        return 1;
    }
    printf("The variable information was read successfully.\n");
    printf("%dx%d, %d bpp\n", var_info.xres, var_info.yres, var_info.bits_per_pixel);

    if (ioctl(fbfd, FBIOGET_FSCREENINFO, &fix_info) < 0)
    {
        printf("Error: cannot read fixed information.\n");
        close(fbfd);
        return 1;
    }
    printf("The fixed information was read successfully.\n");
    printf("Screensize: %d\n", fix_info.smem_len);

    /* unsigned int *fbp = mmap(0, fix_info.smem_len, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0);
	if ((size_t)fbp < 0)
	{
		printf("Error: failed to mmap.\n");
		close(fbfd);
		return 1;
	} */

    blksize = var_info.xres >> 5;
    fbp = malloc(fix_info.smem_len);
    ret = malloc(fix_info.smem_len);
    read(fbfd, ret, fix_info.smem_len);
    for (;;)
    {
        memset(fbp, 0, fix_info.smem_len);
        while (head != NULL)
            pop();
        struct point start = {.x = blksize << 3, .y = blksize << 3};
        push(start);
        place_food();
        t = times(&tptr);
        delay = 18;
        dir = RIGHT;
        if (game())
            break;
    }

    pwrite(fbfd, ret, fix_info.smem_len, 0);

    // munmap(fbp, fix_info.smem_len);
    close(fbfd);
    close(micefd);
    close(eventfd);
    return 0;
}