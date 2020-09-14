#include "./kernel.h"

#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../lib/memlib.h"
#include "../lib/strlib.h"
#include "../mm/paging.h"

void kmain() {
  // Initialise interrupts
  isr_install();
  irq_install();

  // Something wrong here...
  init_paging();

  // Clear screen and show prompt
  clr_scr();
  print("BruhOS\n", 0x02);
  print("| Release: v0.0.1\n", 0);
  print("| Release Date: 12th September 2020\n", 0);
  print("| Architecture: i386\n", 0);
  print("| Resolution: 80x25\n\n", 0);
  print(">", 0);
}

// Handle commands
void user_input(char *input) {
  if (strcmp(input, "kill") == 0) {
    print("I'm ded.\n", 0);
    asm volatile("hlt");
  } else if (strcmp(input, "bruh") == 0) {
    print("Bruh momento\n", 0);
    print(">", 0);
    return;
  } else if (strcmp(input, "clr") == 0 || strcmp(input, "clear") == 0 ||
             strcmp(input, "cls") == 0) {
    clr_scr();
    print(">", 0);
    return;
  } else if (strcmp(input, "die") == 0) {
    volatile u32 *ptr = (volatile u32 *)0xA0000000;
    *ptr = 'a';
    print(">", 0);
    return;
  } else if (strcmp(input, "page") == 0) {
    u32 phys_addr;
    u32 page = malloc(1000, 1, &phys_addr);
    char page_str[16] = "";
    hex_to_char(page, page_str);
    char phys_str[16] = "";
    hex_to_char(phys_addr, phys_str);
    print("Page: ", 0);
    print(page_str, 0);
    print(", physical address: ", 0);
    print(phys_str, 0);
    print("\n>", 0);
    return;
  }

  // Command not found
  print("Command ", 0);
  print(input, 0);
  print(" not found ", 0);
  print("\n>", 0);
}
