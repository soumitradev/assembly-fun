; This is 32 bit code. We can't run it unless we enter 32 bit protected mode.
[bits 32]

; Set some display constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_str_32:
  ; Push all registers to stack
  pusha
  ; Move dx (now edx in 32 bit mode) to Video memory location
  mov edx, VIDEO_MEMORY

; Create a loop for every char
print_str_32_loop:
  ; Move byte at string location to register a, and change color to white on black
  mov al, [ebx]
  mov ah, WHITE_ON_BLACK

  ; If char is null, jump to end
  cmp al, 0
  je print_str_32_done

  ; Store the character onto video memory location
  mov [edx], ax

  ; Move ahead in memory
  add ebx, 1
  add edx, 2

  jmp print_str_32_loop

  ; return
  print_str_32_done:
    popa
    ret
