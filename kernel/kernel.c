#include "../drivers/screen.h"

void main() {
    clear_screen();

    // tprint_char('X');
    // tprint_char('\n');
    // tprint_char('Y');

    char s[] = "Test String";
    tprint(s);
}