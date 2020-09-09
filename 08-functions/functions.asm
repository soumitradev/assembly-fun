; Ok so we've learnt some basic Assembly, let's write a function

; Let's reuse a print piece of code

; mov al, 'H'
; jmp my_print
; return_here:

; my_print:
; mov ah, 0x0e
; int 0x10
; jmp return_here

; Initially, we'd think this would be a good way to use a function.
; However, notice how we have hardcoded the return point. So, if I call
; this function from somewhere else, it won't return to where it was called from.
; However, the important concept here is how we used the lower side of register a
; to store a variable that we used as a parameter. We will reuse this concept.

; So, we need to store the memory address  after the call somewhere,
; and access that memory address and jump there to return.
; The instruction pointer of the CPU keeps track of the memory location being currently executed,
; but it is difficult to access this pointer.

; The CPU actually gives us a way to store the return address and jump to it later
; It pushes the return address to a stack, pops it and jumps to it when it returns.
; Its called `call` and `ret` respectively.

; Now, another problem is that the function may alter the registers and we have no idea if
; the registers we were using store the same values. A function should be as unintrusive as possible
; So, we push all the registers to a stack, pop them off before we return and store them in the
; respective registers. The CPU provides single instructions for this too.
; They're called `pusha` and `popa`

; After all these additions, our function becomes:

; Pass this as parameter to function
mov al, 'H'
; Write data to register b to test the pusha and popa
mov bl, 'A'
; Call print functions
call my_print

; After calling function, print the value in register b to test pusha and popa
mov al, bl
int 0x10

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


; Note how it prints 'H' and then 'A'. So, the pusha and popa worked.

; I know this section is a lot of comments, but this part was very conceptual and we learnt a lot of
; things about how higher level functions work.

; Loop infinitely after finishing
jmp $

; Note how the code runs atleast once, so this is a do-while loop.
; I wanted to write a while loop, but we'll do that in the next section I guess

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 