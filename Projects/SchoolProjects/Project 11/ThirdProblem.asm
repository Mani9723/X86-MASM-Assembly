INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	heading BYTE "The program will write user value 35 times", 0ah,0dh
			BYTE "In a rectangle of 7 rows of 5 characters",0
	userChar BYTE ?
.code
;========================================
main PROC
	call prompt
	call readAndColor
	;call print
	exit
main endp
;===========================================
prompt PROC
	mwritestring heading
	call crlf
	mwrite <"Enter a character: ">
	ret
prompt endp
;===========================================
readAndColor PROC
	call readchar
	mov userChar, al
	call crlf
	mov eax, white + (9*16)
	call settextcolor
	ret
readAndColor endp
;=============================================
print PROC
	mgotoxy 10,10
	mov al, userChar
	call writechar
	ret
print endp

end main