#ifndef PAGING_H
#define PAGING_H

#include "../cpu/isr.h"
#include "../lib/types.h"

typedef struct page {
  u32 present;
  u32 rw;
  u32 user;
  u32 accessed;
  u32 dirty;
  u32 unused;
  u32 frame;
} page_t;

typedef struct page_table {
  page_t pages[1024];
} page_table_t;

typedef struct page_directory {
  page_table_t *tables[1024];
  u32 tables_phys[1024];
  u32 phys_addr;
} page_directory_t;

void init_paging();

void switch_page_directory(page_directory_t *new_dir);

page_t *get_page(u32 addr, int make, page_directory_t *dir);

void page_fault_handler(registers_t regs);

#endif