;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------

			.data
			.retain
			.retainrefs
LENGTH:				.set	1024
LENGTH_ARRAY:		.set	2044

p_array:	.space 2046
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer



;-------------------------------------------------------------------------------
; Main Loop here
;-------------------------------------------------------------------------------
		; Equations
		; R8 = R5 + R5 + R4 = First       location of non prime in array
		; R8 = R5 + R5       = The rest of location of non prime in array

		;Initialize:
			clr.w	R8					; R8  = The position of array that is non prime
	        mov.w	#1,				R4	; R4  = Position in array that tells program how many numbers to skip over before cross out
	        mov.w	#LENGTH_ARRAY,	R6	; R6  = Array Length (0 -> 1024*2)
	        mov.w	#-2,			R5	; R5  = The number in Array adhering to R4 where R5 = R4/2 +2
	        mov.w	#-2, R13			; R7  = Stored array position eqauling zero
	        call	#Load				; Load data into array

Cross_Out:
		cmp.w	#LENGTH, R4			; R4 = 1024
		jeq		Loop
		incd.w	R4 					; Pointer for Array
		clr.w	R8
		tst.w	p_array(R4)
		jz		Cross_Out			; If array value is 0, look at next array position location
		mov.w	p_array(R4), R5		; R5 = Value in array

		add.w	R5,	 R8

		add.w	R5,	 R8			 	; R8 = R5 + R5 + R4 = first array position that stores first non prime
		add.w	R4,	 R8
	    mov.w	#0, p_array(R8)

		call 	#Increment 			; Loop that crosses out the rest of non primes


		cmp.w	#LENGTH, R4			; Check if R4 has reached 1024 -> p_array(R4) = 512 which is half of the length
		jne		Cross_Out

		jmp		Loop				; Exit

Increment:
		add.w	R5, R8				; R8 = 2 * R5 = the remaining array positions that store non primes
		add.w	R5, R8				;

		cmp.w	R8,	R6				; If R8 is greater than length of the array (R6) then Return
		jlo		Return				;

		mov.w	#0, p_array(R8)

		cmp.w	R8,R6				; Increment as long as R8 is not equal to R6
		jne		Increment
		ret

Return:
			ret
Load:
		inc.w	R4					; Increment from 2 - 1024
		incd.w	R5					; Pointer Incrementing through array
		mov.w 	R4,		p_array(R5)
		cmp.w	R6,	R5				; Stop when array pointer is equal to LENGTH_ARRAY = 2044
		jne		Load

		mov.w	#-2, R4
		clr.w	R5

		ret

FindZero:
		incd.w	R4                  ; Find the location of zeros
		mov.w	R4, R13
		cmp.w	#0,	p_array(R4)
		jne 	FindZero

		ret

FindPrime:
		incd.w	R4                  ; Find location of Pirme number
		cmp.w	#LENGTH_ARRAY, R4
		jeq		Escape

		cmp.w	#0,	p_array(R4)
		jeq 	FindPrime

		ret

Loop:
		mov.w	R13, R4
		call	#FindZero
		call	#FindPrime
		mov.w	p_array(R4), p_array(R13)       ; Replace empty zeros with prime numbers to form the list
		clr.w	p_array(R4)

		cmp.w	#LENGTH_ARRAY, R4
		jne 	Loop

Escape:
		nop

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
