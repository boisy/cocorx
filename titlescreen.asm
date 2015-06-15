

ShowTitleScreen
        pshs    a,x,y
* Clear the screen
        lda     #$60
	lbsr	ClearScreen
        
        leax    Message,pcr
        lbsr    PrintBlock

        puls    a,x,y,pc

Wait    
        pshs    x
        ldx     #$2000
loop@   leax    -1,x
        cmpx    #$0000
        bne     loop@
        puls    x,pc

Message 
        fdb     $020D
        fcc     "COCORX"
        fcb     $00
        fdb     Wait-*-2

        fdb     $0407
        fcb     $40+'"
        fcc     'THE'
        fcb     $60
        fcc     'DOCTOR'
        fcb     $60
        fcc     'IS'
        fcb     $60
        fcc     'IN'
        fcb     $40+'"
        fcb     $00
        fdb     Wait-*-2

        fdb     $0704
        fcc     'A'
        fcb     $60
        fcc     'COCO'
        fcb     $60
        fcc     'COMMUNITY'
        fcb     $60
        fcc     'PROJECT'
        fcb     $00
        fdb     Wait-*-2

        fdb     $0E02
        fcc     'PRESS'
        fcb     $60
        fcc     '[SPACE]'
        fcb     $60
        fcc     'TO'
        fcb     $60
        fcc     'CONTINUE'
        fcb     $40+'.
        fcb     $40+'.
        fcb     $40+'.
        fcb     $00
        fdb     WaitForSPACE-*-2

        fdb     $FFFF


