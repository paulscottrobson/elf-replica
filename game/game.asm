
	include 1802.inc

display = 	0F00h																; this page has the display in it
map = 		0E00h 																; this page has the map in it.
stack = 	0DFFh 																; stack top

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

Repaint:
	call 	r4,RepaintDisplay 													; clear screen and draw walls
	; Open doors
	call 	r4,MirrorDisplay 													; mirror top of display to bottom
	; draw princess
	; draw status.

	inc 	r8
	br 		Repaint

wait:
	br 		wait

	org 	100h
	include interrupt.asm														; screen driver
	include repaint.asm 														; repaint outline and mirror code
	include maze.asm 															; maze creator.

	