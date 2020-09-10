#include "../drivers/ports.h"
#include "../drivers/screen.h"
#include "./utils.h"

void kmain() {
  // Testing the functions we wrote
  clr_scr();
  int ok = print_char('X', 1, 1, WHITE_ON_BLACK);
  print_at(
      "Oh noooo here comes a giant line of text will it overflow or wrap?????",
      75, 10, 0);
  print_at("What if\nI\nwant\nmany\nlines?", 0, 15, 0);
  print("There is a line\nbreak", 0);
  print_at("BRUH WE'RE SO CLOSE TO THE EDGE OH NOOOOOOO", 40, 24, 0);

  // My epic flood functions 😎
  // clr_scr();
  // panic();
  // flood('A', 0x4F);
}
