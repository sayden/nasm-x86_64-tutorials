%include "io64.inc"

section .data
  msg db "hello, world!"

section .text
  global CMAIN

CMAIN:
    mov rbp, rsp; for correct debugging
  mov     rax, 1
  mov     rdi, 1
  mov     rsi, msg
  mov     rdx, 13
  syscall
  mov     rax, 60
  mov     rdi, 0
  syscall
