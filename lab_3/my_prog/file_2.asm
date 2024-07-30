PUBLIC read

CSEG SEGMENT PARA PUBLIC 'CODE'
	assume CS:CSEG
read proc near
	mov ah, 8
	int 21h
	mov dl, al
	ret
read endp
CSEG ENDS
END
