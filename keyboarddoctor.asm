
* Code by Robert Gault
* bits 0-7
* bit-5 controls upper/lower case in ASCII 1=lower
* bit-6 controls normal/inverse on screen  1=inverse
KeyboardDoctor lda #$60
	lbsr	ClearScreen
	ldx	#$400
	stx	$88
	ldx	$FFFE
	cmpx	#$8C1B
	beq	c3ky
	leax	KyCC1a-1,pcr
	jsr	PRINT
	lda	#$62
	sta	[$88]
	inc	$89
	leax	KyCC1b-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	beq	a@
d@	cmpa	#3
	beq	c@
	sta	$44
	ldx	#$5AC
	stx	$88
	ldy	#$6060
	sty	$5AC
	sty	$5AD
	clrb
	exg	a,b
	jsr	NUMBR
	lda	$44
	leax	MxCC1,pcr
e@	cmpa	1,x
	beq	f@
	leax	4,x
	cmpx	#EndMx1
	bne	e@
	bra	b@
f@	bsr	flip
b@	jsr	[$A000]
	beq	b@
	cmpa	$44
	beq	b@
	bsr	flip
	bra	d@
c@	rts

flip	ldb	[2,x]
	eorb	#$40
	stb	[2,x]
	rts

c3ky	leax	KyCC3a-1,pcr
	jsr	PRINT
	lda	#$62
	sta	[$88]
	inc	$89
	leax	KyCC3b-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	beq	a@
d@	cmpa	#3
	beq	c@
* Add conversion for lower case
	sta	$44
	ldx	#$5AC
	stx	$88
	ldy	#$6060
	sty	$5AC
	sty	$5AD
	clrb
	exg	a,b
	jsr	NUMBR
	lda	$44
	cmpa	#$40
	bne	g@
	ldb	$155
	cmpb	#$BF
	bne	g@
	tfr	b,a
g@	leax	MxCC3,pcr
e@	cmpa	1,x
	beq	f@
	leax	4,x
	cmpx	#EndMx3
	bne	e@
	bra	b@
f@	bsr	flip
b@	jsr	[$A000]
	beq	b@
	cmpa	$44
	beq	b@
* Add conversion for lower case
	bsr	flip
	bra	d@
c@	rts
	rts

KyCC3a	fcc	/  ! /
	fcb	0

KyCC3b	fcc	/ # $ % & ' ( )   * =/
	fcb	$0D
	fcc	/  1 2 3 4 5 6 7 8 9 0 : - BRK/
	fcb	$0D,$0D
	fcc	/AL Q W E R T Y U I O P @ CLR UP/
	fcb	$0D
	fcc	/CT A S D F G H J K L ;+ EN <- ->/
	fcb	$0D,$0D
	fcc	/                   < > ?/
	fcb	$0D
	fcc	" SHF Z X C V B N M , . / SHF DN"
	fcb	$0D
	fcc	/         SPACEBAR      F1 F2/
	fcb	$0D,$0D,$0D
	fcc	/       DECI KEY VALUE/
	fcb	$0D,0


KyCC1a	fcc	/  ! /
	fcb	0

KyCC1b	fcc	/ # $ % & ' ( )   * =/
	fcb	$0D
	fcc	/  1 2 3 4 5 6 7 8 9 0 : - BRK/
	fcb	$0D,$0D
	fcc	/UP Q W E R T Y U I O P @ <- ->/
	fcb	$0D
	fcc	/DWN A S D F G H J K L ;+ ENT CLR/
	fcb	$0D,$0D
	fcc	/                   < > ?/
	fcb	$0D
	fcc	" SHF Z X C V B N M , . / SHF"
	fcb	$0D
	fcc	/         SPACEBAR/
	fcb	$0D,$0D,$0D
	fcc	/       DECI KEY VALUE/
	fcb	$0D,0
MxCC1	fdb	'!,$402,'",$404,'#,$406,'$,$408,'%,$40A,'&,$40C,'',$40E,'(,$410,'),$412,'*,$416,'=,$418
	fdb	'1,$422,'2,$424,'3,$426,'4,$428,'5,$42A,'6,$42C,'7,$42E,'8,$430,'9,$432,'0,$434,':,$436,'-,$438
	fdb	$5E,$460,'Q,$463,'W,$465,'E,$467,'R,$469,'T,$46B,'Y,$46D,'U,$46F,'I,$471,'O,$473,'P,$475,'@,$477
	fdb	$5F,$460,8,$479,$15,$479,9,$47D,$5D,$47D
	fdb	$0A,$480,'A,$484,'S,$486,'D,$488,'F,$48A,'G,$48C,'H,$48E,'J,$490,'K,$492,'L,$494,';,$496,'+,$497,$0D,$499,$0C,$49D
	fdb	$5B,$480,$5C,$49C
	fdb	'<,$4F3,'>,$4F5,'?,$4F7
	fdb	'Z,$505,'X,$507,'C,$509,'V,$50B,'B,$50D,'N,$50F,'M,$511,',,$513,'.,$515,'/,$517
	fdb	$20,$529
EndMx3	equ	*

MxCC3	fdb	'!,$402,'",$404,'#,$406,'$,$408,'%,$40A,'&,$40C,'',$40E,'(,$410,'),$412,'*,$416,'=,$418
	fdb	'1,$422,'2,$424,'3,$426,'4,$428,'5,$42A,'6,$42C,'7,$42E,'8,$430,'9,$432,'0,$434,':,$436,'-,$438
	fdb	$5E,$47D,'Q,$463,'W,$465,'E,$467,'R,$469,'T,$46B,'Y,$46D,'U,$46F,'I,$471,'O,$473,'P,$475,'@,$477
	fdb	$5F,$47D,8,$49B,$15,$49B,9,$49F,$5D,$49F
	fdb	$0A,$51D,'A,$483,'S,$485,'D,$487,'F,$489,'G,$48B,'H,$48D,'J,$48F,'K,$491,'L,$493,';,$495,'+,$496,$0D,$498,$0C,$479
	fdb	$5B,$51D,$5C,$49C
	fdb	'<,$4F3,'>,$4F5,'?,$4F7
	fdb	'Z,$505,'X,$507,'C,$509,'V,$50B,'B,$50D,'N,$50F,'M,$511,',,$513,'.,$515,'/,$517
	fdb	$20,$529,189,$480,$BF,$460,64,$460,103,$537,4,$53A
EndMx1	equ	*
