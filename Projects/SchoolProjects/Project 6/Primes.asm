INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	count DWORD 1
	multiple DWORD 3
	oddarray DWORD 32500 DUP(?)
	prime DWORD 6494 DUP(?)
	string1 BYTE "			This program prints primess up to 65000",0
	time DWORD ?
.code
main PROC
	mov ecx, [LENGTHOF oddarray]-1
	mov esi, OFFSET oddarray
	mWriteString string1
	call crlf
	call getmseconds
	mov time, eax
	call fillarray
	call getmseconds
	sub eax, time
	call writedec
	call crlf	
	exit
main endp
;=========================================
fillarray PROC USES ecx esi
	mov eax, 2
	mov [esi], eax
	add esi, TYPE oddarray
	add eax, 1
	mov [esi], eax
	l1:
		add esi, TYPE oddarray
		add eax, 2
		mov [esi], eax
	loop l1
	call findprime
	ret
fillarray endp
;===========================================
findprime PROC
	mov esi, OFFSET oddarray
	mov edi, OFFSET PRIME
	mov eax, [esi]
	mov [edi], eax
	label1:
		cmp eax, 7
		je filterMultiples
		add esi, TYPE oddarray
		add edi, TYPE prime
		mov eax, [esi]
		mov [edi], eax
	jmp label1
	filterMultiples:
		mov ecx, 3
		mov multiple, ecx
		add esi, TYPE oddarray
		mov eax, [esi]
		cmp eax, 64997
		jg ex
		call eliminate
		jz filterMultiples
		add multiple, 2
				checkNext:
					mov eax, [esi]
					cmp eax, multiple
					je storePrime
						call eliminate
						jz filterMultiples
						add multiple, 2
						jnz checknext			
					StorePrime:
						add edi, TYPE prime	
						mov eax, [esi]
						mov [edi], eax
						jmp filterMultiples
	ex:
	call print
	ret
findprime endp
;============================================
eliminate PROC
	xor edx, edx
	mov eax, [esi]
	mov ecx, multiple
	div ecx
	cmp edx, 0
	ret
eliminate endp
;==============================================
print PROC
	
	mov edi, OFFSET prime
	mov ecx, [LENGTHOF prime] - 1
	mov ebx, count
	l1:
		mov eax, [edi]
		call writedec
		call space
		add edi, TYPE prime
		cmp ebx, 12
		jge newLine
		inc ebx 
	lp:
	cmp ecx, 1
	je exits
	loop l1
	newLine:
		call crlf
		sub ebx, 11
		jmp lp
	exits:
	call crlf
	ret
print endp
;==============================
space PROC
	mov al, 9
	call writechar
	ret
space endp
end main