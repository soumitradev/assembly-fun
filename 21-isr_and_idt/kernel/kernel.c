#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "./utils.h"

void kmain() {
  // Install the isr, and run some interrupts so we can test our interrupt handling
  isr_install();
  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");
  __asm__ __volatile__("int $31");
}
