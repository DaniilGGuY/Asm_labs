EXTRN read: near

STK SEGMENT PARA STACK 'STACK'
	db 100 dup(0)
STK ENDS

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG, SS:STK
main:
	call read

	mov ah, 2
	int 21h	
	
	mov ax, 4c00h
	int 21h
CSEG ENDS
END main