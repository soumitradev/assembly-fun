#include "./memlib.h"

// Write our own epic (unoptimised 😳) memcpy
void memory_copy(char *source, char *dest, int nbytes) {
  int i;
  for (i = 0; i < nbytes; i++) {
    *(dest + i) = *(source + i);
  }
}

// Write our own epic (unoptimised 😳) memset
void memory_set(u8 *dest, u8 val, u32 len) {
  u8 *temp = (u8 *)dest;
  for (; len != 0; len--) *temp++ = val;
}
