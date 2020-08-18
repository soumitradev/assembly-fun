; Turns out there are more registers! We use these to have access to more memory.
; Let's use some of them

; Enable printing
mov ah, 0x0e

; Try to read directly from memory location
mov al, [the_secret]
int 0x10
; This fails because we are not reading from the 0x7c0 offset. We are reading from
; a memory location that's not in our boot sector

; Write the offset to sour general purpose data segment register, and then try to read at the location
mov bx, 0x7c0
mov ds, bx
mov al, [the_secret]
int 0x10
; This works since we offseted our read this time around

; Try to read after offset. However, we never set the register es to the offset, and it defaults to 0
mov al, [es:the_secret]
int 0x10
; Since it starts from 0, we effectively have no offset

; This time, actually offset and read. This will work
mov bx, 0x7c0
mov es, bx
mov al, [es:the_secret]
int 0x10

; Loop infinitely after finishing
jmp $

; Write our byte to memory
the_secret:
db "X"

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 