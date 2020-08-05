; Loop forever
loop:
jmp loop

; Pad rest of 512 byte boot sector with zeroes, and leave space for magic number
times 510-($-$$) db 0

; Write magic number
dw 0xaa55 