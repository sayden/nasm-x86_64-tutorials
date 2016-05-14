    %include "io64.inc"

section .text
global CMAIN
CMAIN:
    mov rax, 10
    mov rdi, 1
    add rax, rdi
    ;rax now has the sum of 10 + 1
    
    mov rdx, rax
    mov rsi, rax
    syscall

    mov rsi, rax    
    mov rax, 1
    mov rdi, 0
    syscall
    