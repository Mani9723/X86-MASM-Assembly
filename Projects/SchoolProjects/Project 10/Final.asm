INCLUDE Irvine32.inc
INCLUDE Macros.inc
.data
	heading BYTE "Please enter a string", 0ah, 0dh, 0
	userInput BYTE 100 DUP (?)
	repition DWORD ?
.code
main PROC
	mwritestring heading
	mreadstring userInput
	call crlf
	mwrite<"How many time to repeat?">
	call readint
	mov repition, eax
	call crlf
	mov eax, white +(9*16)
	call settextcolor
	call clrscr
	mov ecx, repition
	l1:
		mwriteString userInput
		call crlf
	loop l1
	exit
main endp
end main