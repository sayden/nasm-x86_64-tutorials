# PURPOSE: Illustrate how function works.
#         Will compute 2^3=8

.section .data

.section .text

.globl _start
_start:
  pushq $5            #Push second argument stack=8
  pushq $3            #Push first argument  stack=16
  call  power         #Call power function
  addq  $16,   %rsp    #Move the stack pointer back the two words (8 bytes each)

  movq %rax, %rdi
  movq $60, %rax
  syscall

# power computes the power of 2 numbers
# Returns the value on %rax
.type power, @function
power:
  pushq %rbp          #Save old base pointer
  movq  %rsp, %rbp    #Make stack pointer the base pointer
  subq  $8,   %rsp    #Take 8 bytes of space allocation for local storage stack=24

  movq  24(%rbp),  %rbx #put first argument in %rbx
  movq  16(%rbp),  %rcx #put second argument in %rcx

  movq %rbx,  -8(%rbp) #Store current result

power_loop_start:
  cmpq   $1,       %rcx  #if the power is 1, finish
  je     end_power          #jump to end_power if previous call was ==
  movq   -8(%rbp), %rax  #movqe current result to %rax
  imulq  %rbx,     %rax  #multiply current result by base number
  movq   %rax,     -8(%rbp)  #Store current result
  decq   %rcx             #Substract 1 to the power number
  jmp   power_loop_start  #Start again

end_power:
  movq  -8(%rbp), %rax  #return value goes into %rax
  movq  %rbp,     %rsp  #restore the stack pointer
  popq  %rbp            #restore the base pointer
  ret
