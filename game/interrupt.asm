; ************************************************************************************************************
; ************************************************************************************************************
;
;											1861 Display Routine
;
; ************************************************************************************************************
; ************************************************************************************************************

Return:
	ldxa 																		; restore D
	ret 																		; restore X,P
Interrupt:
	dec 	r2 																	; save return XP on stack
	sav
	dec 	r2 																	; save D on stack
	str 	r2
	nop 																		; pad out cycles till rendering
	nop
	nop
	lri 	r0,display 															; draw from here
Refresh:
	glo 	r0 																	; do four scan lines for each row
	sex 	r2

	sex 	r2
	dec 	r0
	plo 	r0

	sex 	r2
	dec 	r0
	plo 	r0

	sex 	r2
	dec 	r0
	plo 	r0

	bn1 	Refresh 															; in emulator we never loop back
	br 		Return
