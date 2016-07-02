; ************************************************************************************************************
; ************************************************************************************************************
;
;													Death Effect
;
; ************************************************************************************************************
; ************************************************************************************************************

DeathEffect:
	lri 	r6,RandomNumber 													; erase screen randomly.
	ldi 	00Dh 																; do it roughly 13 x 256 times.
	phi 	r7
Die:
	lri 	re,screen+128 														; set up RE, handle problem that
	ldi 	0 																	; $80 is never produced by the simple
	str 	re 																	; RNG
	recall 	r6 	 																; pick random square
	plo 	re
	recall 	r6 																	; pick random mask
	sex 	r2
	str 	r2
	ldn 	re 																	; get screen, shift, mask, write
	shlc
	and
	str 	re
	dec 	r7 																	; dec counter, loop back if not done
	ghi 	r7
	bnz 	Die
	return
