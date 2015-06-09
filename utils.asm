        SECTION utils

* Exit:
*   A = RAM Size
*   CoCo 1/2:
*       1 = 4K
*       2 = 16K
*       3 = 32K
*       4 = 64K
*   CoCo 3:
*       5 = 128K
*       6 = 256K
*       7 = 512K
*       8 = 1024K
*       9 = 2048K
CoCoRAMSize
       bsr     CoCoType
       cmpa    #3
       beq     CoCo3RAMSize
CoCo2RAMSize
* TODO: Code for CoCo 1/2 RAM Size detection
       lda     #1
       rts
CoCo3RAMSize
* TODO: Code for CoCo 3 RAM Size detection
       lda     #5
       rts


* Exit:
*   A = CoCoType: 1 = CoCo, 2 = CoCo 3 = CoCo 3
CoCoType
        pshs    x
        ldx     $FFFE
* TODO: Better tests for CoCo 3 vs CoCo 1/CoCo 2
        cmpx    #$8C1B
        lbeq    CoCo3
CoCo2   lda     #2
        puls    x,pc
CoCo3   lda     #3
        puls    x,pc

* Exit:
*   A = High Nibble: Major Version; Low Nibble: Minor Version
*       Example: $11 = Color BASIC version 1.1
CBVersion
* TODO: put working code here
        lda     #$11
        rts

        END     SECTION

* Exit:
*   A = High Nibble: Major Version; Low Nibble: Minor Version
*       Example: $11 = Extended Color BASIC version 1.1
ECBVersion
* TODO: put working code here
        lda     #$11
        rts

        END     SECTION

* Exit:
*   A = High Nibble: Major Version; Low Nibble: Minor Version
*       Example: $21 = Super Extended Color BASIC version 2.1
SECBVersion
* TODO: put working code here
        lda     #$21
        rts

        END     SECTION

