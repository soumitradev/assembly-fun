#ifndef UTILS_H
#define UTILS_H

#include "../cpu/types.h"

void memory_copy(char *source, char *dest, int nbytes);
void rev_str(char *s);
void int_to_char(int n, char *str, int base);
int strlen(char *str);
void memory_set(u8 *dest, u8 val, u32 len);

#endif