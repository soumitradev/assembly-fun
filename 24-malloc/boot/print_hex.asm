print_hex:
  ; Push all registers to stack
  pusha

  ; Use cx as our counter
  mov cx, 4
  ;  Define a loop for every char we write
  char_loop:
    ;  Decrement cx
    dec cx

    ; Make a copy of our hex into ax, and shift dx 4 bits right so we keep only the first 4 bits of each byte in dx
    mov ax, dx
    shr dx, 4
    ; AND each byte with 0xf to keep only the last 4 bits of each byte in ax
    and ax, 0xf
    ; We have now success fully split the 2 bytes in dx into 4 parts of 4 bits each

    ; Use our bx as a pointer to the place where we write the string into memory, and move it 2 bytes ahead to skip the '0x' at the start 
    mov bx, HEX_OUT
    add bx, 2
    ; Move bx to appropriate location in memory for byte in string
    add bx, cx

    ; If the byte is lesser than 0xa, its a number. So, we add a different number to it to get ASCII value
    cmp ax,0xa
    ; Note that set_letter is NOT for letters exclusively. It is to finalise the byte into a letter
    jl set_letter
    ; If its a letter, add a little more to get correct ASCII value for byte
    add al, 0x7
    jmp set_letter

  set_letter:
    ; Add some value to get exact ASCII value
    add al, 0x30
    ; Write byte to string location pointer
    mov [bx], al

    ; If we're done writing the bytes, quit. Else, repeat for each byte
    cmp cx,0
    je print_hex_done
    jmp char_loop

  print_hex_done:
    ; Use our print function to print the string in memory
    mov bx, HEX_OUT
    call print_str

    ; Pop the resgisters and return
    popa
    ret

HEX_OUT:
db '0x0000', 0

; Don't forget to include your print function~
%include "print_str.asm"