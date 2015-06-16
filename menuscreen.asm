

ShowMenuScreen
        pshs    a,x,y
* Clear the screen
        lda     #$60
	lbsr	ClearScreen
        
        leax    Message1,pcr
        lbsr    PrintBlock

        lbsr    WaitForKey
        cmpa    #'1
        bne     IsIt2
        lbsr    RAMDoctor
        puls    a,x,y,pc
IsIt2   cmpa    #'2
        bne     IsIt3
        lbsr    VideoDoctor
IsIt3   cmpa    #'3
        bne     IsIt4
        lbsr    SoundDoctor
IsIt4   cmpa    #'4
        bne     IsIt5
        lbsr    KeyboardDoctor
IsIt5   cmpa    #'5
        bne     IsIt6
        lbsr    JoystickDoctor
IsIt6   cmpa    #'6
        bne     IsIt7
        lbsr    SerialDoctor
IsIt7   cmpa    #'7
        bne     Exit
        lbsr    CassetteDoctor
Exit    puls    a,x,y,pc

Return  rts

Message1 
        fdb     $0108
        fcc     "COCORX"
        fcb     $60
        fcc     "MAIN"
        fcb     $60
        fcc     "MENU"
        fcb     $00
        fdb     Return-*-2

        fdb     $0302
        fcc     "1-"
        fcb     $60
        fcc     "RAM"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0402
        fcc     "2-"
        fcb     $60
        fcc     "VIDEO"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0502
        fcc     "3-"
        fcb     $60
        fcc     "SOUND"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0602
        fcc     "4-"
        fcb     $60
        fcc     "KEYBOARD"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0702
        fcc     "5-"
        fcb     $60
        fcc     "JOYSTICK"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0802
        fcc     "6-"
        fcb     $60
        fcc     "SERIAL"
        fcb     $60
        fcc     "I"
        fcb     '/+$40
        fcc     "O"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0902
        fcc     "7-"
        fcb     $60
        fcc     "CASSETTE"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $FFFF


