; Allow us to print to screen. Scrolling Teletype BIOS routine
mov ah, 0x0e

; Move the character into lower side of register a, and call the BIOS interrupt for printing that character
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ','
int 0x10
mov al, ' '
int 0x10
mov al, 'w'
int 0x10
mov al, 'o'
int 0x10
mov al, 'r'
int 0x10
mov al, 'l'
int 0x10
mov al, 'd'
int 0x10

; After printing, loop forever so that it doesn't quit
jmp $

; Pad the rest of the 512 byte boot sector with zeroes while leaving 2 bytes for the magic number
times 510-($-$$) db 0

; Write the magic number at the end of 512 bytes
dw 0xaa55 