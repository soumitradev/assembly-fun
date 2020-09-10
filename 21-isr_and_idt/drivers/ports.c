#include "./ports.h"

u8 port_byte_in(unsigned short port) {
  // Read in a byte from port port and return it. We use inline ASM for this.
  // Syntax is different from NASM because gcc uses a different assembler
  u8 result;
  __asm__("in %%dx, %%al" : "=a"(result) : "d"(port));
  return result;
}

void port_byte_out(unsigned short port, unsigned char data) {
  // Write a byte to port port.
  __asm__("out %%al, %%dx" : : "a"(data), "d"(port));
}

u16 port_word_in(unsigned short port) {
  // Read in a word (2 bytes) from port port and return it
  u16 result;
  __asm__("in %%dx, %%ax" : "=a"(result) : "d"(port));
}

void port_word_out(unsigned short port, unsigned short data) {
  // Write a word out to port port
  __asm__("out %%ax, %%dx" : : "a"(data), "d"(port));
}
