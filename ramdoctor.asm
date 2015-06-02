        SECTION ramdoctor

RAMDoctor
        pshs    d,x,y
        lda     #$60
        lbsr    ClearScreen
        leax    Message,pcr
        lbsr    PrintBlock
        lda     #$20
        lbsr    WaitForKey 
        puls    d,x,y,pc
Return  rts

Message
        fdb     $070D
        fcc     "PASSED"
        fcb     $00
        fdb     Return-*-2

        fdb     $FFFF

        END     SECTION
