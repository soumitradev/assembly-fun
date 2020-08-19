ENTRY(main)
OUTPUT_FORMAT(elf64-x86-64)

SECTIONS {
    .text : ALIGN(0x1000) {
        _TEXT_START_ = .;
            *(.text)
        _TEXT_END_ = .;
    }
}