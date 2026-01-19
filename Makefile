.PHONY: all run_nasm run_fasm clean

all: nasm_server fasm_server

nasm_server: nasm_server.o
	ld $^ -o $@

nasm_server.o: nasm_server.asm
	nasm -g -f elf64 $^ -o $@

fasm_server: fasm_server.asm
	fasm $^

run_nasm: nasm_server
	./$<

run_fasm: fasm_server
	./$<

clean:
	rm nasm_server fasm_server *.o
