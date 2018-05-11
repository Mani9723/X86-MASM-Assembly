INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	introduction BYTE 100 DUP(?)
	newstrs BYTE 100 DUP(?)
	startRow BYTE 0
	startCol BYTE 0
	row BYTE ?
	col BYTE ?
.code
;========================================
main PROC
	call screensaver
	exit
main endp
;========================================
readInput PROC
	mwrite <"			Enter a string">
	call crlf
	mreadstring introduction
	call readkey
	pushad
	cld
	mov ecx, LENGTHOF introduction
	mov esi, OFFSET introduction
	mov edi, OFFSET newstrs
	rep movsb

	popad
	call clrscr
	ret
readInput endp
;========================================
screensaver PROC
	call readInput
	mov eax, white + (9 *16)
	call settextcolor
	mov eax, 25
	call delay
	mwritestring newstrs

	pushad
	mov eax, 0
	call delay
	call clrscr
	popad
	
	mov dh,startRow
	mov dl, startCol
	l1:
		add dl, 1
		call gotoxy
		.IF dl >= 103
			inc dh
			mov dl, 0
		.ENDIF
		.IF dh == 27
			mov dh, 0
			mov dl, 0
		.ENDIF
		mwritestring newstrs
		pushad
		mov eax, 100
		call delay
		call clrscr
		popad
	jmp l1
ret
screensaver endp
;==============================================
end main