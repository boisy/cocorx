* cassettedoctor is based on the program in Hot CoCo, June 1983, p52, by Ralph Tenny
* current code and some corrections by R.Gault


Skip	equ	$48	data location in low RAM
Count1 equ  $4B
Count2 equ  $4D


CassetteDoctor
	sta	SLOWC1
	sta	SLOWC3
	bsr	CS	clear the screen
	leax	CDMsg1-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	beq	a@
	cmpa	#'W
	beq	CDWrite
	cmpa	#'R
	lbeq	CDRead
	cmpa	#3
	bne	a@
	rts

CS	lda #$60
	lbsr	ClearScreen
	ldx	#$400	location to print
	stx	$88	tell Basic
	rts

CDMsg1	fcc	/SELECT/
	fcb	$0D
	fcc	/WRITING TEST TONE TO TAPE (W)/
	fcb	$0D
	fcc	/OR/
	fcb	$0D
	fcc	/READING TAPE FOR EVALUATION (R)/
	fcb	$0D
	fcc	/REQUEST -> /
	fcb	0

CDWrite	bsr	CS
	leax	CDMsg2-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	beq	a@
	cmpa	#3
	bne	b@
	rts
b@	orcc	#$50
	jsr	$A7CA	turn on tape motor
	ldd	#$FF7A	all ones, mid point
	stb	>$85	first value sent to tape
c@	jsr	$A82A	write to tape regA preserved
	bra	c@

CDMsg2	fcc	/INSERT TAPE INTO YOUR RECORDER/
	fcb	$0D
	fcc	/CABLE COCO TO RECORDER/
	fcb	$0D
	fcc	/SET TAPE UNIT TO RECORD/
	fcb	$0D
	fcc	/AT MID VOLUME. CCR-81 = 5/
	fcb	$0D
	fcc	/WHEN READY, HIT ANY KEY/
	fcb	$0D
	fcc	/WHEN TAPE FINISHES, HIT RESET/
	fcb	$0D,0

CDRead	lbsr	CS
	leax	CDMsg3-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	beq	a@

	orcc	#$50
	jsr	$A7CA	motor on
	bra	cdrGo

CDQuit	jsr	$A7E9	stop tape motor
	rts

cdrGo	lda	#64	ignore this many half waves
	sta	Skip	delay value
a@	ldx	#0	width counter
	lda	$FF20	cassette port
	rora		isolate the input bit
	bcs	H@
L@	leax	1,x
	lda	$FF20
	rora
	bcc	L@	keep going if no change in low signal
	stx	Count1
	bra	S@
H@	leax	1,x
	lda	$FF20
	rora
	bcs	H@
	stx	Count2
	brn	S@	balance the cycle count with L@		
S@	lda	Skip
	beq	count
	dec	Skip
	bra	a@	ignore counts until tape drive stablizes
* Calculate a delta between high and low values
count	ldd	Count1
	subd	Count2
	bmi	F@
* next two lines balance the cycle count
	nop
	brn	T@
* The following number controls the sensitivity of the test which compares
* the zero crossing times of a sine wave.
T@	cmpb	#10
	bls	a@	keep reading with small delta
	bra	CDQuit
F@	negb		2
	bra	T@	3

CDMsg3	fcc	/INSERT PRERECORDED TEST TAPE/
	fcb	$0D
	fcc	/CABLE COCO TO RECORDER/
	fcb	$0D
	fcc	/SET UNIT TO PLAY. CCR-81 = 5/
	fcb	$0D
	fcc	/WHEN READY, HIT ANY KEY/
	fcb	$0D
	fcc	/TAPE WILL STOP ON ERROR/
	fcb	$0D,0




* Data tape works best with the CoCo computer tape recorders. You can use a setting of 5 on the volume control.]
* High quality audio tape seems to require higher volume settings as high as 8 to produce good recordings.