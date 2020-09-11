#include "./utils.h"

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

// K&R implementation of itoa, fails on base > 10.
void int_to_char(int n, char *str, int base) {
  int i, sign;

  if ((sign = n) < 0) n = -n;
  i = 0;
  do {
    str[i++] = n % base + '0';
  } while ((n /= base) > 0);

  if (sign < 0) str[i++] = '-';

  str[i] = '\0';

  rev_str(str);
}

// Write our own idk if this is faster or not str rev.
void rev_str(char *s) {
  int i, j;
  for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
    s[i] ^= s[j];
    s[j] ^= s[i];
    s[i] ^= s[j];
  }
}

// Write our crappy strlen that fails at normal unicode bytes.
int strlen(char *str) {
  char *s;
  for (s = str; *s; s++) {
  }
  return (s - str);
}