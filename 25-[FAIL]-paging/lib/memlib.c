#include "./memlib.h"

// Write our own epic (unoptimised 😳) memcpy
void memory_copy(char *source, char *dest, int nbytes) {
  int i;
  for (i = 0; i < nbytes; i++) {
    *(dest + i) = *(source + i);
  }
}

// Write our own epic (unoptimised 😳) memset
void memory_set(u32 *dest, u8 val, u32 len) {
  u32 *temp = (u32 *)dest;
  for (; len != 0; len--) *temp++ = val;
}

extern u32 end;
u32 free_mem = (u32)&end;

u32 malloc(u32 size, int align, u32 *phys_addr) {
  if (free_mem == 0) free_mem = 0x10002;
  if (align == 1 && (free_mem & 0x00000FFF)) {
    free_mem &= 0xFFFFF000;
    free_mem += 0x1000;
  }
  if (phys_addr) *phys_addr = free_mem;

  u32 ret = free_mem;
  free_mem += size;
  return ret;
}
