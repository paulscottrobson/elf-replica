
	include 1802.inc

display = 	0F00h																; this page has the display in it
map = 		0E00h 																; this page has the map in it.
stack = 	0DF0h 																; stack top

player = 	0DFFh 																; player offset in map
direction = 0DFEh 																; 0 = right,1 = down, 2 = left, 3 = up

	ret 																		; 1802 interrupts on. 
	nop
	lri 	r1,Interrupt 														; set interrupt vector
	lri 	r2,Stack 															; set stack address
	ldi 	Main & 255 															; switch to R3 as program pointer
	plo 	r3
	sep 	r3 																	; go to main routine
Main:
	sex 	r2 																	; turn video on
	inp		1

	call 	r4,CreateMaze
	call 	r4,ResetPlayer
Repaint:
	call 	r4,RepaintDisplay 													; clear screen and draw walls
	; Open doors

	lri 	r4,DrawPlayerViewAtDepth 
	ldi 	0
	recall 	r4
	ldi 	1
	recall 	r4
	ldi 	2
	recall 	r4
	ldi 	3
	recall 	r4
	
	call 	r4,MirrorDisplay 													; mirror top of display to bottom
	; draw princess
	; draw status.

wait:
	br 		wait

	org 	100h

code:
;
;	Block 0
;
	include interrupt.asm														; screen driver ($1E)
	include maze.asm 															; maze creator & RNG ($7B)
	include repaint.asm 														; repaint outline/mirror ($64)
;
;	Block 1
;
	org 	code+100h
	include door.asm 															; door "opening" code. ($3C)
	include player.asm 															; player reset and depth view ()
;
;	TODO: 	
;			Store the forward positions as you go drawing into the maze (for princesses)
;			Put princesses in the maze.
;			Add visual on princesses
;			Add basic control ?
