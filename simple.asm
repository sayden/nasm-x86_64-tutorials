%include "io64.inc"

section .text
global CMAIN
CMAIN:
    mov rsi, 1
    mov rax, 1
    mov rdi, 1
    mov rdx, 15
    syscall
    
    mov rax, 60
    mov rdi, 0
    syscall
    
    