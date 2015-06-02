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
        bne     IsIt3
        lbsr    VideoDoctor
IsIt3   cmpa    #'3
        bne     IsIt4
        lbsr    KeyboardDoctor
IsIt4   cmpa    #'4
        bne     Exit
        lbsr    JoystickDoctor
Exit    puls    a,x,y,pc

Return  rts

Message 
        fdb     $0202
        fcc     "1-"
        fcb     $60
        fcc     "RAM"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0302
        fcc     "2-"
        fcb     $60
        fcc     "VIDEO"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0402
        fcc     "2-"
        fcb     $60
        fcc     "SOUND"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0502
        fcc     "3-"
        fcb     $60
        fcc     "KEYBOARD"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0602
        fcc     "4-"
        fcb     $60
        fcc     "JOYSTICK"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $0702
        fcc     "5-"
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

        fdb     $0802
        fcc     "6-"
        fcb     $60
        fcc     "CASSETTE"
        fcb     $60
        fcc     "DOCTOR"
        fcb     $00
        fdb     Return-*-2

        fdb     $FFFF

        END     SECTION