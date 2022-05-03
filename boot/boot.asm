; Boot sector that enters 32-bit PM
[org 0x7c00]
    KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl

    mov bp, 0x9000   ; Set stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call load_kernel
    call switch_to_pm
    jmp $

%include "boot/print_string.asm"
%include "boot/hex.asm"
%include "boot/disk.asm"
%include "boot/32_bit_gdt.asm"
%include "boot/32_bit_print.asm"
%include "boot/switch_to_pm.asm"

; Load Kernel
[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET
    mov dh, 15
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret

; Enter PM
[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    call KERNEL_OFFSET

    jmp $

; Variables
BOOT_DRIVE      db 0
MSG_LOAD_KERNEL db "Loading kernel into memory...", 0
MSG_REAL_MODE   db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE   db "Successfully landed in 32-bit Protected Mode", 0

; Padding
times 510 - ($-$$) db 0
dw 0xaa55
