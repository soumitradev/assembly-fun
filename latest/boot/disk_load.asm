disk_load:
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

  ; mov ah, 0x42
  
  ; mov byte [DAP.numberOfSectors], dh
  ; mov si, DAP
  ; int 0x13
  
  ; mov bx, DISK_ERROR_MSG
  ; call print_str
  ; jc disk_error
  ; Restore dx
  pop dx
  ; If all sectors are read, do nothing. Else, error out
  cmp dh, al
  jne disk_error
  ret

; Print disk error message on error
disk_error:
  mov bx, DISK_ERROR_MSG
  call print_str
  ; Loop infinitely after finishing
  jmp $

; Write our byte to memory
DISK_ERROR_MSG:
db "Disk error.", 0

; DAP:
;   .size: db 0x10 ; size of DAP
;   .unused: db 0 ; unused
;   .numberOfSectors: dw 15 ; number of sectors to be read
;   .offset: dd 0x7c00 ; buffer addr
;   .lbaStart: dq 1 ; first sector

; disk_load:
;     mov ah, 0x42
;     mov si, DAP
;     mov byte [DAP.numberOfSectors], dh
;     int 0x13

;     jc disk_error
;     jmp $

;     ret

; disk_error:
;   mov bx, DISK_ERROR_MSG
;   call print_str
;   ; Loop infinitely after finishing
;   jmp $

; DISK_ERROR_MSG: db 'Disk error.', 0
; STUFF: db 'Random text', 0

; DAP:
;   .size: db 0x10 ; size of DAP
;   .unused: db 0 ; unused
;   .numberOfSectors: dw 15 ; number of sectors to be read
;   .offset: dd 0x7e00 ; buffer addr
;   .lbaStart: dq 1 ; first sector