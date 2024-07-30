.686
.MODEL FLAT, C
.STACK
.CODE
strcopy_asm PROC
	mov edi, [esp + 4]
	mov esi, [esp + 8]
	mov ecx, [esp + 12]

	mov eax, edi
	sub eax, esi
	je exit
	cmp eax, ecx
	jge forward

	back:
		add edi, ecx
		dec edi
		add esi, ecx
		dec esi
		std

	forward:
		rep movsb
		cld

	exit:
		ret
strcopy_asm ENDP
END
