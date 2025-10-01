section .bss
    buffer resb 20

section .text
    global _start

int2str:
    push ebx
    push edx

    mov ecx, 0
    add esi, 19
    mov byte [esi], 0

    cmp eax, 0
    jne .loop_digit
    dec esi
    mov byte [esi], '0'
    mov ecx, 1
    mov eax, esi
    jmp .end_func

.loop_digit:
    xor edx, edx
    mov ebx, 10
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    inc ecx
    test eax, eax
    jnz .loop_digit

    mov eax, esi

.end_func:
    pop edx
    pop ebx
    ret

_start:
    mov eax, 1234567
    mov esi, buffer
    call int2str

    push eax
    mov edx, ecx
    mov eax, 4
    mov ebx, 1
    pop ecx
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80