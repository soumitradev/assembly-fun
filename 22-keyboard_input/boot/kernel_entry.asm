; Jump to our kernel. This isn't in our boot sector. This will be in the kernel file after linking.
[bits 32]
[extern kmain]
call kmain
; If kernel returns, hang
jmp $