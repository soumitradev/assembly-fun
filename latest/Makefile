C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

all: os-image

run: all
	qemu-system-x86_64 -hda os-image -boot c

os-image: boot/boot_sect.bin kernel.bin
	cat $^ > $@

kernel.bin: kernel/kernel.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary
	
%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -I ./boot/ -o $@

clean:
	rm -fr *.bin *.dis *.o os-image
	rm -fr kernel/*.o boot/*.bin drivers/*.o