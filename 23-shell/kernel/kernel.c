#include "./kernel.h"

#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../lib/strlib.h"

void kmain() {
  // Initialise interrupts
  isr_install();
  irq_install();

  // Clear screen and show prompt
  clr_scr();
  print("MyOS\n", 0x02);
  print("| Release: v0.0.1\n", 0);
  print("| Release Date: 12th September 2020\n", 0);
  print("| Architecture: i386\n", 0);
  print("| Resolution: 80x25\n", 0);
  print(">", 0);
}

// Handle commands
void user_input(char *input) {
  if (strcmp(input, "KILL") == 0) {
    print("I'm ded.\n", 0);
    asm volatile("hlt");
  }
  // Command not found
  print("COMMAND ", 0);
  print(input, 0);
  print(" NOT FOUND! ", 0);
  print("\n>", 0);
}