day1: ../src/day1.s
    as --32 -g --gstabs -o day1.o ../src/day1.s
    ld -m elf_i386 -o day1 day1.o
    chmod +x day1

clean:
    rm -f day1
    rm -f day1.o
