# Sums 5 and 3 calling a function
.section .data

.section .text

.globl _start
_start:
  movl $5, %ebx
  movl $3, %ecx
  call sum

  movl $1, %eax
  int $0x80

sum:
  pushq   %rbp               # Standard function stuff. We have to restore %rbp to its
                             # previous state before returning so we push it now
  addl %ecx, %ebx
  ret
