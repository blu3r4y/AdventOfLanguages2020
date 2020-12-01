day1: bin/day1

clean:
	rm bin/day1
	rm bin/day1.o

bin/day1: src/day1.s
	mkdir -p bin
	as --32 -g --gstabs -o bin/day1.o src/day1.s
	ld -m elf_i386 -o bin/day1 bin/day1.o
	chmod +x bin/day1
