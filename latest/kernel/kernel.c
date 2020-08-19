#include "../drivers/screen.h"
#include "./kernel.h"

void main(){
    // Just be happy with writing X at the top left corner lel
    print_at("X", 0, 0);
}

void print_at(char* str, int col, int row){
    if (col >= 0 && row >= 0){
        set_cursor(get_screen_offset(col, row));
    }

    int i = 0;
    while (str[i] != 0){
        print_char(str[i++], col, row, WHITE_ON_BLACK);
    }
}

void print(char* str){
    print_at(str, -1, -1);
}