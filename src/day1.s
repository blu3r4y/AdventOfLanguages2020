# Advent of Code 2020, Day 1
# (c) blu3r4y

# interrupts
.equ LINUX_SYSCALL, 0x80

# i/o system calls
.equ SYS_READ, 3
.equ SYS_WRITE, 4
.equ SYS_OPEN, 5
.equ SYS_CLOSE, 6

# file descriptors
.equ STDOUT_FILENO, 1

# special values
.equ CHAR_LF, 10

# flags for file handling
.equ O_RDONLY, 0

.section .data

    # we abuse %ebp, so we store it here
    save_base_pointer:
        .long 0

    # we abuse %esp, so we store it here
    save_stack_pointer:
        .long 0

    # input file descriptor
    input_fd:
        .long 0

    # input file path relative to the root directory
    input_path:
        .ascii "./data/day1.txt\0"

    # the entire input file (up to 4 KB)
    buffer_size:
        .long 4096

    # stores the number of bytes read
    file_size:
        .long 0

    # the number of numbers in the input file
    input_length:
        .long 0

    # the parsed input (up to 1024 numbers)
    # represented as an array of integers
    input:
        .fill 1024, 4, 0

    # the solution for part 1 - must be lower than 2.147.483.647 for reasons ;)
    solution_part1:
        .long -1

    # the solution for part 2 - must be lower than 2.147.483.647 for reasons ;)
    solution_part2:
        .long -1

    # ascii representation buffer for printing the solutions
    ascii_buffer:
        .fill 16, 1, 0

    # we use this as a small helper bit in the final output
    checkpoint:
        .long 0

.section .bss

    # input file buffer (up to 4KB)
    .lcomm input_buffer, 4096

.section .text
.globl _start

_start:

    # save stack pointers because we will abuse those registers

    movl %ebp, save_base_pointer
    movl %esp, save_stack_pointer

    # open input file
    # ###############

    leal input_path, %ebx       # input filename string
    movl $O_RDONLY, %ecx        # read-only flag
    movl $0, %edx               # we don't need a mode for reading
    movl $SYS_OPEN, %eax        # open https://man7.org/linux/man-pages/man2/open.2.html
    int $LINUX_SYSCALL

    cmpl $0, %eax               # check open errors
    jl exit_error

    movl %eax, input_fd         # store input file descriptor


    # read input file
    # ###############

    movl input_fd, %ebx          # file descriptor
    leal input_buffer, %ecx      # the buffer
    movl buffer_size, %edx       # size of the reading buffer
    movl $SYS_READ, %eax         # read https://man7.org/linux/man-pages/man2/read.2.html
    int $LINUX_SYSCALL

    cmpl $0, %eax                # check read errors
    jl exit_error

    movl %eax, file_size         # store number of read bytes


    # close input file
    # ################

    movl input_fd, %ebx
    movl $SYS_CLOSE, %eax        # close https://man7.org/linux/man-pages/man2/close.2.html
    int $LINUX_SYSCALL


    # loop and parse bytes to numbers
    # ###############################

    movl $0, %esi                # input buffer index
    movl $0, %edi                # output array index

parse_next_byte:

    movl $0, %edx                # clean register because we only write 8 bit next

    leal input_buffer, %ebx      # get base address of buffer
    movb (%ebx, %esi, 1), %dl    # store byte at index esi into dl [char]
    cmpb $CHAR_LF, %dl           # jump on LF characters
    je parse_next_line

    # parse number and store in-place

    leal input, %ebx             # get base address of final array
    movl (%ebx, %edi, 4), %ecx   # read current value at index edi into ecx

    subl $0x30, %edx             # [char] = [char] - 0x30 (to get the numeric value)

    imull $10, %ecx              # [value] = [value] * 10
    addl %edx, %ecx              # [value] = [value] + [char]

    movl %ecx, (%ebx, %edi, 4)   # update array value at index edi

    jmp check_end_of_buffer

parse_next_line:

    incl %edi                    # advance the array index on LF characters

check_end_of_buffer:

    incl %esi                    # increase loop index
    cmpl file_size, %esi         # keep looping while %esi < file_size
    jl parse_next_byte

    movl %edi, input_length      # store parsed number of numbers


    # threefold-nested loop over all values
    # #####################################

    leal input, %ebx             # store base address of our array of numbers

    movl $0, %esi                # i

advance_i:

    movl $0, %edi                # j

advance_j:

    movl $0, %ebp                # k (... all loop indexes are beautiful, also stack pointers!)

advance_k:

    movl (%ebx, %esi, 4), %eax   # %eax = array[i]
    movl (%ebx, %edi, 4), %ecx   # %ecx = array[j]
    movl (%ebx, %ebp, 4), %esp   # %esp = array[k] (... we don't need no stack!)

    # check part 1 condition

    movl %eax, %edx
    addl %ecx, %edx              # %edx = array[i] + array[j]
    cmpl $2020, %edx             # check if the addition of those 2 values equals 2020
    je found_part1_solution

    jmp check_part2_condition

found_part1_solution:

    movl %eax, %edx
    imull %ecx, %edx             # %edx = array[i] * array[j]
    movl %edx, solution_part1    # store solution for part 1

check_part2_condition:

    # check part 2 condition

    movl %eax, %edx
    addl %ecx, %edx
    addl %esp, %edx              # %edx = array[i] + array[j] + array[k]
    cmpl $2020, %edx             # check if the addition of those 3 values equals 2020
    jne check_end_of_loops

    movl %eax, %edx
    imull %ecx, %edx
    imull %esp, %edx             # %edx = array[i] * array[j] * array[k]
    movl %edx, solution_part2    # store solution for part 2

check_end_of_loops:

    # end loops early if we already found a solution

    cmpl $-1, solution_part1
    je continue_loops

    cmpl $-1, solution_part2
    jne end_loop

continue_loops:

    incl %ebp
    cmpl input_length, %ebp      # keep looping while k < input_length (inner-most loop)
    jl advance_k

    incl %edi
    cmpl input_length, %edi      # keep looping while j < input_length
    jl advance_j

    incl %esi
    cmpl input_length, %esi      # keep looping while i < input_length (outer-most loop)
    jl advance_i

end_loop:

    # restore abused stack pointers

    movl save_base_pointer, %ebp
    movl save_stack_pointer, %esp

    # format the output values for part 1
    # ###################################

    leal ascii_buffer, %edi      # store destination string base pointer

    movl solution_part1, %eax

redo_for_part2_solution:

    movl $0, %ebx                # clear stack push counter %ebx

    movl $0, 1(%edi)
    movl $0, 4(%edi)
    movl $0, 8(%edi)
    movl $0, 12(%edi)            # clear the 16 bit ascii buffer

push_characters:

    movl $0, %edx                # clear division result register
    movl $10, %ecx               # store divisor
    divl %ecx                    # compute %edx / 10 with the result in %eax and remainder in %edx

    addl $0x30, %edx             # convert the remainder to an ascii character
    pushl %edx                   # push ascii character (so we can pop them in reverse)
    incl %ebx                    # count the number of pushed characters

    cmpl $0, %eax                # continue looping, until the division will yield 0
    jne push_characters

    movl $0, %esi                # initialize index to destination string

pop_characters:

    popl %eax                    # pop ascii character
    movb %al, (%edi, %esi, 1)    # append character to string

    incl %esi
    decl %ebx

    cmpl $0, %ebx                # stop if we poped all characters
    jne pop_characters

    movb $CHAR_LF, (%edi, %esi, 1)

    # write to stdout
    # ###############

    movl $STDOUT_FILENO, %ebx    # standard output descriptor
    leal ascii_buffer, %ecx      # the read input buffer
    movl $16, %edx               # output buffer size
    movl $SYS_WRITE, %eax        # write https://man7.org/linux/man-pages/man2/write.2.html
    int $LINUX_SYSCALL

    # format the output values for part 2 (with a very ugly hack, sorry ..)
    # #####################################################################

    cmpl $1, checkpoint          # check if we already passed this point once
    je exit_success              # ... if so, we are done
    movl $1, checkpoint          # mark the checkpoint

    movl solution_part2, %eax    # redo the above output loop with the value for part 2

    jmp redo_for_part2_solution

exit_error:

    movl $-1, %ebx
    jmp exit_syscall

exit_success:

    movl $0, %ebx
    jmp exit_syscall

exit_syscall:

    movl $1, %eax
    int $LINUX_SYSCALL
