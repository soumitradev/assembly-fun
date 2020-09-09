; I know i haven't explained how we're slowly moving to 32 bits, but we need to prepare
; a table called the Global Descriptor Table (GDT) to switch into 32 bit mode.
; This table gives the CPU information about what parts of memory it should protect, where
; new data can be stored, etc.

; The weird thing is, that the descriptions are broken into smaller parts and spread all over the GDT.

; Basically, its like a partition table for memory so we can do epic stuff later
; (like use C and get acces to upto 4GB of data 😉)

; This marks the start of the GDT/
gdt_start:

; Start the GDT with 8 null bytes. This is mandatory. dd means declare doublew word. double = 4 bytes
gdt_null:
  dd 0x0
  dd 0x0

; This describes the code segment of our memory. This is where code is loaded
gdt_code:
  ; Limit (only bits 0-15). This is where the code segment of memory ends.
  dw 0xffff
  ; Base (bits 0-15 and 16-23). This is where the code segment of memory starts
  dw 0x0
  db 0x0

  ; Note how our code segment is from 0x0 to 0xfffff


  ; Bunch of flags.
  ; 1 : Present (1 since segment is present in memory, and is used for code)
  ; 00 : Privilege (0 is highest privilege)
  ; 1 : Descriptor type (1 for code or data segment, 0 for traps (even I have no idea what traps are))
  ; 1 : Code (1, since this is a code segment)
  ; 0 : Conforming (0, which means code with lower privilege cannot call code in this segment)
  ; 1 : Readable (1 if read-only, 0 of execute only. Readable allows us to read constants)
  ; 0 : Accessed (Used for debugging, not needed)
  db 10011010b

  ; More flags
  ; 1 : Granularity (Multiplier for limit)
  ; 1 : 32 bit default (1 since this will hold 32 bit code) 
  ; 0 : 64 bit segment (0 since this is not 64 bit... yet 😏)
  ; 0 : AVL (Used, for debugging, not needed)
  ; The rest of the 1's are the limit's 16-19 bits
  db 11001111b

  ; The base bits 24-31
  db 0x0

gdt_data:
  ; Limit (only bits 0-15). This is where the code segment of memory ends.
  dw 0xffff

  ; Base (bits 0-15 and 16-23). This is where the code segment of memory starts
  dw 0x0
  db 0x0

  ; Note how our data segment is from 0x0 to 0xfffff


  ; Bunch of flags.
  ; 1 : Present (1 since segment is present in memory, and is used for code)
  ; 00 : Privilege (0 is highest privilege)
  ; 1 : Descriptor type (1 for code or data segment, 0 for traps (even I have no idea what traps are))
  ; 0 : Code (0, since this is a code segment)
  ; 0 : Conforming (0, which means code with lower privilege cannot call code in this segment)
  ; 1 : Readable (1 if read-only, 0 of execute only. Readable allows us to read constants)
  ; 0 : Accessed (Used for debugging, not needed)
  db 10010010b

  ; More flags
  ; 1 : Granularity (Multiplier for limit)
  ; 1 : 32 bit default (1 since this will hold 32 bit code) 
  ; 0 : 64 bit segment (0 since this is not 64 bit... yet 😏)
  ; 0 : AVL (Used, for debugging, not needed)
  ; The rest of the 1's are the limit's 16-19 bits
  db 11001111b

  ; The base bits 24-31
  db 0x0

gdt_end:

; Write size and start of gdt
gdt_descriptor:
  ; GDT size. Always 1 byte lesser than true size
  dw gdt_end - gdt_start - 1
  ; Start address of GDT
  dd gdt_start

; Define useful constants for memory locations
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
