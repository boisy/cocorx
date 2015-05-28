        SECTION titlescreen

ShowTitleScreen
        puls    d,x,y
* Clear the screen
        lda     #$20
	lbsr	ClearScreen
        
        leax    Message,pcr
        lbsr    PrintBlock

        puls    d,x,y,pc

Wait    
        pshs    x
        ldx     #$2000
loop@   leax    -1,x
        cmpx    #$0000
        bne     loop@
        puls    x,pc

Message 
        fdb     $060D
        fcc     "COCORX"
        fcb     $00
        fdb     Wait-*-2

        fdb     $0708
        fcc     '"THE DOCTOR IS IN"'
        fcb     $00
        fdb     Wait-*-2

        fdb     $0E02
        fcc     "PRESS [SPACE] TO CONTINUE..."
        fcb     $00
        fdb     Wait-*-2

        fdb     $FFFF

        END     SECTION
