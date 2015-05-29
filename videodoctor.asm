        SECTION videodoctor

VideoDoctor
        bsr   ColorBars
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

        END     SECTION
