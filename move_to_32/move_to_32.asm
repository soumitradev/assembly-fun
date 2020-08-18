; Let us now switch to 32 bit protected mode
[org 0x7c00]

; Set stack
mov bp, 0x9000

; Print the 16 bit mode declaration
mov bx, MSG_REAL_MODE
call print_str

; Switch to 32 bit and never return 😢
call switch_to_pm

; Hang
jmp $

; Include all our previous epic code
%include "./print_str.asm"
%include "./gdt.asm"
%include "./print_str_32.asm"
%include "./switch_to_pm.asm"

; Now we are in 32 bit mode, so tell assembler to use 32 bit instructions from now on
[bits 32]

; Now we are in 32 bit protected mode 😎
begin_pm:
; Print a message using our print thing
mov ebx, MSG_PROT_MODE
call print_str_32

; Hang
jmp $

; Define text to print
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully moved to 32-bit Protected Mode", 0

; Padding
times 510-($-$$) db 0 

; Magic number
dw 0xaa55