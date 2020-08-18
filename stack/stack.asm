mov ah, 0x0e
; Allow us to print to screen, enable scrolling teletype BIOS routine

; Ok so I just learnt the stack. Let's push, pop and print from stack

; Create base and top of stack at memory location 0x8000
mov bp, 0x8000
mov sp, bp
; Note how this is considerably far from our boot sector load point (0x7c00)
; so that it won't overwrite our boot sector

; Push some data to stack. Note that the stack is 2 bytes big,
; so the 1 byte big chars are padded with zeroes at the most significant digit end
push 'A'
push 'B'
push 'C'

; Pop a value into the register b, and copy the lower end (the actual text byte)
; to al and print it using the interrupt
pop bx
mov al, bl
int 0x10

; Print another byte from stack
pop bx
mov al, bl
int 0x10

; Lets try and prove that the stack grows down in memory value from base.
; Lets print the last thing on our stack. This is 2bytes below base. So, 0x8000 - 2 bytes = 0x7ffe
mov al, [0x7ffe]
int 0x10

; Loop infinitely after finishing
jmp $

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 