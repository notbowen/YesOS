C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

GDB = /usr/bin/gdb

run: os-image.bin
	qemu-system-x86_64 -drive format=raw,file=os-image.bin,if=floppy

debug: os-image.bin kernel.elf
	qemu-system-x86_64 -drive format=raw,file=os-image.bin,if=floppy -gdb tcp::1234 -S

os-image.bin: boot.bin kernel.bin
	cat $^ > os-image.bin

kernel.elf: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --entry main

kernel.bin: boot/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary --entry main

boot.bin: boot/boot.asm
	nasm $< -f bin -o $@

%.o : %.c ${HEADERS}
	gcc -ggdb -O0 -ffreestanding -c $< -o $@
	
%.o : %.asm
	nasm $< -f elf64 -o $@
	
%.bin : %.asm
	nasm $< -f bin -o $@
	
clean:
	rm -fr *.bin *.dis *.o
	rm -fr kernel/*.o boot/*.bin drivers/*.o
	rm -fr *.elf
