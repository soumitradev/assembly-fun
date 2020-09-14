#include "./paging.h"

#include "../drivers/screen.h"
#include "../cpu/isr.h"
#include "../lib/memlib.h"
#include "../lib/strlib.h"

page_directory_t *kernel_directory = 0;

page_directory_t *current_directory = 0;

u32 *frames;
u32 nframes;

extern u32 free_mem;

#define INDEX_FROM_BIT(a) (a / (8 * 4))
#define OFFSET_FROM_BIT(a) (a % (8 * 4))

static void set_frame(u32 frame_addr) {
  u32 frame = frame_addr / 0x1000;
  u32 idx = INDEX_FROM_BIT(frame);
  u32 off = OFFSET_FROM_BIT(frame);
  frames[idx] |= (0x1 << off);
}

static void clear_frame(u32 frame_addr) {
  u32 frame = frame_addr / 0x1000;
  u32 idx = INDEX_FROM_BIT(frame);
  u32 off = OFFSET_FROM_BIT(frame);
  frames[idx] &= ~(0x1 << off);
}

static u32 test_frame(u32 frame_addr) {
  u32 frame = frame_addr / 0x1000;
  u32 idx = INDEX_FROM_BIT(frame);
  u32 off = OFFSET_FROM_BIT(frame);
  return (frames[idx] & (0x1 << off));
}

static u32 first_frame() {
  u32 i, j;
  for (i = 0; i < INDEX_FROM_BIT(nframes); i++) {
    if (frames[i] != 0xFFFFFFFF) {
      for (j = 0; j < 32; j++) {
        u32 to_test = 0x1 << j;
        if (!(frames[i] & to_test)) {
          return i * 4 * 8 + j;
        }
      }
    }
  }
}

void allocate_frame(page_t *page, int is_kernel, int is_write) {
  if (page->frame != 0) {
    return;
  } else {
    u32 idx = first_frame();
    if (idx == (u32)-1) {
      panic_message("No free frames.");
    }
    set_frame(idx * 0x1000);
    page->present = 1;
    page->rw = (is_write) ? 1 : 0;
    page->user = (is_kernel) ? 0 : 1;
    page->frame = idx;
  }
}

void free_frame(page_t *page) {
  u32 frame;
  if (!(frame = page->frame)) {
    return;
  } else {
    clear_frame(frame);
    page->frame = 0x0;
  }
}

void init_paging() {
  u32 mem_end_page = 0x1000000;
  nframes = mem_end_page / 0x1000;
  frames = (u32 *)malloc(INDEX_FROM_BIT(nframes), 0, 0);
  memory_set(frames, 0, INDEX_FROM_BIT(nframes));

  kernel_directory =
      (page_directory_t *)(malloc(sizeof(page_directory_t), 1, 0));
  current_directory = kernel_directory;

  int i = 0;
  while (i < free_mem) {
    allocate_frame(get_page(i, 1, kernel_directory), 0, 0);
    i += 0x1000;
  }

  register_interrupt_handler(14, page_fault_handler);

  switch_page_directory(kernel_directory);
}

void switch_page_directory(page_directory_t *new_dir) {
  current_directory = new_dir;
  asm volatile("mov %0, %%cr3" ::"r"(&new_dir->tables_phys));
  // asm volatile("movl %%cr0, %%eax; btsl $31, %%eax; movl %%eax, %%cr0" : : : "eax");
  asm volatile("pushl %%eax; movl %%cr0, %%eax; btsl $31, %%eax; movl %%eax, %%cr0; popl %%eax":);
  print("ook", 0);

  // u32 cr0;
  // asm volatile("mov %%cr0, %0" : "=r"(cr0));
  // cr0 |= 0x80000000;
  // asm volatile("mov %0, %%cr0" ::"r"(cr0));
}

page_t *get_page(u32 addr, int make, page_directory_t *dir) {
  addr /= 0x1000;
  u32 table_idx = addr / 1024;
  if (dir->tables[table_idx]) {
    return &dir->tables[table_idx]->pages[addr % 1024];
  } else if (make) {
    u32 tmp;
    dir->tables[table_idx] =
        (page_table_t *)malloc(sizeof(page_table_t), 1, &tmp);
    dir->tables_phys[table_idx] = tmp | 0x7;
    return &dir->tables[table_idx]->pages[addr % 1024];
  } else {
    return 0;
  }
}

void page_fault_handler(registers_t regs) {
  u32 faulting_address;
  asm volatile("mov %%cr2, %0" : "=r"(faulting_address));

  int present = !(regs.err_code & 0x1);
  int rw = regs.err_code & 0x2;
  int user = regs.err_code & 0x4;
  int reserved = regs.err_code & 0x8;
  int id = regs.err_code & 0x10;

  // panic_message("Page Fault:")
  char mem_loc[10] = "";
  hex_to_char(faulting_address, mem_loc);
  char *panic_str = "Page fault at ";

  concat(panic_str, mem_loc);

  char fault_details[256] = "";

  if (present) {
    concat(fault_details, "\n- Present");
  }
  if (rw) {
    concat(fault_details, "\n- Read-Only");
  }
  if (user) {
    concat(fault_details, "\n- User-Mode");
  }
  if (reserved) {
    concat(fault_details, "\n- Reserved");
  }
  concat(panic_str, fault_details);
  panic_message(panic_str);
}