; Hmm how do we include files?
[org 0x7c00]

; Boom
%include "functions.asm"

call my_print

; Loop infinitely after finishing
jmp $

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 