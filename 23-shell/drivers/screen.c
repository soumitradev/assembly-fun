#include "./screen.h"

#include "../cpu/ports.h"

// Print functions

int print_char(char chr, int col, int row, char attr) {
  unsigned char *vid_mem = (unsigned char *)VIDEO_ADDR;

  // Default color
  if (!attr) attr = WHITE_ON_BLACK;

  // If text overflows, show a red 'E' in right bottom corner
  if (col >= MAX_COLS || row >= MAX_ROWS) {
    vid_mem[2 * MAX_COLS * MAX_ROWS - 2] = 'E';
    vid_mem[2 * MAX_COLS * MAX_ROWS - 1] = RED_ON_WHITE;
    return get_offset(col, row);
  }

  int offset;

  // Default to cursor id row or col is less than 0
  if (col >= 0 && row >= 0) {
    offset = get_offset(col, row);
  } else {
    offset = get_cursor_offset();
  }

  // If character is newline, go to next line
  if (chr == '\n') {
    row = get_offset_row(offset);
    offset = get_offset(0, row + 1);
  } else {
    vid_mem[offset] = chr;
    vid_mem[offset + 1] = attr;
    offset += 2;
  }

  // If offset is out of bounds,
  if (offset >= MAX_ROWS * MAX_COLS * 2) {
    // Copy rows to previous row
    int i;
    for (i = 1; i < MAX_ROWS; i++)
      memory_copy(get_offset(0, i) + VIDEO_ADDR,
                  get_offset(0, i - 1) + VIDEO_ADDR, MAX_COLS * 2);

    // Make last line blank
    char *last_line = get_offset(0, MAX_ROWS - 1) + VIDEO_ADDR;
    for (i = 0; i < MAX_COLS * 2; i++) last_line[i] = 0;

    // Move cursor to last line instead of the line outside display
    offset -= 2 * MAX_COLS;
  }
  // Move cursor to next char, and return offset of next char
  set_cursor_offset(offset);
  return offset;
}

void print_at(char *str, int col, int row, char attr) {
  int offset;

  // Print at cursor if row or col < 0
  if (col >= 0 && row >= 0) {
    offset = get_offset(col, row);
  } else {
    offset = get_cursor_offset();
    row = get_offset_row(offset);
    col = get_offset_col(offset);
  }

  // Use print_char to print string
  int i = 0;
  while (str[i]) {
    offset = print_char(str[i++], col, row, attr);
    row = get_offset_row(offset);
    col = get_offset_col(offset);
  }
}

void print(char *str, char attr) {
  // Printing by default becomes so much easier
  print_at(str, -1, -1, attr);
}

void backspace_handler() {
  print_char(' ', get_offset_col(get_cursor_offset()) - 1, get_offset_row(get_cursor_offset()), 0);
  set_cursor_offset(get_cursor_offset() - 2);
}


// Mass screen functions

void panic() {
  // Kernel panic 😏
  flood('A', WHITE_ON_RED);
}

void flood(char chr, char attr) {
  // Flood screen with char and attr
  char *vid = VIDEO_ADDR;
  int i, j;
  for (i = 0; i < MAX_ROWS; i++) {
    for (j = 0; j < MAX_COLS; j++) {
      vid[(i * MAX_COLS + j) * 2] = chr;
      vid[(i * MAX_COLS + j) * 2 + 1] = attr;
    }
  }
  set_cursor(MAX_COLS - 1, MAX_ROWS - 1);
}

void clr_scr() {
  // Clear screen
  flood(' ', WHITE_ON_BLACK);
  set_cursor(0, 0);
}

// Cursor functions

void set_cursor(int col, int row) {
  // Move cursor to col, row
  set_cursor_offset(get_offset(col, row));
}

void set_cursor_offset(int offset) {
  // Move cursor to offset
  offset /= 2;
  port_byte_out(REG_SCR_CTRL, 14);
  port_byte_out(REG_SCR_DAT, (unsigned char)(offset >> 8));
  port_byte_out(REG_SCR_CTRL, 15);
  port_byte_out(REG_SCR_DAT, (unsigned char)(offset & 0xff));
}

int get_cursor_offset() {
  // Get cursor offset
  int offset;

  // Get cursor loc from driver
  port_byte_out(REG_SCR_CTRL, 14);
  offset = port_byte_in(REG_SCR_DAT) << 8;
  port_byte_out(REG_SCR_CTRL, 15);
  offset += port_byte_in(REG_SCR_DAT);

  return offset * 2;
}

int get_offset(int col, int row) {
  // Get offset of any row and col
  return 2 * (row * MAX_COLS + col);
}

int get_offset_row(int offset) {
  // Get row from offset
  return offset / (2 * MAX_COLS);
}

int get_offset_col(int offset) {
  // Get col from offset
  return (offset - (get_offset_row(offset) * 2 * MAX_COLS)) / 2;
}