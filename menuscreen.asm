        SECTION menuscreen

ShowMenuScreen
        pshs    a,x,y
* Clear the screen
        lda     #$60
	lbsr	ClearScreen
        
        leax    Message,pcr
        lbsr    PrintBlock

        lbsr    WaitForKey
        cmpa    #'1
        bne     IsIt2
        lbsr    RAMDoctor
        puls    a,x,y,pc
IsIt2   cmpa    #'2
        bne     Exit
        lbsr    VideoDoctor
Exit    puls    a,x,y,pc

Return  rts

Message 
        fdb     $0502
        fcc     "1-"
        fcb     $60
        fcc     "RAM"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0702
        fcc     "2-"
        fcb     $60
        fcc     "VIDEO"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $FFFF

        END     SECTION
