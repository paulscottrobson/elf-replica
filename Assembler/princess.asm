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
;	Bit 6 		Set if this square has a princess on it post-move*
;	Bit 5 		Moves left (Bit 2)
;	Bit 4 		Moves left (Bit 1)
;	Bit 3 		Moves left (Bit 0)
;	Bit 2 		Current Direction (High)
;	Bit 1 		Current Direction (Low)
;	Bit 0 		set for princess.
;
;	The movement routine uses the map and the buffer, and copies the map to the buffer as it goes. 
;	Bit 6 on the original map is set when a princess has been moved there, e.g. that square will be occupied
; 	the next time round. It stops two princesses being moved onto the same square.
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

	ldi 		map/256 														; point RC to Map
	phi 		rc
	ldi 		buffer/256 														; point RD to Screen Buffer
	phi 		rd 																; we use the screen buffer as a target
	ldi 		0 																; map.
	plo 		rc
	plo 		rd

__MVScanMaze:
	ldn 		rc 																; read the map and copy to buffer
	str 		rd 																
	shl 																		; is there a princess here ?
	bz			__MVNext 														; if not, go to next square
	
	ldn 		rc 																; get princess information.
	ani 		038h 															; look at count bits.
	bz 			__MVRedirect 													; if zero work out next move.
	call 		r5,MoveOnePrincess 												; otherwise move the princess
	br 			__MVNext

__MVRedirect:
	call 		r5,PrincessAI 													; work out where to go next.
__MVNext:
	inc 		rc 																; next from/to
	inc 		rd
	glo 		rd
	bnz 		__MVScanMaze 													; do all princesses

__MVCopyBack:																	; copy buffer back to map.
	dec	 		rd
	dec 		rc
	ldn 		rd
	ani 		0BFh 															; clear the target occupied flags.
	str 		rc
	glo 		rc
	bnz 		__MVCopyBack

__MVExit:
	return

; ************************************************************************************************************
;
;			Move princess. RC points to maze entry. RE.1 is player position. RD is the output map
;
; ************************************************************************************************************

MoveOnePrincess:
	return

;
;	Move : look at the target square on the map. If it has a new princess on it, or is block, set count to 0
;		   if not, change its position. 
;		   put it on the output map and mark on old map as 'square now occupied'
;
;

PrincessAI:
	br 		PrincessAI
