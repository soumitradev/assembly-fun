; We are still in 16 bit mode
[bits 16]

; Create a jump point so we can jump into 32 bit
switch_to_pm:

; Disable all system interrupts since those only work in 16 bit mode.
cli

; Load gdt
lgdt [gdt_descriptor]

; To switch to 32 bit protected mode, we need to set this register on the CPU
mov eax, cr0
or eax, 0x1
mov cr0, eax

; Make a long jump (into a new segment) into our 32 bit code so that CPU flushes cache of 16bit instructions
jmp CODE_SEG:init_pm

[bits 32]

init_pm:
  ; Move all segment registers to our GDT defined data segment
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  ; Update stack position
  mov ebp, 0xffff0
  mov esp, ebp

  ; Begin 32 bit mode
  call begin_pm