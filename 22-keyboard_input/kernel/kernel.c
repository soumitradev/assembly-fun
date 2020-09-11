#include "../cpu/isr.h"
#include "../cpu/timer.h"
#include "../drivers/keyboard.h"

void kmain() {

  isr_install();

  asm volatile("sti");
  init_timer(50);

  init_keyboard();
}
