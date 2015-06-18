* Code by Robert Gault
SoundDoctor
	lda	#$60
	lbsr	ClearScreen
	ldd	#$400
	std	$88
	leax	msgS1-1,pcr
	jsr	PRINT
	jsr	$ADFB
	andcc	#$AF		The sound routine needs interrupts
	ldd	#$502
	pshs	d
a@	sta	$8C
	jsr	$A951
	lda	,s
	adda	#10
	sta	,s
	jsr	[$A000]
	bne	b@
	ldd	,s
	bra	a@
b@	orcc	#$50		We'll turn them back off
	puls	d,pc

msgS1	fcc	/PLEASE CONNECT A CABLE TO THE/
	fcb	$0D
	fcc	/AUDIO JACK AND A SOUND SYSTEM/
	fcb	$0D
	fcc	/THEN HIT ANY KEY./
	fcb	$0D
	fcc	/IF THE SYSTEM IS WORKING, YOU/
	fcb	$0D
	fcc	/WILL HEAR SOUNDS./
	fcb	$0D,0
	