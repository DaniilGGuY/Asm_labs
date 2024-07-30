.186
.model tiny
.code
org 100h

main:
    jmp init
    time db 0
    is_resident db '1'
    speed db 00011111b
    back:
        db 0EAh
    prev_interrupt dd ?

resident:
    mov ah, 02h
    int 1Ah

    cmp dh, time
    mov time, dh
    je end_loop

    mov al, 0F3h
    out 60H, al
    mov al, speed
    out 60H, al

    dec speed

    test speed, 00011111b
    jnz end_loop
    mov speed, 00011111b

    end_loop:
        jmp back

init:
    mov ax, 3508h
    int 21h 

    cmp es:is_resident, '1'
    je recover

    mov word ptr prev_interrupt, bx
    mov word ptr prev_interrupt + 2, es 

    mov ax, 2508h                      
    lea dx, resident
    int 21h                 

    lea dx, init
    int 27h

recover:
    mov dx, word ptr es:prev_interrupt
    mov ds, word ptr es:prev_interrupt + 2

    mov ax, 2508h
    int 21h

    mov ah, 49h
    int 21h

    mov ax, 4C00h
    int 21h

end main