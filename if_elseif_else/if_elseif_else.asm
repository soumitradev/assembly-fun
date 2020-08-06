; Allow us to print to screen, enable scrolling teletype BIOS routine

; Ok so we've learnt some basic Assembly, let's write our own control structures like 
; if, else, else if, while, for, etc.

; Let's write an if, else, elseif block. These can be confusing sometimes.

; Lets say we want to print 'A' if value in register b is 1, 'B' if 2, and 'C' otherwise
mov bx, 1

; Compare value in register b and 1, if equal, then jump to case 1
cmp bx, 1
je case1

; Else, if value in register b is 2, jump to case 2
cmp bx, 2
je case2

; Else, write 'C' to lower side of register a, and jump to end.
; This is so that the cases 1 and 2 are not executed, and we jump over them.
mov al, 'C'
jmp the_end

; If value in register b was 1, write 'A' to lower side of register a
; and jump to end to avoid running code for case 2
case1:
mov al, 'A'
jmp the_end

; If value in register was 2, write 'B' to lower side of register a
case2:
mov al, 'B'


; At the end, print the contents of lower side of register a
the_end:
mov ah, 0x0e
int 0x10


; Loop infinitely after finishing
jmp $


; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 