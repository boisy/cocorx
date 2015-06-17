* Code by Robert Gault
* The values of the two joysticks are stored at $15A-$15D
JoystickDoctor
	lda	#$60
	lbsr	ClearScreen
	ldd	#$400
	std	$88
	leax	msgjy-1,pcr
	jsr	PRINT
l@	clrb
	jsr	[$A00A]	Tell Basic to read the joysticks
	ldy	#$15A
a@	ldb	,y+
	cmpb	#10
	bhs	b@
	lda	#$60
	sta	[$88]
	inc	$89
b@	clra
	jsr	NUMBR
	ldd	$88
	addd	#4
	std	$88
	cmpy	#$15E
	bne	a@
	ldd	#$440
	std	$88
	jsr	[$A000]      Keystroke?
	beq	l@
	rts
msgjy fcc   /HERE ARE THE JOYSTICK VALUES/
      fcb   $0D
      fcc   /rX    rY    lX    lY/
      fcb   $0D,0
blank fcc   / /
