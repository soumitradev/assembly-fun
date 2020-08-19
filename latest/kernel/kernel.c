#include "../drivers/screen.h"
#include <stdint.h>
#include "./kernel.h"

void bootMain(){
    // Just be happy with writing X at the top left corner lel
    // print_at("ok", 10, 10);
    print_char('X', 0, 0, WHITE_ON_BLACK);
}