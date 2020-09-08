disk_load:
  pusha
  ; Push dx to stack so we can store how many sectors were requested to be read
  push dx

  ; Put device into READ mode (BIOS Thing)
  mov ah, 0x02
  ; Read dh sectors
  mov al, dh
  ; Select cylinder 0
  mov ch, 0x00
  ; Select head 0
  mov dh, 0x00
  ; Start reading at second sector (i.e. after boot sector)
  mov cl, 0x02

  ; Start reading
  int 0x13
  ; Jump if error
  jc disk_error

  ; Restore dx
  pop dx
  ; If all sectors are read, do nothing. Else, error out
  cmp dh, al
  jne disk_error
  popa
  ret

; Print disk error message on error
disk_error:
  mov bx, DISK_ERROR_MSG
  call print_str
  call print_nl
  mov dh, ah
  call print_hex
  ; Loop infinitely after finishing
  jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR_MSG
    call print_str

disk_loop:
    jmp $

DISK_ERROR_MSG: db "Disk read error", 0
SECTORS_ERROR_MSG: db "Incorrect number of sectors read", 0