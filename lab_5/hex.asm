PUBLIC UHEX
PUBLIC HEXVAL
PUBLIC SIGN

EXTRN DECVAL: word

DATASEG SEGMENT PARA PUBLIC 'DATA'
    HEXVAL DB 2 DUP(?), '$'
    MASK16 DW 15
    SIGN DB '+'
DATASEG ENDS

CODESEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME DS:DATASEG, CS:CODESEG

UHEX proc near
    mov ax, DECVAL
    xor ah, ah
    mov cl, '+'
    cmp al, 127
    jna plus
    not al
    add al, 1
    mov cl, '-'
    plus:
    mov SIGN, cl
    mov bx, 1
    convert:
        mov dx, ax
        and dx, MASK16
        cmp dl, 10
        jl digit
        add dl, 7
        digit:
        add dl, '0'
        mov [HEXVAL + bx], dl
        mov cl, 4
        sar ax, cl 
        dec bx
        cmp bx, -1
        jne convert
    ret
UHEX ENDP

CODESEG ENDS
END