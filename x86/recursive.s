# Factorial of N

.section .data
  .equ n, 4
  .equ SYS_EXIT, 60

.section .text

.globl _start
_start:
  pushq   $n
  call    factorial
  movq    $8,       %rsp    #Scrubs the parameter that was pushed on to stack

  movq    %rax,      %rdi
  movq    $SYS_EXIT, %rax
  syscall

# Number is on to stack
factorial:
  pushq   %rbp               # Standard function stuff. We have to restore %rbp to its
                             # previous state before returning so we push it now
  movq    %rsp,      %rbp    # Avoid to modify stack pointer. We use rbp
  movq    16(%rbp),  %rax    # Moves first argument to rax
  cmpq    $1,        %rax    # Check if rax value is 1
  je      end_factorial
  decq    %rax               # Subtract 1 to the current factorial value
  pushq   %rax               # Push it for our call to factorial
  call    factorial
  movq    16(%rbp),  %rbx    # rbx has return value so we reload our parameter
  imulq   %rbx,      %rax    # Multiply that by the result of the last call to
                             # factorial (in %rax). The answer is stored in rax
end_factorial:
  movq    %rbp,      %rsp
  popq    %rbp
  ret
