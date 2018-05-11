INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	x SDWORD ?
	y SDWORD ?
	result SDWORD ?
	menu BYTE "    Please choose an operation", 0ah, 0dh 
		 BYTE " 1) X + Y		6) X and Y", 0ah, 0dh
		 BYTE " 2) X - Y		7) X or Y", 0ah, 0dh
		 BYTE " 3) X * Y		8) not X", 0ah, 0dh
		 BYTE " 4) X / Y		9) X xor Y", 0ah, 0dh
		 BYTE " 5) X mod Y             10) Exit", 0	

	addIntro  BYTE " Please Enter two integers to add",0
	subIntro  BYTE " Please Enter two integers to subtract",0
	multIntro BYTE " Please Enter two integers to multiply",0
	divIntro  BYTE " Please Enter two integers to divide",0
	modIntro  BYTE " Please Enter two integers to mod",0
	andIntro  BYTE " Please Enter two integers to AND",0
	orIntro   BYTE " Please Enter two integers to OR",0
	notIntro  BYTE " Please Enter an integer to NOT",0
	xorIntro  BYTE " Please Enter two integers to XOR",0

	answer BYTE " Answer: ", 0

	error BYTE " Invalid Input. Program Exits", 0

	prog BYTE " Program Ended", 0

.code
main PROC
	introLabel: 
		mWriteString menu
		cmp eax, 10
		jg l11				; Invalid Input End Program
		cmp eax, 1
		je addition				; call addition
		cmp eax, 2
		je subtraction			; call subtraction
		cmp eax, 3
		je multiply				; call multiplication
		cmp eax, 4
		je l4				; call division
		cmp eax, 5
		je l5				; call modulus
		cmp eax, 6
		je l6				; call AND
		cmp eax, 7
		je l7				; call OR
		cmp eax, 8
		je l8				; call NOT
		cmp eax, 9
		je l9				; call XOR
		cmp eax, 10
		je l10				; End Program

		;l1:
		;	call addition
		;	jmp introLabel
		l2:
			call subtraction
			jmp introLabel
		l3:
			call multiply
			jmp introLabel
		l4:
			call intro4
			call divide
			call print
			jmp introLabel
		l5:
			call modulus
			jmp introLabel
		l6:
			call AndOperation
			jmp introLabel
		l7:
			Call OrOperation
			jmp introLabel
		l8: 
			call NotOperation
			jmp introLabel
		l9:
			call XorOperation
			jmp introLabel
		l11:
			mov edx, OFFSET error
			call writestring
			call crlf
			jmp l10
l10:
	call exitProg
	exit
main endp
;-----------------------------------------------
; INTRODUCTION AND OPTIONS
;-----------------------------------------------
intro PROC
	mov edx, OFFSET menu
	call writestring
	call crlf
	call crlf
	call readdec
	ret
intro endp
;--------------------------------------
;	EXITS PROGRAM
;-------------------------------------
exitprog PROC
	mov edx, OFFSET Prog
	call writestring
	call crlf
	ret
exitprog endp
;----------------------------------------
;	READS USER INPUT FOR X AND Y
;------------------------------------------
readInput PROC
	call readdec
	mov x, eax
	mov ebx, x
	call readdec
	mov y, eax
	ret
readInput endp
;-----------------------------------------------
;	PRINTS THE ANSER
;-----------------------------------------------
print PROC
	mov edx, OFFSET answer
	call writestring
	call writedec
	call crlf
	call crlf
 ret
print endp
;-----------------------------------------------
;	PRINTS THE SIGNED ANSWER
;-----------------------------------------------
printInt PROC
	mov edx, OFFSET answer
	call writestring
	call writeint
	call crlf
	call crlf
 ret
printInt endp
;-----------------------------------------------
;	CHECK SIGNED
;-----------------------------------------------
sign PROC
	cmp eax, 0
	js l1
	call print
	jmp l2
	l1:
		call printint
	l2:
	ret
 ret
sign endp
;-----------------------------------------------
; OPTION 1: X+Y
;------------------------------------------------
addition PROC
	call intro1
	call readInput
	add eax, ebx
	mov result, eax
	call print
	ret
addition endp
;-------------------------------
; OPTION 2: SUBTRACTION X-Y
;-------------------------------
subtraction PROC
	call intro2
	call readInput
	sub ebx, eax
	xchg eax, ebx
	mov result, eax
	call sign
	ret
subtraction endp
;-------------------------------
;OPTION 3: MULTIPLICATION X*Y
;------------------------------
multiply PROC
	call intro3
	call readInput
	imul eax, ebx
	mov result, eax
	call print
	ret
multiply endp
;-------------------------------------------
;OPTION 4: DIVIDE X/Y
;--------------------------------------------
divide PROC
	mov edx, 0
	call readdec
	mov x, eax
	call readdec
	mov y, eax
	mov eax, x
	mov ecx, y
	div ecx
	call crlf
	ret
divide endp
;----------------------------
;	OPTION 5: MODULUS X % Y
;----------------------------
modulus PROC
	call intro5
	call divide
	mov eax, edx
	call print
	ret
modulus endp
;--------------------------------
;	OPTION 6: AND OPERATION
;-----------------------------
AndOperation PROC
	call intro6
	call readdec
	mov x, eax
	call readdec
	mov y, eax
	and eax, x
	call print
	ret
AndOperation endp
;--------------------------------
;	OPTION 7: OR OPERATION
;-----------------------------
OrOperation PROC
	call intro7
	call readdec
	mov x, eax
	call readdec
	mov y, eax
	or eax, x
	call print
	ret
OrOperation endp
;--------------------------------
;	OPTION 8: NOT OPERATION
;-----------------------------
NotOperation PROC
	call intro8
	call readdec
	not eax
	mov edx, OFFSET answer
	call writestring
	call writeint
	call crlf
	call crlf
	ret
NotOperation endp
;--------------------------------
;	OPTION 9: XOR OPERATION
;-----------------------------
XorOperation PROC
	call intro9
	call readdec
	mov x, eax
	call readdec
	mov y, eax
	xor eax, x
	call print
	ret
XorOperation endp
;-------------------------------
;	ADD INTRO
;-------------------------------
intro1 PROC
	call crlf
	mov edx, OFFSET addIntro
	call writestring
	call crlf
	ret
intro1 endp
;---------------------------------------
intro2 PROC
	call crlf
	mov edx, OFFSET subIntro
	call writestring
	call crlf
	ret
intro2 endp
;------------------------------------------
intro3 PROC
	call crlf
	mov edx, OFFSET multIntro
	call writestring
	call crlf
	ret
intro3 endp
;--------------------------------
;------------------------------------------
intro4 PROC
	call crlf
	mov edx, OFFSET divIntro
	call writestring
	call crlf
	ret
intro4 endp
;--------------------------------
;------------------------------------------
intro5 PROC
	call crlf
	mov edx, OFFSET modIntro
	call writestring
	call crlf
	ret
intro5 endp
;--------------------------------
;------------------------------------------
intro6 PROC
	call crlf
	mov edx, OFFSET andIntro
	call writestring
	call crlf
	ret
intro6 endp
;--------------------------------
;------------------------------------------
intro7 PROC
	call crlf
	mov edx, OFFSET orIntro
	call writestring
	call crlf
	ret
intro7 endp
;--------------------------------
;------------------------------------------
intro8 PROC
	call crlf
	mov edx, OFFSET notIntro
	call writestring
	call crlf
	ret
intro8 endp
;--------------------------------
;------------------------------------------
intro9 PROC
	call crlf
	mov edx, OFFSET xorIntro
	call writestring
	call crlf
	ret
intro9 endp
;--------------------------------
end main