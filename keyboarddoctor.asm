
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
	lbeq	c3ky
	leax	KyCC1-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	bne	d@
	lda	#$7F
	sta	$FF02
	lda	$FF00
	anda	#%01000000
	bne	a@
	clra
d@	cmpa	#3
	beq	c@
	sta	$44
	ldx	#$400+8*32+13		*$5AC
	stx	$88
	ldy	#$6060
	sty	$400+8*32+13
	sty	$400+8*32+14
	clrb
	exg	a,b
	jsr	NUMBR
	lda	$44
	leax	KyCC1b,pcr
	leay	MxCC1,pcr
e@	cmpa	,x+
	beq	f@
	leay	2,y
	cmpy	#EndMx1
	bne	e@
	bra	b@
f@	bsr	flip
b@	jsr	[$A000]
	bne	g@
	lda	#$7F
	sta	$FF02
	lda	$FF00
	anda	#%01000000
	bne	b@
	clra
g@	cmpa	$44
	beq	b@
	bsr	flip
	bra	d@
c@	rts

flip	ldb	[,y]
	eorb	#$40
	stb	[,y]
	ldx	,y
	cmpx	#$461
	bne	a@
	ldb	$460+25
	eorb	#$40
	stb	$460+25
a@	rts

c3ky	leax	KyCC3-1,pcr
	jsr	PRINT
a@	jsr	[$A000]
	bne	d@
	lda	#$7F
	sta	$FF02
	lda	$FF00
	anda	#%01000000
	bne	a@
	clra
d@	cmpa	#3
	beq	c@
* Add conversion for lower case
	sta	$44
	ldx	#$400+8*32+13
	stx	$88
	ldy	#$6060
	sty	$400+8*32+13
	sty	$400+8*32+14
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
g@	leax	KyCC3b,pcr
	leay  MxCC3,pcr
e@	cmpa	,x+
	beq	f@
	leay  2,y
	cmpy	#EndMx3
	bne	e@
	bra	b@
f@	bsr	flip
b@	jsr	[$A000]
	bne	h@
	lda	#$7F
	sta	$FF02
	lda	$FF00
	anda	#%01000000
	bne	b@
	clra
h@	cmpa	$44
	beq	b@
* Add conversion for lower case
	lbsr	flip
	bra	d@
c@	rts

KyCC3
	fcc	/  1 2 3 4 5 6 7 8 9 0 : - BRK/
	fcb	$0D
	fcc	/AL Q W E R T Y U I O P @ CLR UP/
	fcb	$0D
	fcc	/CT A S D F G H J K L ; EN <- ->/
	fcb	$0D
	fcc	" SHF Z X C V B N M , . / SHF DN"
	fcb	$0D
	fcc	/         SPACEBAR      F1 F2/
	fcb	$0D,$0D,$0D
	fcc	/       DECI KEY VALUE/
	fcb	$0D,0

KyCC3b
	fcb   '1,'2,'3,'4,'5,'6,'7,'8,'9,'0,':,'-,$03
	fcb	$BF,'Q,'W,'E,'R,'T,'Y,'U,'I,'O,'P','@,$0C,$5E
	fcb	189,'A,'S,'D,'F,'G,'H,'J,'K,'L,';,$0D,$08,$09
	fcb	0,'Z,'X,'C,'V,'B,'N,'M,',,'.,'/,0,$0A
	fcb	$20,103,$04

MxCC3	fdb	$400+2,$400+4,$400+6,$400+8,$400+10,$400+12,$400+14,$400+16,$400+18,$400+20,$400+22,$400+24,$400+26
	fdb	$420,$420+3,$420+5,$420+7,$420+9,$420+11,$420+13,$420+15,$420+17,$420+19,$420+21,$420+23,$420+25,$420+29
	fdb	$440,$440+3,$440+5,$440+7,$440+9,$440+11,$440+13,$440+15,$440+17,$440+19,$440+21,$440+23,$440+26,$440+30
	fdb	$460+1,$460+5,$460+7,$460+9,$460+11,$460+13,$460+15,$460+17,$460+19,$460+21,$460+23,$460+25,$460+29
	fdb	$480+9,$480+23,$480+26
EndMx3	equ	*


KyCC1
	fcc	/  1 2 3 4 5 6 7 8 9 0 : - BRK/
	fcb	$0D
	fcc	/UP Q W E R T Y U I O P @ <- ->/
	fcb	$0D
	fcc	/DWN A S D F G H J K L ; ENT CLR/
	fcb	$0D
	fcc	" SHF Z X C V B N M , . / SHF"
	fcb	$0D
	fcc	/         SPACEBAR/
	fcb	$0D,$0D,$0D
	fcc	/       DECI KEY VALUE/
	fcb	$0D,0

KyCC1b
	fcb   '1,'2,'3,'4,'5,'6,'7,'8,'9,'0,':,'-,$03
	fcb	$5E,'Q,'W,'E,'R,'T,'Y,'U,'I,'O,'P','@,$08,$09
	fcb	$0A,'A,'S,'D,'F,'G,'H,'J,'K,'L,';,$0D,$0C
	fcb	0,'Z,'X,'C,'V,'B,'N,'M,',,'.,'/,0
	fcb	$20

MxCC1	fdb	$400+2,$400+4,$400+6,$400+8,$400+10,$400+12,$400+14,$400+16,$400+18,$400+20,$400+22,$400+24,$400+26
	fdb	$420,$420+3,$420+5,$420+7,$420+9,$420+11,$420+13,$420+15,$420+17,$420+19,$420+21,$420+23,$420+25,$420+29
	fdb	$440,$440+4,$440+6,$440+8,$440+10,$440+12,$440+14,$440+16,$440+18,$440+20,$440+22,$440+24,$440+28
	fdb	$460+1,$460+5,$460+7,$460+9,$460+11,$460+13,$460+15,$460+17,$460+19,$460+21,$460+23,$460+25
	fdb	$480+9
EndMx1	equ	*
