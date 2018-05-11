INCLUDE Irvine32.inc
.data
	array DWORD 10, 20, 30, 40, 50, 60, 70, 80, 90, 100

	introduction BYTE "ORIGINIAL ARRAY: ", 0
	NewArray BYTE "REVERSED  ARRAY: " ,0

	space BYTE " ", 0     
.code
main PROC 
	mov edx, OFFSET introduction		; The OFFSET of intro is moved to edx
	call writestring					; print the edx register
		
	mov ecx, [LENGTHOF array] - 1		; initialize the the loop counter
	mov esi, OFFSET array				; move to esi the address of the firt value
	mov eax, [esi]						; move to eax the value at [esi]
	call writedec
	mov al, space						; print the value
	call writechar						
	
	L1:
		add esi, TYPE array				; the to esi the type of value of array (4)
		mov eax, [esi]					; mov to eax the value at that address
		call writedec					;  print, decrement ecx and loop again
		mov al, space					
		call writechar
	loop L1
	
	call crlf
	mov edx, OFFSET NewArray			; move to edx the OFFSET of newArray
	call writestring					; print the newArray

	mov ecx, [LENGTHOF array] - 1		; initialize the second loop counter
	mov eax, [esi]						; move to eax the value at the OFFSET [esi]
	call writedec						; print
	mov al, space
	call writechar
	
	L2:
		sub esi, TYPE array				; subtract 4 from the last OFFSET of the array
		mov eax, [esi]					; mov to eax the value at [esi]
		call writedec					; print decrement to the begining of the array/loop
		mov al, space
		call writechar
	loop L2	
	call crlf
	exit
main endp
end main