; Allow us to print to screen, enable scrolling teletype BIOS routine
mov ah, 0x0e
; Ok so we've learnt some basic Assembly, let's write our own control structures like 
; if, else, else if, while, for, etc.

; Let's write a do-while loop
; Let's use bx to keep track of our iteration variable. Let's write 'A' to the screen 10 times.
mov bx, 0

; Define a checkpoint for us to jump back to while looping
print_code:
; Write 'A' to lower side of register A
mov al, 'A'
; Print it
int 0x10

; Add 1 to our iteration variable
add bx, 1
; If bx is less than 10, repeat
cmp bx, 10
jl print_code

; Else,
; Loop infinitely after finishing
jmp $

; Note how the code runs atleast once, so this is a do-while loop.
; I wanted to write a while loop, but we'll do that in the next section I guess

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 