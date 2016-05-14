.section .data
  .equ min_number, 0
  .equ EXIT_CALL, 1
  .equ SYS_EXIT, 0x80
  data_items:
    .long 3,67,34,222,45,75,54,34,44,33,22,11,66,min_number

.section .text
  .globl _start

_start:
  movl $0, %edi
  movl data_items(,%edi,4), %eax # load the first byte of data
  movl %eax, %ebx

start_loop:
  incl %edi
  movl data_items(,%edi,4), %eax
  cmpl $min_number, %eax
  je loop_exit
  cmpl %ebx, %eax
  jle start_loop
  movl %eax, %ebx
  jmp start_loop

loop_exit:
  movl $EXIT_CALL, %eax
  int $SYS_EXIT
