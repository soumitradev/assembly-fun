#include "./timer.h"

#include "../drivers/screen.h"
#include "../kernel/utils.h"
#include "./isr.h"

u32 tick = 0;

static void timer_callback(registers_t regs) {
  tick++;
  // print("Tick: ", 0);
  // char tick_char[256];
  // int_to_char(tick, tick_char, 10);
  // print(tick_char, 0);
  // print("\n", 0);
}

void init_timer(u32 freq) {
  register_interrupt_handler(IRQ0, timer_callback);

  u32 divisor = 1193180 / freq;
  u8 low = (u8)(divisor & 0xFF);
  u8 high = (u8)((divisor >> 8) & 0xFF);

  port_byte_out(0x43, 0x36);
  port_byte_out(0x40, low);
  port_byte_out(0x40, high);
}
