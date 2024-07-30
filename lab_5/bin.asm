PUBLIC UBIN
PUBLIC BINVAL

EXTRN DECVAL: word

DATASEG SEGMENT PARA PUBLIC 'DATA'
    BINVAL DB 16 DUP(?), '$'
    MASK2 DW 1
DATASEG ENDS

CODESEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME DS:DATASEG, CS:CODESEG

UBIN proc near
    mov ax, DECVAL
    mov bx, 15
    convert:
        mov dx, ax
        and dx, MASK2
        add dl, '0'
        mov [BINVAL + bx], dl
        sar ax, 1
        dec bx
        cmp bx, -1
        jne convert
    ret
UBIN ENDP

CODESEG ENDS
END