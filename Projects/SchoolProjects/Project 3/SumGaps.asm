;========================;
; THIS PROGRAM WILL SUM  ;
; THE GAPS IN AN ARRAY	 ;
;========================;

INCLUDE Irvine32.inc
.data
	array DWORD 2, 4, 5, 10, 12, 15
	
	introduction BYTE "This program prints a list of numbers stored in an array", 0ah, 0dh
				 BYTE "The program then goes through the array and sums", 0ah, 0dh
				 BYTE "The differences between array values.", 0ah, 0dh, 0
	gapSum BYTE "The sum of the gaps between array values is: ", 0
	
	space BYTE " ",0
.code
main PROC

	mov edx, OFFSET introduction			; move the offset of intro to edx
	call writestring						; print the intro
		
	mov ecx, [LENGTHOF array] -1			; move length-1 to ecx (counter)
	mov esi, OFFSET array					; move the address of the first value to esi(pointer)

	mov eax, [esi]							; move to eax first value
	call writedec							; print that value
	mov al, space							; create space
	call writechar
	
	L0:
		add esi, TYPE array					; add 4 to pointer
		mov eax, [esi]						; move to eax the next value
		call writedec						; print
		mov al, space						; create space
		call writechar
	loop L0									; loop through the array
	
	mov ecx, [LENGTHOF array] -1			; move to ecx len-1 as pointer
	mov esi, OFFSET array					; move to esi pointer
	
	mov edx, [esi]							; move to edx the value at [esi]
	add esi, TYPE array						; add 4 to pointer
	mov ebx, [esi]							; move the next  value to ebx
	xchg edx, ebx							; exchange edx and ebx
	sub edx, ebx							; edx - ebx = edx
	mov eax, edx							; move the difference to eax
	
	mov ecx, [LENGTHOF array] - 2
	L1:
		add esi, TYPE array					; add 4 to pointer
		mov ebx, [esi]						; move to ebx next value
		sub esi, TYPE array					; subtract 4 from pointer
		mov edx, [esi]						; move to edx the previous value
		xchg edx, ebx						; flip ebx and edx
		sub edx, ebx						; edx = edx - ebx
		add eax, edx						; eax = edx
		add esi, TYPE array					; add 4 to pointer
	loop L1									; loop
	
	call crlf
	mov edx, OFFSET gapSum					; OFFSET of last sentence to edx
	call writestring						; print
	call writedec							; print the eax value
	call crlf

	exit
main endp
end main