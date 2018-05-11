INCLUDE Irvine32.inc
.data
	intarray DWORD 1d, 2d, 3d, 4d, 5d, 6d, 7d, 8d, 9d, 10d, 11d, 12d
	asize = (($ - intarray) / 4) - 1
	
	introduction BYTE "Original array: ", 0
	newArray BYTE "     New array: ", 0

	space BYTE " ", 0
.code
main PROC 
	
	mov edx, OFFSET introduction		; move address of string to EDX
	call writestring
	
	mov ecx, [LENGTHOF intarray] - 1	; ecx = size of array
	mov esi, 0							; esi = index of the array
	mov eax, intarray[esi]				; eax = value of array at [esi]
	call Writedec						; print value
	mov al, space
	call writeChar
	
	L1:
		add esi, TYPE intarray			; adds 4 to esi b/c DWORD
		mov eax, intarray[esi]			; movs the next value in array to eax
		call Writedec
		mov al, space
		call writeChar			
		
	loop L1	
	
	;-----------------------------;
	;-------PART 2----------------;	
	;-----------------------------;
	
	call crlf
	mov edx, OFFSET newArray	; edx is set to the address of the string
	call writestring			; prints the value at the address
	
	mov ecx, [LENGTHOF intarray] - 1		; ecx is set to the size of the array 
	mov esi, 0					; esi points at the index of the array
	mov eax, intarray[esi]		; the value at the '0' index is moved to the eax
	
	add esi, TYPE intarray		; adds 4 to the pointer
	mov ebx, intarray[esi]		; moves to ebx the next value
	xchg eax, ebx				; flips the eax and ebx registers
	call Writedec				; prints the switched values
	
	mov al, space
	call writeChar
	
	mov eax, ebx				; flips the values back
	call Writedec				; prints the other value to eax
	
	mov al, space
	call writeChar
	 	
		mov ecx, [asize/2]
	L2:
		add esi, TYPE intarray	; adds 4 to the esi reister --> next value
		mov eax, intarray[esi]	; moves the next value to eax
		add esi, TYPE intarray	; adds 4 to the esi register
		mov ebx, intarray[esi]  ; moves the next value to ebx
		
		xchg eax, ebx			; flips eax and ebx
		call Writedec			; print eax value
		
		mov al, space			; creates space
		call writeChar
		
		mov eax, ebx			; flips back a
		call Writedec			; print eax
		
		mov al, space
		call writechar	
	loop L2	
	call crlf
	exit
main endp
end main