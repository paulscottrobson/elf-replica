; ************************************************************************************************************
; ************************************************************************************************************
;
;												Door opening
;
; ************************************************************************************************************
; ************************************************************************************************************

DoorOpen:
	plo 	rc 																	; save door position.
	plo 	rd 																	; ready to mask it at RD
	ani 	4 																	; 0 for left, 4 for right.
	bz 		__DOLeftMask
	ldi 	081h 																
__DOLeftMask:																	; 0 for left $81 for right	
	xri 	080h 																; now $80 for left $01 for right
	phi 	rc 																	; save in RC.H
	ldi 	Display/256  														; finish setting up RD
	phi 	rd 
	sex 	rd
__DOMask:
	ghi 	rc 																	; get mask
	and 																		; and into screen.
	str 	rd
	str 	rd
	glo 	rd 																	; next line
	adi 	8
	plo 	rd
	shl
	bnf 	__DOMask															; until done half the screen

	sex 	r2 																	; X points to stack.
	glo 	rc 																	; get door position
	ani 	4 																	; 0 if left 4 if right
	bz 		__DONotRight
	ldi 	7
__DONotRight:																	; 0 if left 7 if right
	str 	r2 																	; save at TOS.
	glo 	rc 																	; XOR with door position.
	xor 																		; so now D is distance in from edge.
	xri 	3 																	; now distance from the middle.
	shl 																		; up four positions per depth.
	shl
	bz 		__DONoAdjust 														; -1 position
	smi 	1
__DONoAdjust:
	shl 																		; multiply by 8 so index into Row
	shl	
	shl
	str 	r2 																	; save at R(X)

	glo 	rc 																	; get door position
	adi 	15*8 																; put half way down
	sm 																			; subtract offset

	plo 	rd
	ldi	 	0FFh 																; put a solid bar there.
	str 	rd
	return
	br 		DoorOpen