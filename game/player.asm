; ************************************************************************************************************
; ************************************************************************************************************
;
;												Reset the Player
;
;	use RF.
; ************************************************************************************************************
; ************************************************************************************************************

ResetPlayer:
	lri 	rf,Player 															; initialise pointer, use RF as index
	sex 	rf
	ldi 	7*16+7 																; player at (7,7)
	stxd
	ldi 	2 																	; direction 2 
	stxd

	return

; ************************************************************************************************************
; ************************************************************************************************************
;
;						Get Player Position as a result of a move in current direction +/- n
;
;	use RE,RF
; ************************************************************************************************************
; ************************************************************************************************************

GetPlayerNextCurrent:
	ldi 	1 																	; set offset to 0
GetPlayerNextOffset:
	sex 	r2
	str 	r2
	lri 	rf,Direction 														; load player direction.
	ldn 	rf
	add 	 																	; get into D + offset
	ani 	3 																	; force into a position.
	adi 	PlayerDirectionTable & 255 											; get an address in the table
	plo 	re 																	; point RE to that value.
	ldi 	PlayerDirectionTable / 256
	phi 	re
	lri 	rf,Player 															; point RF to the position.
	sex 	re 																	; R(X) points to the direction table
	ldn 	rf 																	; read position
	add 																		; add direction and exit.
	return
	br 		GetPlayerNextOffset 												; re-entrant into next offset.

PlayerDirectionTable:
	db 		1,16,-1,-16 														; direction -> offset table.

	