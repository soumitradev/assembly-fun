; Ok no lookers now. We need to write a program that can write any hex value in a register
[org 0x7c00]

; Use dx as the parameter we pass
mov dx, 0x1C9B
call print_hex

; Loop infinitely after finishing
jmp $

; Lets write a print library
%include "print_hex.asm"

; Define vars (note how we terminate stings with a null). This is the string we'll write into
HEX_OUT:
db '0x0000', 0

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 