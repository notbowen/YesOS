; GDT
gdt_start:

gdt_null:  ; null descriptor
    dd 0x0
    dd 0x0

gdt_code:  ; Code segment descriptor
    dw 0xffff      ; Limit
    dw 0x0         ; Base
    db 0x0         ; Base
    db 10011010b   ; 1st Flags, Type Flags
    db 11001111b   ; 2nd Flags, Limit
    db 0x0         ; Base

gdt_data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:

; GDT Descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

; Define Constants
CODE_SEG equ gdt_code - gdt_start 
DATA_SEG equ gdt_data - gdt_start
