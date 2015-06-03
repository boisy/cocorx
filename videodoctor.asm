        SECTION videodoctor

VideoDoctor
        bsr   ColorBars
        lbsr  WaitForKey
        rts

*******************************************
* TESTCARD BY SIMON JONASSEN
*******************************************
ColorBars
        pshs    x,d
	ldx	#$400
lp1	ldd	#$cfcf
	std	$0,x
	std	$2,x
	ldd	#$9f9f
	std	$4,x
	std	$6,x
	ldd	#$dfdf
	std	$8,x
	std	$a,x
	ldd	#$8f8f
	std	$c,x
	std	$e,x
	ldd	#$efef
	std	$10,x
	std	$12,x

	ldd	#$bfbf
	std	$14,x
	std	$16,x
	ldd	#$afaf
	std	$18,x
	std	$1a,x
	ldd	#$ffff
	std	$1c,x
	std	$1e,x

	leax	32,x

	cmpx	#$400+(32*16)
	bne	lp1
	puls    d,x,pc

        END     SECTION
