        SECTION screenutils

*
* Clear the screen
*
* Entry:
*   A = character to clear screen with
*
ClearScreen
        pshs    x,y
        ldx	#$400
	leay	$200,x
clloop	sta	,x+
	cmpx	,y
	bne	clloop
	puls    x,y,pc

*
* Print Block
*
* A block has the format:
*  - 2 bytes: $RRCC  (where RR == row and CC = column for text to appear)
*  - n bytes: "Some String" (the text to show)
*  - n bytes: "Some String" (the text to show)
*  - 2 bytes: Subroutine (to be called after printing of bytes on screen)
*
* This can repeat for additional positions and nil terminated strings.
* To terminate the processing, set $RRCC to $FFFF. This flags the routine
* to stop printing.
*
* Entry:
*       X = pointer to block of messages to show on screen
*
PrintBlock
        pshs     d,x,y
pbloop  ldy      ,x++
        cmpy     #$FFFF
        beq      done1
        bsr      PrintStringAt
        ldd      ,x++
        jsr      d,x
        bra      pbloop
done1   puls     d,x,y,pc

*
* Print at a specific location on the screen
*
* Entry:
*       X = pointer to nil terminated string
*       Y = location (hi byte = row, low byte = column)
* Exit:
*       X = pointer to byte after nil
*
PrintStringAt
        pshs     d,y
        tfr      y,d
        ldb      #32
        mul
        addb     3,s
        adca     #0
        tfr      d,y
        leay     $400,y
prloop  lda      ,x+
        beq      done
        sta      ,y+
        bra      prloop
done    puls     y,d,pc

        END      SECTION

