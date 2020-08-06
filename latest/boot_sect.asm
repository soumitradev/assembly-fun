; Ok no lookers now. We need to write a program that can write any string variable
[org 0x7c00]

; Use bx as the parameter we pass
mov bx, HELLO
call print

mov bx, GOODBYE
call print

; Loop infinitely after finishing
jmp $

; Lets write a print library
%include "print.asm"

; Define vars (note how we terminate stings with a null)
HELLO:
db 'Hello, World ', 0

GOODBYE:
db 'Goodbye, World', 0

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 