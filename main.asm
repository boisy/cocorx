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


	org $C000

EXEC	equ	*


* Disable IRQ and FIRQ
	orcc	#$50

* Set BASIC Reset Flag
        clr     $71


        lbsr    ShowTitleScreen
showagain
	lbsr    ShowMenuScreen
        bra     showagain

	include	screenutils.asm
	include	menuscreen.asm
	include	symbols.asm
	include	titlescreen.asm
	include	ramdoctor.asm
	include	videodoctor.asm
	include	sounddoctor.asm
	include	joystickdoctor.asm
	include	cassettedoctor.asm
	include	serialdoctor.asm
	include	keyboarddoctor.asm
	zmb	$E000-*

* The zmb is necessary for testing with some emulators. It will ensure
* that the resulting cocorx.rom is the full $2000 bytes. R Gault
*
* All SECTION commands have been removed. All files are included here
* and there is a single lwasm main.asm to create the rom. This greatly
* improves addressing for all files. However there is still a problem
* with the use of RMB. The address counter gets lost! Please replace RMB
* with FCBs or ZMB unless someone can get RMB to work in this project. R Gault
*
* You can use either the Go file or the makefile to create this project.
* On a Windows system, just rename Go to go.bat for it to work. With
* Windows, you will need mingw and msys to use the makefile. R Gault