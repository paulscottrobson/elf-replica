; ************************************************************************************************************
; ************************************************************************************************************
;
;										Princess Movement
;
; ************************************************************************************************************
; ************************************************************************************************************

;	Maze
;
;	Bit 7 		set for solid wall
;	Bit 6 		Unused
;	Bit 5 		Moves left (Bit 2)
;	Bit 4 		Moves left (Bit 1)
;	Bit 3 		Moves left (Bit 0)
;	Bit 2 		Current Direction (High)
;	Bit 1 		Current Direction (Low)
;	Bit 0 		Set for princess.
;
; ************************************************************************************************************
;
;						Check if move time and if so move all princesses
;
; ************************************************************************************************************

MovePrincesses:
	lri 		rf,speed 														; read the princess speed into RE.0
	ldn 		rf
	plo 		re
	ldi 		(player & 255)													; read player position into RE.1
	plo 		rf
	ldn 		rf
	phi 		re
	ldi 		(prinTimer & 255)												; point RF to the princess timer
	plo 		rf
	ldn 		rf
	bnz			__MVExit 														; if non-zero don't move princesses
	glo 		re 																; reset the princess timer
	str 		rf

	ldi 		map/256 														; RC points to map, RD to buffer
	phi 		rc
	ldi 		buffer/256
	phi 		rd
	ldi 		0
	plo 		rc
	plo 		rd
__MVCopyBuffer:																	; copy map to buffer.
	ldn 		rc
	str 		rd
	inc 		rc
	inc 		rd
	glo 		rc
	bnz 		__MVCopyBuffer

__MVSearchPrincesses: 															; now work backwards looking for princesses
	dec 		rc
	dec 		rd
	ldn 		rd  															; look at the map copy in the buffer.
	shl 																		; lose bit 7
	bz   		__MVNoPrincess 													; if not found , skip to next

	ldn 		rd 																; get the princess data
	ani 		00111000b 														; isolate the move count bits
	bz 			__MVNewDirection 												; if zero, we want a new direction
	call 		r5,MoveOnePrincess												; if not, move princess
	br 			__MVNoPrincess
__MVNewDirection:
	call 		r5,PrincessAI 													; find a new direction	
__MVNoPrincess:
	glo 		rc
	bnz 		__MVSearchPrincesses

__MVExit:
	return

; ************************************************************************************************************
;
;			Move princess. RC points to target map. RE.1 is player position. RC.1 is princess position
;
; ************************************************************************************************************

MoveOnePrincess:
__MOExit:
	return

PrincessAI:
	br 		PrincessAI
__PAExit:
	return
	