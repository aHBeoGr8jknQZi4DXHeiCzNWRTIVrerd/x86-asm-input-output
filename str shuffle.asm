global _start
section .bss
    ib resb 256
    ob resb 256

section .data
    input db "Input: $"
    nl db 0xA
    
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, 7
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, ib
    mov edx, 255
    int 0x80

    mov eax, 0
    mov ecx, ib
    xor edx, edx

shuffle:
    mov al, [ecx + edx]
    test al, al
    jz shuffle_exit
    xor al, 18
    mov [ob + edx], al
    inc edx
    jmp shuffle

shuffle_exit:
    mov eax, 4
    mov ebx, 1
    mov ecx, ob
    mov edx, edx
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
