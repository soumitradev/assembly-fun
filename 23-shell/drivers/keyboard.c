#include "./keyboard.h"

#include "../cpu/isr.h"
#include "../cpu/ports.h"
#include "../lib/strlib.h"
#include "./screen.h"

static char key_buffer[256];

// Use arrays to make life easier
const char *sc_name[] = {
    "ERROR",     "Esc",     "1", "2", "3", "4",      "5",
    "6",         "7",       "8", "9", "0", "-",      "=",
    "Backspace", "Tab",     "Q", "W", "E", "R",      "T",
    "Y",         "U",       "I", "O", "P", "[",      "]",
    "Enter",     "Lctrl",   "A", "S", "D", "F",      "G",
    "H",         "J",       "K", "L", ";", "'",      "`",
    "LShift",    "\\",      "Z", "X", "C", "V",      "B",
    "N",         "M",       ",", ".", "/", "RShift", "Keypad *",
    "LAlt",      "Spacebar"};
const char sc_ascii[] = {
    '?', '?', '1', '2', '3', '4', '5', '6', '7', '8', '9',  '0', '-', '=',  '?',
    '?', 'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P',  '[', ']', '?',  '?',
    'A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', ';', '\'', '`', '?', '\\', 'Z',
    'X', 'C', 'V', 'B', 'N', 'M', ',', '.', '/', '?', '?',  '?', ' '};

// Get key stroke and handle
static void keyboard_callback(registers_t regs) {
  // Read input from driver
  u8 scancode = port_byte_in(KEYBOARD_PORT);
  if (scancode > SC_MAX) return;
  // Handle backspace
  if (scancode == BACKSPACE) {
    // Keep prompt from getting removed
    if (get_offset_col(get_cursor_offset()) < 2) return;
    
    backspace(key_buffer);
    backspace_handler();
  } else if (scancode == ENTER) {
    // Handle enter: i.e. send command to kernel and handle next line
    print("\n", 0);
    user_input(key_buffer);
    key_buffer[0] = '\0';
  } else {
    // Just add char to key_buffer
    char letter = sc_ascii[(int)scancode];
    char str[2] = {letter, '\0'};
    append(key_buffer, letter);
    print(str, 0);
  }
}

// Map handler function to keyboard interrupts
void init_keyboard() { register_interrupt_handler(IRQ1, keyboard_callback); }
