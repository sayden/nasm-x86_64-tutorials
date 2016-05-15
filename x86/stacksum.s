# Sums 5 and 3 calling a function
.code32

.section .data

.section .text

.globl _start
_start:
  pushl $15
  pushl $23
  call sum

  movl $1, %eax
  int $0x80

sum:
  movl 8(%esp), %ecx
  movl 16(%esp), %ebx
  addl %ecx, %ebx
  ret
