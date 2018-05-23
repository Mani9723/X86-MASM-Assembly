INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	array DWORD 4 DUP(?)
	rowSize = ($ - array)
		  DWORD 4 DUP(?)
		  DWORD 4 DUP(?)
		  DWORD 4 DUP(?)
	siz WORD 4
	overhund DWORD 16 DUP(?)
	rowIndex  DWORD ?
	colIndex  DWORD ?
	sum DWORD 0
	cout DWORD 0;
	count DWORD 1
	num DWORD 0
.code
;================M A I N========================
main PROC
	mWrite <"This program manipulates a two-dimensional array">
	call crlf
	call run
	exit
main endp
;=================================================
run PROC
	mWrite<"   Enter 16 values: (0-200)">
	call crlf
	call fillarray
	call crlf
	mWrite"========================================="
	call crlf
	mWrite " Right-Justified Values in 4X4 Matrix"
	call crlf
	call print
	call crlf
		mWrite"========================================="
	call crlf
	call readR
		mov ecx, rowSize
	call sumRow
	call crlf
		mWrite"========================================="
	call crlf
	call readC
		mov ecx, rowSize
	call sumCol
	call crlf
	call readChar
		mWrite"========================================="
	call crlf
	mWrite" There are "
	push eax
	mov eax, cout
	call writedec
	mWrite" values >= 100"
	pop eax
	call crlf
	mWritespace
	call printHund
	call crlf
	call readchar
	mWrite"========================================="
	call crlf
	mWrite<" Press any key to exchange rows 1 and 3">
	call readchar
	call exchange
	mWrite"========================================="
	call crlf
	ret
run endp
;==========================================
fillarray PROC
	xor eax, eax
	mov edi, OFFSET overhund
	mov ecx, LENGTHOF array*4
	mov esi, OFFSET array
	l1:
		push eax
		mWritespace
		inc num
		mov eax, num
		call writedec
		mWrite ": "
		pop eax
		call readInt
		.IF eax > 200 || eax < 0
			mWrite "ERROR: 0 < Value <= 200"
			call crlf
			dec num
			jmp l1
		.ENDIF
		.IF eax >= 100
			call addsum
		.ENDIF
		mov [esi], eax
		add esi, TYPE array
	loop l1
	ret
fillarray endp
;==========================================
readR PROC
	mWritespace
	mWrite <"Enter a row (0-3): ">
	call readInt
	mov rowIndex, eax
	ret
readR endp
;==========================================
readC PROC
	mWritespace
	mWrite <"Enter a column (0-3): ">
	call readInt
	mov colIndex, eax
	ret
readC endp
;==============================================
print PROC
	push eax
	xor eax, eax
	mov ecx, LENGTHOF array*4
	mov esi, OFFSET array
	l1:
		mWritespace
		mov eax, [esi]
		.IF eax < 10 
			mWriteSpace
		.ENDIF
		.IF eax < 100
			mWritespace
		.ENDIF
		call writedec
		inc count
		.IF count > 4
			call crlf
			call crlf
			sub count, 4
		.ENDIF
		add esi, TYPE array
	loop l1
	pop eax
	ret
print endp
;===============================================;
exchange PROC									;
	mov edi, OFFSET array
	mov esi, OFFSET array
	mov ebx, 16
	add edi, ebx
	mov ecx, 48
	add esi, ecx
	label1:
		.IF count > 4
			jmp exs
		.ENDIF
		mov eax, [edi]
		mov ebp, [esi]
		xchg eax, ebp
		mov [edi], eax
		mov [esi], ebp
		add edi, 4
		add esi, 4
		inc count
		jmp label1										;
	exs:
		call crlf
		mov count, 1
		call print										;
	ret											;
exchange endp									;
;===============================================;
sumRow PROC USES ebx ecx esi
	mul ecx	; rowIndex*rowSize = eax*Ecx
	push eax
	mov eax, ecx
	mov edx, 0
	div siz
	mov ecx, eax
	pop eax
	mov ebx, OFFSET array
	add ebx, eax
	mov eax, 0
	mov esi, 0
	l1:
		mov edx, [ebx+esi]
		add eax, edx
		add esi, 4
	loop l1
	push eax
	mWrite "  The sum of row "
	mov eax, rowIndex
	call writedec
	mWrite " is: "
	pop eax
	call writedec
	call crlf
	ret
sumRow endp
;================================================
sumCol PROC USES ebx ecx esi
	add ecx, eax	; rowIndex*rowSize = eax*Ecx
	push eax
	mov eax, ecx
	mov edx, 0
	div siz
	mov ecx, eax
	pop eax
	mov ebx, OFFSET array
		mov eax, colIndex
		imul eax, 4
	add ebx, eax
	mov eax, 0
	mov esi, 0
	l1:
		mov edx, [ebx+esi]
		add eax, edx
		add esi, rowSize
	loop l1
	push eax
	mWrite "  The sum of column "
	mov eax, colIndex
	call writedec
	mWrite " is: "
	pop eax
	call writedec
	call crlf
	ret
sumCol endp
;=================================
addsum PROC 
	mov [edi], eax
	add edi, TYPE array
	inc cout
	ret
addsum endp
printHund PROC
	mov edi, OFFSET overhund
	mov ecx, cout
	l1:
		.IF eax == 0
			jmp exs
		.ENDIF
		mov eax, [edi]
		add edi, TYPE overhund
		call writedec
		mWritespace
	loop l1
	exs:
	ret
printHund endp
;==================================
end main
