PUBLIC DECVAL
PUBLIC INACTION
PUBLIC INPDEC

DATASEG SEGMENT PARA PUBLIC 'DATA'
    DECVAL DW 0
    INPDECMASG DB 'Enter unsigned decimal 16 bit value: $'
DATASEG ENDS

CODESEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME DS:DATASEG, CS:CODESEG

INACTION proc near
    mov ah, 1
    int 21H
    sub al, '0'
    mov bl, 2
    mul bl
    mov si, ax
    ret
INACTION ENDP

INPDEC proc near
    mov ah, 9
    lea dx, INPDECMASG
    int 21H
    xor bx, bx
    input:
        mov ah, 1
        int 21H
        cmp al, '0'
        jl endinp
        cmp al, '9'
        jg endinp
        xor cx, cx
        mov cl, al
        sub cl, '0'
        mov ax, 10
        mul bx
        mov bx, ax
        add bx, cx
        jmp input

    endinp:
    mov DECVAL, bx
    ret
INPDEC ENDP

CODESEG ENDS
END