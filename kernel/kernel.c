#include "../drivers/screen.h"

void main() {
    clear_screen();

    // tprint_char('X', getPos(0, 0), 0x28);
    // tprint_char('Y', getPos(0, 1), 0x28);

    // tprint_at("Hello World!", 13, 0, 0, 0x28);

    tprint_char('X');
    tprint_char('\n');
    tprint_char('Y');
}