; Enter kernel code
[bits 32]
[extern main]
    call main

    cli
    hlt
    jmp $