EXTRN INACTION: near
EXTRN INPDEC: near
EXTRN NEWLINE: near
EXTRN OUTBIN: near
EXTRN OUTHEX: near
EXTRN OUTTASK: near

STACKSEG SEGMENT PARA STACK 'STACK'
    DB 200H DUP(0)
STACKSEG ENDS

DATASEG SEGMENT PARA PUBLIC 'DATA'
    MENU DB 'Menu:', 13, 10
        DB '1. Input unsigned decimal number', 13, 10
        DB '2. Output unsigned bin', 13, 10
        DB '3. Output signed hex', 13, 10
        DB '4. Task first variant', 13, 10
        DB '0. Finish program.', 13, 10
        DB 'Choose action: $'
    ACTIONS DW EXIT, INPDEC, OUTBIN, OUTHEX, OUTTASK
DATASEG ENDS

CODESEG SEGMENT PARA PUBLIC 'CODE'
    ASSUME SS:STACKSEG, DS:DATASEG, CS:CODESEG

OUTMENU proc near
    mov ah, 9
    lea dx, MENU
    int 21H
    ret
OUTMENU ENDP

EXIT proc near
    mov ah, 4CH
    int 21H
    ret
EXIT ENDP

main:
    mov ax, DATASEG
    mov ds, ax

    process:
        call OUTMENU
        call INACTION
        call NEWLINE
        call ACTIONS[si]
        call NEWLINE
        jmp process
CODESEG ENDS
END main