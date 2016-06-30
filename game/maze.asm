


; ************************************************************************************************************
; ************************************************************************************************************
;
;							Random Number Generator - same as class LFSR in gen.py
;
;	uses RF. 
; ************************************************************************************************************
; ************************************************************************************************************

RandomNumber:
	lri 	rf,__RNHighM1+1
__RNHighM1:
	ldi 	0ACh																; get seeded value
	shr 																		; shift it right
	str 	rf 																	; write it back
	ldi 	__RNLowM1+1 														; change pointer
	plo 	rf
__RNLowM1:
	ldi 	0E1h 																; get upper seeded value
	shrc  																		; rotate it right and in
	str 	rf 																	; write it back.
	sex 	r2																	; save at TOS
	str 	r2
	bnf  	__RNNoToggle 														; if bit shifted out set

	ldi 	__RNHighM1+1														; exor the high bit with $B4
	plo 	rf
	ldn 	rf
	xri 	0B4h
	str 	rf
__RNNoToggle:
	ldn 	r2 																	; read TOS.
	shl 																		; put bit 7 into DF
	ldi 	0 																	; add 0 + (R2) + DF 
	adc 	
	return 	
	br 		RandomNumber 														; is re-entrant.
