[extern isr_handler]
[extern irq_handler]

isr_common_format:
    pusha
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call isr_handler

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8
    sti
    iret

irq_common_format:
    pusha
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    call irq_handler

    pop ebx
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    add esp, 8
    sti
    iret

global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

global irq0
global irq1
global irq2
global irq3
global irq4
global irq5
global irq6
global irq7
global irq8
global irq9
global irq10
global irq11
global irq12
global irq13
global irq14
global irq15

isr0:
    cli
    push byte 0
    push byte 0
    jmp isr_common_format


isr1:
    cli
    push byte 0
    push byte 1
    jmp isr_common_format


isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_format


isr3:
    cli
    push byte 0
    push byte 3
    jmp isr_common_format


isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_format


isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_format


isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_format


isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_format


isr8:
    cli
    push byte 8
    jmp isr_common_format


isr9:
    cli
    push byte 0
    push byte 9
    jmp isr_common_format


isr10:
    cli
    push byte 10
    jmp isr_common_format


isr11:
    cli
    push byte 11
    jmp isr_common_format


isr12:
    cli
    push byte 12
    jmp isr_common_format


isr13:
    cli
    push byte 13
    jmp isr_common_format


isr14:
    cli
    push byte 14
    jmp isr_common_format


isr15:
    cli
    push byte 0
    push byte 15
    jmp isr_common_format


isr16:
    cli
    push byte 0
    push byte 16
    jmp isr_common_format


isr17:
    cli
    push byte 0
    push byte 17
    jmp isr_common_format


isr18:
    cli
    push byte 0
    push byte 18
    jmp isr_common_format


isr19:
    cli
    push byte 0
    push byte 19
    jmp isr_common_format


isr20:
    cli
    push byte 0
    push byte 20
    jmp isr_common_format


isr21:
    cli
    push byte 0
    push byte 21
    jmp isr_common_format


isr22:
    cli
    push byte 0
    push byte 22
    jmp isr_common_format


isr23:
    cli
    push byte 0
    push byte 23
    jmp isr_common_format


isr24:
    cli
    push byte 0
    push byte 24
    jmp isr_common_format


isr25:
    cli
    push byte 0
    push byte 25
    jmp isr_common_format


isr26:
    cli
    push byte 0
    push byte 26
    jmp isr_common_format


isr27:
    cli
    push byte 0
    push byte 27
    jmp isr_common_format


isr28:
    cli
    push byte 0
    push byte 28
    jmp isr_common_format


isr29:
    cli
    push byte 0
    push byte 29
    jmp isr_common_format


isr30:
    cli
    push byte 0
    push byte 30
    jmp isr_common_format


isr31:
    cli
    push byte 0
    push byte 31
    jmp isr_common_format


irq0:
    cli
    push byte 0
    push byte 32
    jmp irq_common_format


irq1:
    cli
    push byte 1
    push byte 33
    jmp irq_common_format


irq2:
    cli
    push byte 2
    push byte 34
    jmp irq_common_format


irq3:
    cli
    push byte 3
    push byte 35
    jmp irq_common_format


irq4:
    cli
    push byte 4
    push byte 36
    jmp irq_common_format


irq5:
    cli
    push byte 5
    push byte 37
    jmp irq_common_format


irq6:
    cli
    push byte 6
    push byte 38
    jmp irq_common_format


irq7:
    cli
    push byte 7
    push byte 39
    jmp irq_common_format


irq8:
    cli
    push byte 8
    push byte 40
    jmp irq_common_format


irq9:
    cli
    push byte 9
    push byte 41
    jmp irq_common_format


irq10:
    cli
    push byte 10
    push byte 42
    jmp irq_common_format


irq11:
    cli
    push byte 11
    push byte 43
    jmp irq_common_format


irq12:
    cli
    push byte 12
    push byte 44
    jmp irq_common_format


irq13:
    cli
    push byte 13
    push byte 45
    jmp irq_common_format


irq14:
    cli
    push byte 14
    push byte 46
    jmp irq_common_format


irq15:
    cli
    push byte 15
    push byte 47
    jmp irq_common_format
