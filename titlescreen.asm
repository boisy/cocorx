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
        ldx     #$A000
loop@   leax    -1,x
        cmpx    #$0000
        bne     loop@
        puls    x,pc

Message 
        fdb     $070D
        fcc     "COCORX"
        fcb     $00
        fdb     Wait-*-2

* Shots
        fdb     $0103
        fcc     "*"
        fcb     $00
        fdb     Wait-*-2
 
        fdb     $0201
        fcc     "*"
        fcb     $00
        fdb     Wait-*-2
        
        fdb     $0911
        fcc     "*"
        fcb     $00
        fdb     Wait-*-2
        
        fdb     $FFFF

        END     SECTION
