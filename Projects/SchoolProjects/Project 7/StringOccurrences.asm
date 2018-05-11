INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	strg BYTE 200 DUP(0)
	strg2 BYTE 200 DUP(0)
	new BYTE 200 DUP(0)
	count DWORD 0
	ediCounter DWORD 0
.code
;========== M A I N =============;
main PROC
	call read
		mov edx, OFFSET strg
		mov edi, OFFSET strg2
		mov esi, OFFSET new
	call compares
	exit
main endp
;=============================;
read PROC
	mWrite <"	This Program finds embedded strings">
	call crlf
	mWriteSpace
	mWrite "Please Enter String 1: "
	call crlf
	mWriteSpace
	mReadString strg
	call crlf
	mWriteSpace
	mWrite "Please Enter String 2: "
	call crlf
	mWriteSpace
	mReadString strg2
	call crlf
	ret
read endp
;========================================
compares PROC USES edx edi esi
start:
	.IF al == 0
		jmp exs
	.ENDIF
	mov al, [edx]
	mov bl, [edi]
	cmpVals:
		.IF al == 0
			 jmp exs
		 .ENDIF
		.IF al != bl
			mov al, [edx]
			jmp store
		.ENDIF
		equal:
			.IF al == bl
				inc ediCounter
				mov al, [edx]
				mov bl, [edi]
				inc edi
				jmp checkZero
			
			checkNext:
				inc edx
				mov al, [edx]
				jmp cmpVals				
		.ENDIF
		store:
			.IF al != bl
				mov edi, OFFSET strg2
				mov bl, [edi]
				.IF ediCounter == 0
					inc ediCounter
					mov ecx, ediCounter
					dec ediCounter
					call storeChar
					jmp nxt
				.ENDIF
				.IF ediCounter == 1
					sub edx, ediCounter
					mov ecx, ediCounter
					jmp loops
				.ENDIF
				dec ediCounter
				sub edx, ediCounter
				inc ediCounter
				mov ecx, ediCounter
				loops:
					l1:
						mov al, [edx]
						mov [esi], al
						inc esi
						inc edx
					loop l1
				nxt:
					mov ediCounter, 0
					mov al, [edx]
					.IF al == 0
						jmp exs
					.ENDIF
					jmp cmpVals 
			.ENDIF
checkZero:
	mov bl, [edi]
	.IF bl == 0
		mov ediCounter, 0
		inc count
		mov edi, OFFSET strg2
		jmp reset
		jmp start
		reset:
			mov al, [edx]
			mov bl, [edi]
			.IF al != bl
				inc edx
				jmp start
			.ENDIF
			.IF al == bl
				jmp start
			.ENDIF
	.ENDIF
	jmp checkNext
exs:
	call lastLine
	ret
compares endp
;==============================================
storeChar PROC
	mov al, [edx]
	mov [esi], al
	inc esi
	inc edx
	ret
storeChar endp
;================================================
lastLine PROC
	call crlf
	mWriteSpace
	mWrite "There are(is) "
	mov eax, count
	call writedec
	mWrite " occurence(s) of the string '"
	mWriteString strg2
	mWrite "' in the string: "
	call crlf
	mWriteSpace
	mWrite "'"
	mWriteString strg
	mWrite "'"
	call crlf
	call crlf
	mWriteSpace
	mWrite " String 1 with occurrences of string 2 removed is: "
	call crlf
	mWriteSpace
	mWrite "'"
	mWriteString new
	mWrite "'"
	call crlf
	ret
lastLine endp
end main