        SECTION videodoctor

VideoDoctor
	bsr   ColorBars
        lbsr  WaitForKey
	bsr   bordertest
        rts

*******************************************
* TESTCARD BY SIMON JONASSEN
*******************************************
ColorBars
        pshs    d,x
	ldx	#$0
lp1	ldd	#$cfcf
	std	$400,x
	std	$402,x
	ldd	#$9f9f
	std	$404,x
	std	$406,x
	ldd	#$dfdf
	std	$408,x
	std	$40a,x
	ldd	#$8f8f
	std	$40c,x
	std	$40e,x
	ldd	#$efef
	std	$410,x
	std	$412,x

	ldd	#$bfbf
	std	$414,x
	std	$416,x
	ldd	#$afaf
	std	$418,x
	std	$41a,x
	ldd	#$ffff
	std	$41c,x
	std	$41e,x

	leax	32,x

	cmpx	#32*16
	bne	lp1
	puls    x,d,pc

*******************************************
* Checkerboard in the border (coco I/II)
*******************************************

bordertest

	ldx	#$400
;	ldu	#checks
        leau    checks,pcr
again	ldd	,u
	std	,x
	std	32,x
	std	128,x
	std	160,x
	std	256,x
	std	288,x
	std	384,x
	std	416,x	

	ldd	32,u
	std	64,x
	std	96,x
	std	192,x
	std	224,x
	std	320,x
	std	352,x
	std	448,x
	std	480,x

	leau	2,u
	leax	2,x
	cmpx	#$420
	blo	again


	lda	#$7
	sta	<$03
	sta	<$01

	lda	#$7f
	sta	$ff02


loop	lda	<$03
	bpl	loop
	lda	<$02
	ldx	#4
	sync
	lda	<$00
	sync	
	lda	<$00

	ldb	#$3c		(2)	($22=ntsc/$3c=PAL)
hloop1	lda	<$01		(4)
	bpl	hloop1		(3)
	lda	<$00		(4)
	decb			;(2)
	bne	hloop1		;(3)
	mul			;(11)
	mul			;(11)
	mul			;(11)
	lda	#$f8		(2)	whack1 (f8)
	sta	<$22		(4)	(57)

zz	ldb	#24
hloop2	lda	<$01
	bpl	hloop2
	lda	<$00
	decb
	bne	hloop2
	mul
	mul
	mul
	lda	#$00	
	sta	<$22

	ldb	#24
hloop3	lda	<$01
	bpl	hloop3
	lda	<$00
	decb
	bne	hloop3
	mul
	mul
	mul
	lda	#$f8		f8			whack2 (f8)
	sta	<$22

	nop

	leax	-1,x
	bne	zz
	lda	#$c0
	sta	<$22

	lda	$ff00
	bita	#8
	bne	loop
	clr	<$22
	puls	pc


	
	
checks	fcb	$00,$00,$00,$0f,$ff,$ff,$ff,$00,$00,$00,$0f,$ff,$ff,$ff,$00,$00,$00,$0f,$ff,$ff,$ff,$00,$00,$00,$0f,$ff,$ff,$ff,$00,$00,$00,$0f
	fcb	$cf,$cf,$cf,$ca,$80,$80,$80,$cf,$cf,$cf,$ca,$80,$80,$80,$cf,$cf,$cf,$ca,$80,$80,$80,$cf,$cf,$cf,$ca,$80,$80,$80,$cf,$cf,$cf,$ca


        END     SECTION
