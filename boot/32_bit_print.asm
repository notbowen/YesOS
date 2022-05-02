[bits 32]
; Constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY  ; Set start of edx to vid mem

print_string_pm_loop:
    mov al, [ebx]
    mov ah, WHITE_ON_BLACK

    cmp al, 0
    je done

    mov [edx], ax
    add ebx, 1
    add edx, 2

    jmp print_string_pm_loop

done:
    popa
    ret