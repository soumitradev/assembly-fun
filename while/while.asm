; Allow us to print to screen, enable scrolling teletype BIOS routine
mov ah, 0x0e
; Ok so we've learnt some basic Assembly, let's write our own control structures like 
; if, else, else if, while, for, etc.

; Let's write a while loop
; Let's use bx to keep track of our iteration variable. Let's write 'A' to the screen 10 times.
mov bx, 0

; Create a checkpoint for us to jump bac to for our while loop
while:
; Compare the value in register bx and 10
cmp bx, 10
; If its outside bounds, break from the loop
jge the_end
; Else, increment, write 'A' to lower side of register a and print
add bx, 1
mov al, 'A'
int 0x10
; After that, jump back to while loop
jmp while

; After breaking,
the_end:
; Loop infinitely after finishing
jmp $

; Note how the code runs atleast once, so this is a do-while loop.
; I wanted to write a while loop, but we'll do that in the next section I guess

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 