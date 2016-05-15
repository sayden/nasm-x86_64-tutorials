# Sums 5 and 3 calling a function

.section .data

.section .text

.globl _start
_start:
  pushq $15
  pushq $23
  call sum

  movq $60, %rax
  movq %rbx, %rdi
  syscall

sum:
  movq 8(%rsp), %rcx
  movq 16(%rsp), %rbx
  addq %rcx, %rbx
  ret
