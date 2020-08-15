; We can now load stuff from disk! Let's try it out
[org 0x7c00]

; The dl register holds the boot drive during boot. This is done by BIOS
mov [BOOT_DRIVE], dl

; Move stack to 0x8000
mov bp, 0x8000
mov sp, bp

; Load 5 sectors (0x0000 (es)  to 0x9000(bx)) from boot disk
mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

; Print the first loaded word, which we wrote as 0xdada
mov dx, [0x9000]
call print_hex

; Print the word from 2nd sector we loaded we expect this to be 0xface
mov dx, [0x9000 + 512]
call print_hex

jmp $

; Load all our epic code we wrote before
%include "./print_str.asm"
%include "./print_hex.asm"
%include "./disk_load.asm"

; Keep variable for boot drive
BOOT_DRIVE:
db 0

HEX_OUT:
db "0x0000"

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55

; Write stuff to disk (we read this while running)
times 256 dw 0xdada
times 256 dw 0xface