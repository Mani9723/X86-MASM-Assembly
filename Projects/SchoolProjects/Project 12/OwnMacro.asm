;=========================================================
;THIS PROGRAM CREATES NEW MACROS AND TESTS THEM
;=========================================================
mCompareIntegers MACRO ValueOne:REQ, ValueTwo:REQ
	LOCAL equal, above, below, exs
	pushad
	mov eax, valueOne
	cmp eax, valueTwo
	je equal
	jb below
		mov eax, valueOne
		call writedec
		mWrite <" is greater than the second value">
		jmp exs
	equal:
		mWrite<"They are both equal">
		jmp exs
	below:
		mov eax, valueOne
		call writedec
		mwrite<" is less than the second value">
		jmp exs
	exs:
	call crlf
	popad
endm
;===========================================================
mAddValues MACRO val1:REQ, val2:REQ
	pushad
	mov eax, val1
	add eax, val2
	call writedec
	call crlf
	popad
endm
;===========================================================
mMultiply MACRO val1:REQ, val2:REQ
	pushad
	mov eax, val1
	mov ecx, val2
	mul ecx
	call writedec
	call crlf
	popad
endm
;==========================================================
INCLUDE irvine32.inc
INCLUDE Macros.inc
.data
	valF DWORD 10
	valL DWORD 1
.code
main PROC
	mCompareIntegers valF, valL
	mCompareIntegers 43,43
	maddvalues 10,10
	mMultiply 2, 4
	exit
main endp
end main