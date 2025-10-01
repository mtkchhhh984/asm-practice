section .bss
    buffer resb 20

section .text
    global _start

int2str:
    push rbx
    push rdx

    mov rcx, 0
    add rsi, 19
    mov byte [rsi], 0

    cmp rax, 0
    jne .loop_digit
    dec rsi
    mov byte [rsi], '0'
    mov rcx, 1
    mov rax, rsi
    jmp .end_func

.loop_digit:
    xor rdx, rdx
    mov rbx, 10
    div rbx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    inc rcx
    test rax, rax
    jnz .loop_digit

    mov rax, rsi

.end_func:
    pop rdx
    pop rbx
    ret

_start:
    mov rax, 1234567
    mov rsi, buffer
    call int2str

    push rax
    mov rdx, rcx
    mov rax, 1
    mov rdi, 1
    pop rsi
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall