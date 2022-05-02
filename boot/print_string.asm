print_string:
    pusha

start:
    mov al, [bx]
    cmp al, 0
    je print_end

    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp start

print_end:
    mov ah, 0x0e
    mov al, 0x0a
    int 0x10

    mov al, 0x0d
    int 0x10

    popa
    ret
