*
* Copyright (C) 2015, Boisy Pitre <coco@toughmac.com>
*
* Permission to use, copy, modify, and/or distribute this software for any
* purpose with or without fee is hereby granted, provided that the above
* copyright notice and this permission notice appear in all copies.
*
* THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
* WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
* MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
* ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
* WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
* ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
* OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*

	NAM	CoCoRX
	TTL	A Holistic Program for determining the health of a CoCo

        SECTION main

EXEC	equ	*
* Set direct page register
	lda	#$FF
	tfr	a,dp
*	setdp	$FF

* Disable IRQ and FIRQ
	orcc	#$50

* Init timing sources
	lda	$FF03		Disable vsync interrupt generation
	anda	#$FE
	sta	$FF03
	tst	$FF02

*	lda	$FF01		Disable hsync interrupt generation
*	ora	#$01
*	sta	$FF01

* Init audio output
*	lda	PIA1C1		Enable square wave audio output
*	anda	#$FB
*	sta	PIA1C1
*	ldb	#SQWAVE
*	orb	PIA1D1
*	stb	PIA1D1
*	ora	#$04
*	sta	PIA1C1

        lbsr    ShowTitleScreen
        lbsr    RAMDoctor
        lbsr    VideoDoctor
        lbsr    JoystickDoctor
        lbsr    CassetteDoctor
        lbsr    SerialDoctor
        lbsr    KeyboardDoctor

l       bra     l

        END     SECTION
