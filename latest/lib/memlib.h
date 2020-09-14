#ifndef MEMLIB_H
#define MEMLIB_H

#include "../lib/types.h"

void memory_copy(char *source, char *dest, int nbytes);
void memory_set(u32 *dest, u8 val, u32 len);
u32 kmalloc(u32 size, int align, u32 *phys_addr);

#endif