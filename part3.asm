section .data
	SYS_WRITE	equ 1
	STD_IN		equ 1
	SYS_EXIT	equ 60
	EXIT_CODE	equ 0

	NEW_LINE	db 0xa
	WRONG_ARGC	db "Must be two command line argument", 0xa

section .text
	global	_start

_start:
	pop	rcx													;; rcx - argc. Put number of arguments in rcx

	cmp	rcx, 3											;; Check that we have 3 arguments (program name and the 2 values to sum)
	jne	argcError										;; Jump to argcError if arguments aren't 3

	;; start to sum arguments
	add	rsp, 8											;; skip argv[0] - program name, put pointer on first argument
	pop	rsi													;; get argv[1] from previously placed pointer and put it in rsi
	call str_to_int									;; convert argv[1] str to int
	mov	r10, rax										;; put first num to r10
	pop	rsi													;; get argv[2]
	call	str_to_int								;; convert argv[2] str to int
	mov	r11, rax										;; put second num to r10
	add	r10, r11										;; sum it

	mov	rax, r10										;; Convert to string
	xor	r12, r12										;; number counter
	jmp	int_to_str									;; convert to string

;; Print argc error
argcError:
	mov	rax, 1											;; sys_write syscall
	mov	rdi, 1											;; file descritor, standard output
	mov	rsi, WRONG_ARGC							;; message address
	mov	rdx, 34											;; length of message
	syscall													;; call write syscall
	jmp	exit												;; exit from program


;; Convert int to string
int_to_str:
	mov	rdx, 0											;; reminder from division
	mov	rbx, 10											;; base
	div	rbx													;; rax = rax / 10
	add	rdx, 48											;; add \0
	add	rdx, 0x0
	push	rdx												;; push reminder to stack
	inc	r12													;; go next
	cmp	rax, 0x0										;; check factor with 0
	jne	int_to_str									;; loop again
	jmp	print												;; print result

;; Convert string to int
;; We have left one of the args (the number) in rsi
str_to_int:
	mov	rax, 0											;; set rax to 0
	mov	rcx,  10										;; base for multiplication
next:
	cmp	[rsi], byte 0								;; check that it is end of string cheking first byte of rsi with 0
	je	return_str									;; return int if the comparison is null
	mov	bl, [rsi]										;; mov current byte to bl (rbx?)
	sub	bl, 48											;; substract 48 to get the number (all numbers from 0 to 9 are mapped on 48 to 57) so 48 - 48 is 0, 55 - 48 is 7
	mul	rcx													;; rax = rax * 10
	add	rax, rbx										;; ax = ax + digit
	inc	rsi													;; get next number
	jmp	next												;; again
return_str:
	ret


;; Print number
print:
	;;;; calculate number length
	mov	rax, 1
	mul	r12
	mov	r12, 8
	mul	r12
	mov	rdx, rax

	;;;; print sum
	mov	rax, SYS_WRITE
	mov	rdi, STD_IN
	mov	rsi, rsp
	syscall													;; call sys_write

	;; newline
	jmp	printNewline

;; Print number
printNewline:
	mov	rax, SYS_WRITE
	mov	rdi, STD_IN
	mov	rsi, NEW_LINE
	mov	rdx, 1
	syscall
	jmp	exit

;; Exit from program
exit:
	mov	rax, SYS_EXIT								;; syscall number
	mov	rdi, EXIT_CODE							;; exit code
	syscall													;; call sys_exit
