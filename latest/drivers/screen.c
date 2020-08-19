#include "./screen.h"
#include "../kernel/low_level.h"

void print_char(char character, int col, int row, char attribute_byte){
    unsigned char* vidmem = (unsigned char*) VIDEO_ADDRESS;

    if (!attribute_byte){
        attribute_byte = WHITE_ON_BLACK;
    }

    int offset;

    if (col >= 0 && row >= 0 && col < 80 && row < 25){
        offset = get_screen_offset(col, row);

        // if (character == '\n'){
        //     offset = get_screen_offset(0, row+1);
        // }
        
        vidmem[offset] = character;
        vidmem[offset + 1] = attribute_byte;
    }
}

int get_screen_offset(int col, int row){
    return (row * MAX_COLS + col) * 2;
}

void print_at(char* str, int col, int row){
    int i = 0;
    while (str[i] != 0){
        print_char(str[i++], col + 1, row, WHITE_ON_BLACK);
    }
}

void print(char* str){
    print_at(str, -1, -1);
}

// void clear_screen(){