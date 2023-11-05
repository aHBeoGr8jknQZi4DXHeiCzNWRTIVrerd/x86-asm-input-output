global _start
section .bss
    ib resb 256
    
section .data
    input db "Input: $"

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
    
    mov eax, 4
    mov ebx, 1
    mov ecx, ib
    xor edx, edx
    
    len:
        cmp byte [ib + edx], 0
        je len_exit
        inc edx
        jmp len
    len_exit:
    int 0x80
    
    push esp
    mov [esp], byte 0xA
    
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80
