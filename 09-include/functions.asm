; Ok so we've learnt some basic Assembly, let's write a function

mov al, 'H'
; Write data to register b to test the pusha and popa
mov bl, 'A'

; Define function
my_print:
    ; Push all registers to stack
    pusha
    ; Write to register b. If this prints 'X', the function overwrote it and the pusha and popa didnt work
    mov bl, 'X'
    ; Print data in register a
    mov ah, 0x0e
    int 0x10
    ; Pop all registers and put them back in registers
    popa
    ; Return to caller
    ret
