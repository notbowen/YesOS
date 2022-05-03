#include "../drivers/screen.h"

void main() {
    clear_screen();

    // tprint_char('X');
    // tprint_char('\n');
    // tprint_char('Y');

    char str[] = "12345\n";
    for (int i = 0; i < 24; i++) {
        tprint(str);
    }
}