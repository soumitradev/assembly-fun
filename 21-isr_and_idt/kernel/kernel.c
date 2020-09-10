#include "../drivers/screen.h"
#include "./utils.h"
#include "../cpu/isr.h"
#include "../cpu/idt.h"

void kmain() {
  isr_install();
  __asm__ __volatile__("int $2");
  __asm__ __volatile__("int $3");
  __asm__ __volatile__("int $31");
}
