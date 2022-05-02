disk_load:
    pusha
    push dx

    mov ah, 0x02
    mov al, dh
    mov cl, 0x02
    mov ch, 0x00
    mov dh, 0x00

    int 0x13 ; BIOS Disk Read Interrupt

    jc disk_error

    pop dx
    cmp al, dh
    jne sectors_error
    popa 
    ret

disk_error:
    mov bx, DISK_ERROR
    call print_string

    mov dh, ah
    call print_hex

    jmp $

sectors_error:
    mov bx, SECTORS_ERROR
    call print_string

    jmp $

; Data
DISK_ERROR:
    db "Disk read error!", 0

SECTORS_ERROR:
    db "Sector read mismatch!", 0
