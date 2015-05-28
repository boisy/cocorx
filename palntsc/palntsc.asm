	org	$3f00
;*********************************************
; PAL / NTSC DETECT (SIMON JONASSEN)
; X returns 262 or 312 (ntsc/pal)
;*********************************************
	
start	orcc	#$50		;kill irq/firq
	ldx	#$0		;X = 0 
	lda	$ff02		;clear pending vsync
lp1	lda	$ff03		;get vsync flag
	bpl	lp1		;wait it out
	lda	$ff02		;ack flag

lp2	lda	$ff01		;get hsync flag
	bpl	lp2		;wait t out
	lda	$ff00		;ack hsync
	leax	1,x		;counter ++
	lda	$ff03		;get vsync
	bpl	lp2		;wait
	lda	$ff02		;ack
	rts			;outta here
	end	start