#ifndef UTILS_H
#define UTILS_H

// Our owm smol crappy libc
void memory_copy(char *source, char *dest, int nbytes);
void rev_str(char *s);
void int_to_char(int n, char *str, int base);
int strlen(char *str);

#endif