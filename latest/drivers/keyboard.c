#include "./keyboard.h"
#include "../cpu/isr.h"
#include "./ports.h"
#include "./screen.h"

static void keyboard_callback(registers_t regs) {
  u8 scancode = port_byte_in(0x60);
  char *sc_ascii;
  int_to_char(scancode, sc_ascii, 10);
  print("Keyboard scancode: ", 0);
  print(sc_ascii, 0);
  print(", ", 0);
  print_letter(scancode);
  print("\n", 0);
}

void init_keyboard() { register_interrupt_handler(IRQ1, keyboard_callback); }

void print_letter(u8 scancode) {
  switch (scancode) {
    case 0x0:
      print("ERROR", 0);
      break;
    case 0x1:
      print("ESC", 0);
      break;
    case 0x2:
      print("1", 0);
      break;
    case 0x3:
      print("2", 0);
      break;
    case 0x4:
      print("3", 0);
      break;
    case 0x5:
      print("4", 0);
      break;
    case 0x6:
      print("5", 0);
      break;
    case 0x7:
      print("6", 0);
      break;
    case 0x8:
      print("7", 0);
      break;
    case 0x9:
      print("8", 0);
      break;
    case 0x0A:
      print("9", 0);
      break;
    case 0x0B:
      print("0", 0);
      break;
    case 0x0C:
      print("-", 0);
      break;
    case 0x0D:
      print("+", 0);
      break;
    case 0x0E:
      print("Backspace", 0);
      break;
    case 0x0F:
      print("Tab", 0);
      break;
    case 0x10:
      print("Q", 0);
      break;
    case 0x11:
      print("W", 0);
      break;
    case 0x12:
      print("E", 0);
      break;
    case 0x13:
      print("R", 0);
      break;
    case 0x14:
      print("T", 0);
      break;
    case 0x15:
      print("Y", 0);
      break;
    case 0x16:
      print("U", 0);
      break;
    case 0x17:
      print("I", 0);
      break;
    case 0x18:
      print("O", 0);
      break;
    case 0x19:
      print("P", 0);
      break;
    case 0x1A:
      print("[", 0);
      break;
    case 0x1B:
      print("]", 0);
      break;
    case 0x1C:
      print("ENTER", 0);
      break;
    case 0x1D:
      print("LCtrl", 0);
      break;
    case 0x1E:
      print("A", 0);
      break;
    case 0x1F:
      print("S", 0);
      break;
    case 0x20:
      print("D", 0);
      break;
    case 0x21:
      print("F", 0);
      break;
    case 0x22:
      print("G", 0);
      break;
    case 0x23:
      print("H", 0);
      break;
    case 0x24:
      print("J", 0);
      break;
    case 0x25:
      print("K", 0);
      break;
    case 0x26:
      print("L", 0);
      break;
    case 0x27:
      print(";", 0);
      break;
    case 0x28:
      print("'", 0);
      break;
    case 0x29:
      print("`", 0);
      break;
    case 0x2A:
      print("LShift", 0);
      break;
    case 0x2B:
      print("\\", 0);
      break;
    case 0x2C:
      print("Z", 0);
      break;
    case 0x2D:
      print("X", 0);
      break;
    case 0x2E:
      print("C", 0);
      break;
    case 0x2F:
      print("V", 0);
      break;
    case 0x30:
      print("B", 0);
      break;
    case 0x31:
      print("N", 0);
      break;
    case 0x32:
      print("M", 0);
      break;
    case 0x33:
      print(",", 0);
      break;
    case 0x34:
      print(".", 0);
      break;
    case 0x35:
      print("/", 0);
      break;
    case 0x36:
      print("Rshift", 0);
      break;
    case 0x37:
      print("Keypad *", 0);
      break;
    case 0x38:
      print("LAlt", 0);
      break;
    case 0x39:
      print("Spc", 0);
      break;
    default:
      if (scancode <= 0x7f) {
        print("Unknown key down", 0);
      } else if (scancode <= 0x39 + 0x80) {
        print("key up ", 0);
        print_letter(scancode - 0x80);
      } else
        print("Unknown key up", 0);
      break;
  }
}
