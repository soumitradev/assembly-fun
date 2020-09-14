C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c lib/*.c mm/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h cpu/*.h lib/*.h mm/*.h)
OBJ = ${C_SOURCES:.c=.o cpu/interrupt.o}

CC = /usr/local/i386elfgcc/bin/i386-elf-gcc
GDB = /usr/local/i386elfgcc/bin/i386-elf-gdb

CFLAGS = -g

os-image.bin: boot/boot_sect.bin kernel.bin
	cat $^ > $@

kernel.bin: boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -T linker.ld $^ --oformat binary

kernel.elf: boot/kernel_entry.o ${OBJ}
	i386-elf-ld -o $@ -T linker.ld $^

run: os-image.bin
	qemu-system-i386 -no-reboot -d int -monitor stdio -hda $^

debug: os-image.bin kernel.elf
	qemu-system-i386 -s -hda os-image.bin &
	${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

%.o: %.c ${HEADERS}
	${CC} ${CFLAGS} -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -I ./boot/ -o $@

clean:
	rm -fr *.bin *.dis *.o os-image.bin *.elf
	rm -fr kernel/*.o boot/*.bin drivers/*.o boot/*.o cpu/*.o lib/*.o  mm/*.o