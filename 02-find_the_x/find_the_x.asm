mov ah, 0x0e
; Allow us to print to screen, enable scrolling teletype BIOS routine

; Move the the_secret to register a. This only writes the location of the offset, not the data at the offset
mov al, the_secret
int 0x10
; Call BIOS interrupt and try to print register a. This will not print "X" since a stores the offset length

; Move the value of the_secret to register a. This writes the value stored at the offset location in memory
mov al, [the_secret]
int 0x10
; Call BIOS interrupt and try to print register a. This will not print "X" since a stores the value of the
; location in memory at offset. This is not in our boot sector.

; Move the_secret to register b. This writes the location of offset to b.
mov bx, the_secret
; Add 0x7c00 to the value in register b. 0x7c00 is the location where our boot sector starts
add bx, 0x7c00
; Move the value in memory at location of bx (which is now 0x7c00 + offset) to register a.
mov al, [bx]
int 0x10
; Call BIOS interrupt and try to print register a. This will print "X" since we first added the length
; of the offset to the location of the start of our boot sector. This is where the_secret is stored.
; If we access this memory and print it like we did, it will print "X"

; Move the value stored in memory in our boot sector at location 0x7c00 + offset, and print it.
; This will work, but only because we manually added the offset length to 0x7c00
mov al, [0x7c1e]
int 0x10

; Write the literal "X" in part of boot sector
the_secret:
db "X"

; Loop infinitely after finishing
jmp $

; Pad rest of boot sector with zeroes
times 510-($-$$) db 0

; Write magic number at end of boot sector
dw 0xaa55 