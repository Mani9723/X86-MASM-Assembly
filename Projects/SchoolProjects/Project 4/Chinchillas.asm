INCLUDE Irvine32.inc
.data
	
	finalPopulation DWORD ?
	array DWORD 28 DUP(?)
	constant DWORD 2h
	
	introduction BYTE "This Program computes the number of Chinchillas after 14 years", 0ah,0dh			 
				 BYTE "Starting with one infant male and one infant female a litter size of 4.", 0ah,0dh
				 BYTE "Under the ideal living conditions there would be ", 0 
	intro		 BYTE " Chinchillas after 14 Years", 0
	space BYTE " ", 0
	starttime DWORD ?
.code
main PROC
	
	mov ecx, 14
	mov esi, 0

	call getmseconds
	mov starttime, eax
	call crlf
	call writeIntroduction			; write intro and do subsequent methods
	call crlf
	call getmseconds
	sub eax, starttime
	call writedec
	call crlf
	exit
main endp
;-------------------------------------------------------------------------------------
;	WRITE THE INTRODUCTION AND CALL THE OTHER METHODS
;-------------------------------------------------------------------------------------
writeIntroduction PROC
	mov edx, OFFSET introduction
	call writeString
	
	call CalculatePopulation		; calculate the population; store in array 
	call writeintro					; the last part of intro with the final population
	call printarray					; print the array -------->   call format method -------> calls makespace method
	call crlf
	call writeASCII					; writes the ascii value ------->calls makespace method

	ret
writeIntroduction endp
;--------------------------------------------------------------------------------------
;	CALCULATE POPULATION AND STORE IN ARRAY
;--------------------------------------------------------------------------------------
CalculatePopulation PROC USES esi ecx
	mov eax, 0
	
	L1:
		imul eax, constant				
		add eax, 2h						; 2(p(k-1)) + 2 = p(k)
		
		mov array[esi], eax	
		add esi, TYPE array
		
		imul eax, constant				; 2(p(k)) - 2 = p(k+1)
		sub eax, 2h
		
		mov array[esi], eax
		add esi, TYPE array
	loop L1
	
	mov finalPopulation, eax
	call writedec
	
	ret
CalculatePopulation endp
;-----------------------------------------------------------------------------------
;	PRINT THE ARRAY IN BINARY, HEX AND DECIMAL
;-----------------------------------------------------------------------------------
printarray PROC
	mov ecx, [LENGTHOF array] - 1
	mov esi, 0

	mov eax, array[esi]
	call format
	l2:
		add esi, TYPE array
		mov eax, array[esi]
		call format
	loop l2
	ret
printarray endp
;----------------------------------------------------------------------------------
;	WRITES THE ASCII CHARACTERS
;----------------------------------------------------------------------------------
writeASCII PROC
	mov ecx, [LENGTHOF array] - 1
	mov esi, 0

	mov eax, array[esi]
	call writechar
	l3:
		add esi, TYPE array
		mov eax, array[esi]
		call writechar
	loop l3
	ret
writeASCII endp
;-----------------------------------------------------------------------------------
;	FORMATS THE ARRAY
;-----------------------------------------------------------------------------------
format PROC
	call writebin
	call makespace
	
	call writehex
	call makespace
	
	call writedec
	call crlf
	ret
format endp
;-----------------------------------------------------------------------------------
;	WRITES THE SECOND PART OF INTRO
;-----------------------------------------------------------------------------------
writeintro PROC
	mov edx, OFFSET intro
	call writeString
	call crlf
	call crlf
	ret
writeintro endp
;------------------------------------------------------------------------------------
;	CREATS SPACE BETWEEN THE NUMBER FORMATS
;------------------------------------------------------------------------------------
makespace PROC
	mov al, space
	call writechar
	call writechar
	mov eax, array[esi]
	ret
makespace endp
;------------------------------------------------------------------------------------
end main