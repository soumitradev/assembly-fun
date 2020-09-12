#ifndef STRLIB_H
#define STRLIB_H


void rev_str(char *s);
void int_to_char(int n, char *str, int base);
int strlen(char *str);
void append(char *str, char new);
void backspace(char *str);
int strcmp(char *s1, char *s2);
void hex_to_char(int n, char str[]);

#endif