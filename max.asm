section .data
    ;Last item is zero to recognize the end
    data_items: db 1,2,3,4,0
    SYS_EXIT	equ 1
    EXIT_CODE	equ 0

section .text

global _start
_start:
    ; Set the first index in array as current maximum
    mov edi, 0
    mov eax, [data_items + edi]
    mov ebx, eax

start_loop:
    inc edi           ; edi++
    mov eax, [data_items + edi]
    cmp eax, 0        ; Check if it's last item is zero to finish
    je end_loop       ; je is "jump if equals"
    cmp ebx, eax
    jle start_loop    ; jle is "jump if lower or equal"
    mov ebx, eax
    jmp start_loop

end_loop:
    mov eax, SYS_EXIT
    int $0x80
