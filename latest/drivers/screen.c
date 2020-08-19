#include "./screen.h"
#include "../kernel/low_level.h"

void print_char(char character, int col, int row, char attribute_byte){
    unsigned char* vidmem = (unsigned char*) VIDEO_ADDRESS;

    if (!attribute_byte){
        attribute_byte = WHITE_ON_BLACK;
    }

    int offset; 

    if (col >= 0 && row >= 0){
        offset = get_screen_offset(col, row);
    } else {
        offset = get_cursor();
    }

    if (character == '\n'){
        int rows = offset / (2*MAX_COLS);
        offset = get_screen_offset(79, rows);
    } else {
        vidmem[offset] = character;
        vidmem[offset + 1] = attribute_byte;
    }
}

int get_screen_offset(int col, int row){
    return (row * MAX_ROWS + col) * 2;
}

int get_cursor(){
    port_byte_out(REG_SCREEN_CTRL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL, 15);
    offset += port_byte_in(REG_SCREEN_DATA);
    return offset*2;
}

void set_cursor(int offset){
    offset /= 2;
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char) (offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
}