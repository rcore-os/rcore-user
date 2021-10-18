#include <stdio.h>

#define COLOR_TEXT(text, color) "\x1b[" #color "m" text "\x1b[0m"

int main() {
    printf(
        "%s%s%s%s%s%s %s%s%s%s %s%s%s%s%s\n",
        COLOR_TEXT("H", 31),
        COLOR_TEXT("e", 32),
        COLOR_TEXT("l", 33),
        COLOR_TEXT("l", 34),
        COLOR_TEXT("o", 35),
        COLOR_TEXT(",", 36),

        COLOR_TEXT("R", 37),
        COLOR_TEXT("u", 90),
        COLOR_TEXT("s", 91),
        COLOR_TEXT("t", 92),

        COLOR_TEXT("O", 93),
        COLOR_TEXT("S", 94),
        COLOR_TEXT("e", 95),
        COLOR_TEXT("s", 96),
        COLOR_TEXT("!", 97)
    );

    printf("\x1b[0m");

#define TEXT "regular \x1b[4munderline\x1b[24m \x1b[7mreverse\x1b[27m \x1b[9mstrikethrough\x1b[29m"

    printf("\x1b[47m%s\x1b[0m\n", COLOR_TEXT(TEXT, 30));
    for (int i = 31; i < 38; i++) {
        printf("\x1b[%dm%s\x1b[0m\n", i, TEXT);
    }
    for (int i = 90; i < 98; i++) {
        printf("\x1b[%dm%s\x1b[0m\n", i, TEXT);
    }
}
