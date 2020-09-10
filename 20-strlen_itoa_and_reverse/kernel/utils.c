// Write our own epic (unoptimised 😳) memcpy
void memory_copy(char *source, char *dest, int nbytes) {
  int i;
  for (i = 0; i < nbytes; i++) {
    *(dest + i) = *(source + i);
  }
}

void int_to_char(int n, char str[], int base) {
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

void rev_str(char *s) {
  int i, j;
  for (i = 0, j = strlen(s) - 1; i < j; i++, j--) {
    s[i] ^= s[j];
    s[j] ^= s[i];
    s[i] ^= s[j];
  }
}

int strlen(char *str) {
  char *s;
  for (s = str; *s; s++) {
  }
  return (s - str);
}