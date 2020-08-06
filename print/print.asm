print:
  ; Push all registers
  pusha
  ; Define a while loop that runs while current character is not null.
  while:
    ; Copy the character into lower end of register c
    mov al, [bx]
    ; Check if char is null. If yes, end loop
    cmp al, 0
    je end
    ; Set register a to print mode, and print
    mov ah, 0x0e
    int 0x10
    ; Move the char read pointer to next location in memory and hit next while loop
    add bx, 1
    jmp while
  end:
  ; Restore all registers and return
  popa
  ret