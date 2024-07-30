PUBLIC NEWLINE
PUBLIC OUTBIN
PUBLIC OUTHEX

EXTRN UBIN: near
EXTRN BINVAL: byte
EXTRN UHEX: near
EXTRN HEXVAL: byte
EXTRN SIGN: byte
EXTRN POWCALC: near
EXTRN DEGREE: word

DATASEG SEGMENT PARA PUBLIC 'DATA'
    OUTBINMSG DB 'Unsigned bin value: $'
    OUTHEXMSG DB 'Signed hex value: $'
    OUTDEGREEMSG DB 'Calculated degree: $'
DATASEG ENDS

CODESEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME CS:CODESEG

NEWLINE proc near
    mov AH, 2
    mov DL, 10
    int 21H
    mov DL, 13
    int 21H
    ret
NEWLINE ENDP

OUTBIN proc near
    call NEWLINE
    mov ah, 9
    lea dx, OUTBINMSG
    int 21H
    call UBIN
    mov ah, 9
    lea dx, BINVAL
    int 21H
    call NEWLINE
    ret
OUTBIN ENDP

OUTHEX proc near
    call NEWLINE
    mov ah, 9
    lea dx, OUTHEXMSG
    int 21H
    call UHEX
    mov ah, 2
    mov dl, SIGN
    int 21H
    mov ah, 9
    lea dx, HEXVAL
    int 21H
    call NEWLINE
    ret
OUTHEX ENDP

OUTTASK proc near
    mov ah, 9
    lea dx, OUTDEGREEMSG
    int 21H
    call POWCALC
    mov ah, 2
    xor bx, bx
    mov bx, DEGREE
    cmp bx, 10
    jl tenlower
    mov dl, '1'
    int 21H
    sub bl, 10
    tenlower:
    add bl, '0'
    mov dl, bl
    int 21H
    ret
OUTTASK ENDP

CODESEG ENDS
END