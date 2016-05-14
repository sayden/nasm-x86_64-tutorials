.section .data
  .equ max_number, 999
  .equ EXIT_CALL, 1
  .equ SYS_EXIT, 0x80
  data_items:
    .long 3,67,34,1,45,75,54,34,44,33,22,11,66,max_number

.section .text
  .globl _start

_start:
  #Take the first item in array and set it as minimum
  movl $0, %edi
  movl data_items(,%edi,4), %eax # load the first byte of data
  movl %eax, %ebx

start_loop:
  # Put array value in edi index in eax and go to "loop_exit" if eax equals max_number
  incl %edi
  movl data_items(,%edi,4), %eax
  cmpl $max_number, %eax
  je loop_exit

  # Go to start_loop if eax greater or equal to ebx
  cmpl %ebx, %eax
  jge start_loop

  # If you reached here is because eax is lower than ebx so assign eax to ebx
  # and go to start_loop
  movl %eax, %ebx
  jmp start_loop

loop_exit:
  movl $EXIT_CALL, %eax
  int $SYS_EXIT
