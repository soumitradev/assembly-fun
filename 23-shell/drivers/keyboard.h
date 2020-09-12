#ifndef KEYBOARD_H
#define KEYBOARD_H

#include "../cpu/types.h"

// Keyboard constants
#define BACKSPACE 0x0E
#define ENTER 0x1C
#define SC_MAX 57
#define KEYBOARD_PORT 0x60

// Keyboard functions
void init_keyboard();

#endif
