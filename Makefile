C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

GDB = /usr/bin/gdb

run: os-image
	qemu-system-x86_64 -drive format=raw,file=os-image

debug: os-image kernel.elf
	qemu-system-x86_64 -drive format=raw,file=os-image -gdb tcp::1234 -S
# ${GDB} -ex "target remote localhost:1234" -ex "symbol-file kernel.elf"

os-image: main.bin kernel.bin
	cat $^ > os-image

kernel.elf: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --entry main

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary --entry main

%.o : %.c ${HEADERS}
	gcc -ggdb -O0 -ffreestanding -c $< -o $@
	
%.o : %.asm
	nasm $< -f elf64 -o $@
	
%.bin : %.asm
	nasm $< -f bin -o $@
	
clean:
	rm -fr *.bin *.dis *.o
	rm -fr kernel/*.o boot/*.bin drivers/*.o
	rm os-image
