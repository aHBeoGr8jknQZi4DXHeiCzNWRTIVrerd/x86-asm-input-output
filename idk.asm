section .bss
    ib resb 256
    ib2 resb 256

section .data
    input db "Input: $"
    input2 db "Repeat (1-9): $"
    nl db 0xA
    
section .text
    global _start

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
    ret

get_len:
    xor edx, edx
    len:
        cmp byte [ib + edx], 0
        je len_exit
        inc edx
        jmp len
    len_exit:
    ret

_start:
    repeat:
        mov eax, 4                          
        mov ebx, 1
        mov ecx, input2
        mov edx, 14
        int 0x80

        mov eax, 3
        mov ebx, 0
        mov ecx, ib2
        mov edx, 255
        int 0x80

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
        

        xor esi, esi
        ctn:
            mov al, byte [ib2 + esi]
            cmp al, 0
            je ctn_exit
            sub al, '0'
            imul esi, 10
            add esi, eax
            inc esi
            jmp ctn
        ctn_exit:
        
        dec esi
        
        loopity:
            mov eax, 4
            mov ebx, 1
            mov ecx, ib
            call get_len
            int 0x80

            dec esi
            jz loopity_exit
            jmp loopity
        loopity_exit:
        jmp repeat
    

    call exit

