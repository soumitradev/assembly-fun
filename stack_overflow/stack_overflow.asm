mov ah, 0x0e
; Allow us to print to screen, enable scrolling teletype BIOS routine

; Ok so I just learnt the stack. Let's break it and write a classic stack overflow exploit

; Create base and top of stack at memory location 0x7c31
mov bp, 0x7c22
mov sp, bp
; Note how this is very close to our boot sector and can be easily overflown

; We'll try to print an "X" character as an exploit.
; The assembly code for that will be:
; mov al, 'X'
; int 0x10
; This will compile into the following bytes: B0 58 CD 10
; Let us make it execute this code
; Note that we will also need to end it with a 'EB FE' ('jmp $'' in assmebly) that loops infinitely


; Push some data to stack. Note that the stack is 2 bytes big,
; so the 1 byte big chars are padded with zeroes at the most significant digit end
push 'A'
push 'B'
push 'C'

; Add our code in reverse order. Note how these are actually multi-byte values
; So they need to be written in little-endian format with the bytes reversed.
push 0xfeeb
push 0x10cd
push 0x58b0

; Notice how we never asked it to print 'X' in our code.
; Now this may not look like an exploit, but what if user input was being written to the stack?
; In that case, the user could easily overflow into our boot sector and run possibly malicious code
; This is how a classic stack overflow exploit works
; Note that any subsequent code except for the zero padding and the magic number writing is overwritten
; by our stack and will not be executed. So, the print 'A' will never be executed.
; Small and simple expolit. Probably one of my proudest pieces of code.


mov al, 'A'
int 0x10
; Loop infinitely after finishing
jmp $


; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 