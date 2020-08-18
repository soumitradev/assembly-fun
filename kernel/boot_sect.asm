; Let us now switch to 32 bit protected mode
[org 0x7c00]

; Place where we load kernel from
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

; Set stack
mov bp, 0x9000
mov sp, bp

; Print the 16 bit mode declaration
mov bx, MSG_REAL_MODE
call print_str

; Load kernel
call load_kernel

; Switch to 32 bit and never return 😢
call switch_to_pm

; Hang
jmp $

; Include all our previous epic code
%include "./print_str.asm"
%include "./disk_load.asm"
%include "./gdt.asm"
%include "./print_str_32.asm"
%include "./switch_to_pm.asm"

[bits 16]

; Load the kernel into memory
load_kernel:
    ; Print message saying you're loading kernel
    mov bx, MSG_LOAD_KERNEL
    call print_str

    ; Load 15 sectors (why not)
    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret

; Now we are in 32 bit mode, so tell assembler to use 32 bit instructions from now on
[bits 32]

; Now we are in 32 bit protected mode 😎
begin_pm:
; Print a message using our print thing
mov ebx, MSG_PROT_MODE
call print_str_32

; Run the kernel 😎
call KERNEL_OFFSET

; Hang
jmp $

; Define text to print
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Successfully moved to 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel...", 0

; Padding
times 510-($-$$) db 0 

; Magic number
dw 0xaa55