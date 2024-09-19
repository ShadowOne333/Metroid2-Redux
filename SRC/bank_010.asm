; Disassembly of "m2 ejrtq v1.3.gbc"
; This file was created with:
; mgbdis v2.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $010", ROMX[$4000], BANK[$10]

include "colors.asm"

;------------------------------------------------------------------------------
; Screen transitions
doorPointerTable:: ; 05:42E5
include "maps/door macros.asm"
include "maps/doors.asm"

;------------------------------------------------------------------------------

loadColors:
    ld de, rawColorBuffer
    ld bc, $0080
    ld a, c
    ld [fadeInColorTimerOld], a ; forces color update (i assume saveBuf_colorIDSrcHigh is not $00)
    jp copyToVram

copyAllColorsToVram_colorBuffer: ;{
    ld a, BCPSF_AUTOINC | $00
    ldh [rBCPS], a
    ldh [rOCPS], a
    ld hl, colorBuffer
    ld de, rBCPD

    ; transfer all colors for both bg and obj
    .loop_A:
        ld a, [hl+]
        ld [de], a
        ld a, [hl+]
        ld [de], a
        bit 6, l ; exit if all 64 colors have been loaded for BG
    jr z, .loop_A

    ld e, LOW(rOCPD)
    .loop_B:
        ld a, [hl+]
        ld [de], a
        ld a, [hl+]
        ld [de], a
        bit 6, l ; exit if all 64 colors have been loaded for OBJ
    jr nz, .loop_B
ret ;}

initializeColors: ;{
    push hl
    push de
    push bc

    ; switch to double speed cpu
    ld hl, rKEY1
    bit 7, [hl]
    jr nz, .endIf_A
        set 0, [hl]
        xor a
        ldh [rIF], a
        ldh [rIE], a
        ld a, $30
        ldh [rP1], a
        stop
    .endIf_A:

    ; initialize colors
    ld hl, palettes_Title
    ld de, colorBuffer
    ld bc, $0080
    call copyToVram

    ld hl, palettes_Title
    ld de, rawColorBuffer
    ld bc, $0080
    call copyToVram

    call copyAllColorsToVram_colorBuffer
    
    ; initialize other variables
    ld a, $00
    ld [transferType], a
    xor a
    ld [screenFlashGBCOld], a
    ld [transferColorsFlag], a
    ld [fadeInColorTimer], a
    ld a, $80
    ld [fadeInColorTimerOld], a
    ld [gameModeOld], a
    pop bc
    pop de
    pop hl
ret ;}

VBlank_updateCreditsLineColorID: ;{
    ld a, [pTilemapDestLow]
    ld l, a
    ld a, [pTilemapDestHigh]
    ld h, a
    ld bc, $0014 ; length of one line
jr updateBGTilemapColorID ;}

; source/dest hl
; length bc
updateBGTilemapColorID: ;{
    .loop:
        ; load colorIDBuffer address (d280-d37f) into de
        ld e, [hl] ; load tile id
        ld a, e
        sub $80 ; carry is set if it underflows
        ld d, HIGH(colorIDBuffer)/2
        rl d ; carry becomes bit 0 of high byte (smart!)

        ; change vram bank to 1 (color specification)
        ld a, $ff
        ldh [rVBK], a

        ; load color id of tile into vram 
        ld a, [de]
        ld [hl+], a

        ; restore vram bank to 0
        xor a
        ldh [rVBK], a

        ; decrease length
        dec bc
        ld a, b
        or c
    jr nz, .loop ; exit if length is zero
ret ;}


updateAllSpritesColorID: ;{
    ld d, HIGH(colorIDBuffer)
    ld hl, wram_oamBuffer
    ld a, [samusTopOamOffset]
    ld b, a

    ; loop through all samus sprites
    .loop_A:
        ld a, l
        cp b
        jr z, .leaveLoop_A ; exit if hl is no longer pointing to samus sprite

        inc l
        inc l
        ld a, [hl+] ; tile id
        ld e, a
        ld a, [de] 
        ld c, a ; load color id into c
        ld a, [hl] ; attribs
        bit OAMB_PAL1, a
        jr z, .endIf_A
            ; sprite has palette 1 (frozen or hurt)
            ld a, c
            cp $03
            jr z, .else_A
                ld c, $03 ; change to blue color
                jr .endIf_A
            .else_A:
                ld c, $01 ; if color was already blue, use purple instead
                jr .endIf_A
        .endIf_A
        ; write color to attribs
        ld a, [hl]
        and $f0
        or c
        ld [hl+], a
    jr .loop_A

    .leaveLoop_A:
    ldh a, [hOamBufferIndex]
    ld b, a

    ; loop through all enemy sprites
    .loop_B:
        ld a, l
        cp b
        ret z ; exit if hl is no longer pointing to enemy sprite

        inc l
        inc l
        ld a, [hl+] ; tile id
        ld e, a
        ld a, [de] 
        ld c, a ; load color id into c
        ld a, [hl] ; attribs
        and $07
        ld a, [hl]
        jr nz, .noChange ; skip color assignment logic if color id is 0 (metroid palette)

        bit OAMB_PAL1, a
        jr z, .endIf_B
            ; sprite has palette 1 (frozen or hurt)
            ld a, c
            cp $03
            jr z, .else_B
                ld c, $03 ; change to blue color
                jr .endIf_B
            .else_B:
                ld c, $01 ; if color was already blue, use purple instead
                jr .endIf_B
        .endIf_B:
        ; write color to attribs
        ld a, [hl]
        and $f0
        or c

        .noChange:
        ld [hl+], a
    jr .loop_B
;}

updateVramTransferColorID: ;{
    ld a, $00
    ld [transferType], a

    ; load transfer length to bc
    ld hl, hVramTransfer.sizeHigh
    ld a, [hl-]
    ld b, a
    ld a, [hl-]
    ld c, a
    or b
    ret z ; exit if nothing needs to be transferred

    ld a, [variaAnimationFlag]
    or a
    ret nz ; exit if its varia animation

    ; load transfer dest to de
    ld a, [hl-]
    ld d, a
    ld a, [hl-]
    ld e, a
    
    ; load transfer source to hl
    ld h, [hl]
    ldh a, [hVramTransfer]
    ld l, a

    ; if length > $0040, bc = $0040
    ld a, c
    sub $40
    ld a, b
    sbc $00
    jr c, .endIf_A
        ld bc, $0040
    .endIf_A:

    ld a, c
    ld [tempTransferSize], a
    push de
    push hl
    ld de, vramTransferDataBuffer
    call copyFromTransferBank
    pop hl
    pop de
    ld a, [tempTransferSize]
    ld c, a
    ldh a, [hVramTransfer.destAddrHigh]
    sub $80
        jr c, .default ; transfer to rom? when would that happen?
    sub $18
        jr c, .tileset ; transfer tileset to vram
    cp $08
        jr c, .tilemap ; transfer tilemap to vram
    jr .default

.tileset:
    ;call copyTilesetColorToBuffer_farCall
    ; fallthrough

    .default:
    ld a, $02
    ld [transferType], a
    ret

.tilemap:
    ld a, $01
    ld [transferType], a
    ld d, HIGH(colorIDBuffer)/2
    ld hl, vramTransferDataBuffer

    .loop:
        ; load colorIDBuffer address (d280-d37f) into de
        ld e, [hl] ; load tile id
        ld a, e
        sub $80 ; carry is set if it underflows
        rl d ; carry becomes bit 0 of high byte (smart!)

        ld a, [de] ; color id
        set 6, l ; add $0040 to hl
        ld [hl+], a ; write color id to vramTransferColorIDBuffer
        res 6, l ; undo add $0040

        rr d ; undo rl d
        dec bc ; decrement length
        ld a, b
        or c
    jr nz, .loop ; exit loop if length == 0
    ret 
;}




queen_drawHeadColorID: ;{
    ld a, [queen_headFrameNext]
    or a
    jr nz, .endIf_B
        ; exit if we're not switching to a new head frame
        ld [queen_transferHeadColorIDFlag], a ; unset flag
        ret
    .endIf_B:

    cp $04
    jr nc, .else_C ; if the head frame just started to transfer
        ; load queenBank10_headFrame into hl
        ld hl, .data
        dec a
        ld e, a
        ld d, $00
        add hl, de
        ld l, [hl]
        ld h, HIGH(queenBank10_headFrameA)
        ld e, LOW(_SCRN1)
        jr .endIf_C
    .else_C:
        ; load queen_headDest into e and queen_headSrc into hl
        ld hl, queen_headDest
        ld a, [hl+]
        ld e, a
        ld a, [hl+] ; queen_headSrcHigh
        ld d, a
        ld l, [hl] ; queen_headSrcLow
        ld h, d
    .endIf_C:
    ld a, e
    ld [queen_transferHeadColorIDDest], a
    ld a, $12
    ld [queen_transferHeadColorIDFlag], a ; set flag
    ld de, queen_transferColorIDBuffer
    ld b, HIGH(colorIDBuffer)/2

    .loop:
        push af
            ld a, [hl+] ; load tile id
            ld c, a ; load colorIDBuffer address (d280-d37f) into bc
            sub $80 ; carry is set if it underflows
            rl b ; carry becomes bit 0 of high byte (smart!)
            ld a, [bc]
            ld [de], a ; load color id into queen_transferColorIDBuffer
            inc e
            srl b ; undo rl b
            
            ld a, [hl+] ; load tile id
            ld c, a ; load colorIDBuffer address (d280-d37f) into bc
            sub $80 ; carry is set if it underflows
            rl b ; carry becomes bit 0 of high byte (smart!)
            ld a, [bc]
            ld [de], a ; load color id into queen_transferColorIDBuffer
            inc e
            srl b ; undo rl b
        pop af
        sub $02 ; we can do two color ids at once bc the transfer size is guaranteed to be an even number
    jr nz, .loop ; exit when all color ids are transferred
ret 

.data:
    db LOW(queenBank10_headFrameA), LOW(queenBank10_headFrameB), LOW(queenBank10_headFrameC)
;}

updateColors: ;{
    push bc
    push de
    push hl
    call updateVramTransferColorID
    call updateAllSpritesColorID

    ld a, [queen_roomFlag]
    cp $11
        call z, queen_drawHeadColorID

    ld a, [screenFlashGBC]
    ld c, a
    ld a, [fadeInColorTimer]
    ld b, a

    ld a, [screenFlashGBCOld]
    cp c
    jr nz, .if_B

    ld a, [fadeInColorTimerOld]
    cp b
    jr z, .endIf_B

.if_B: ; if fade in or screen flash have changed
    ; prepare to transfer colors
    ld a, $01
    ld [transferColorsFlag], a
    call updateFadeInColor

.endIf_B:
    pop hl
    pop de
    pop bc
ret ;}

; b fadeInColorTimer
updateFadeInColor: ;{
    ld a, [fadeInColorTimerOld]
    cp b
    ret z ; exit if not calculating new fade in colors
    ld a, b
    ld [fadeInColorTimerOld], a

    ; get denominator power of 2
    ; denominator power of 2 for each possible value of fadeInColorTimer (0 to 8) is
    ; 0,  1,   1,   2,   2,   3,   3,  4, 4
    ; this will correspond to these factors to multiply colors
    ; 1, 1/2, 1/2, 1/4, 1/4, 1/8, 1/8, 0, 0
    ld hl, colorBuffer
    ld de, rawColorBuffer
    inc b
    srl b 
    ld c, $40
    call divideColorsByDenominator

    ld a, [fadeInColorTimer]
    cp $07
    ret nc ; exit if fadeInColorTimer is >= 7
    and $01
    ret z ; exit if fadeInColorTimer is an even number
    ; now fadeInColorTimer can only be 1, 3 or 5

    ; multiply colors by 1.5
    ld hl, colorBuffer + 1 ; start with color high byte
    .loop:
        ld a, [hl-] ; high byte
        srl a ; divide by 2
        and %0111101 ; correct division result
        ld d, a

        ld a, [hl] ; low byte
        ld e, a 
        rr a ; divide by 2
        and %11101111 ; same deal here

        add e ; add full low to half low
        ld [hl+], a

        ld a, [hl]
        adc d ; add full high to half high
        ld [hl+], a

        inc l
        bit 7, l
    jr z, .loop ; exit if we processed all $80 color bytes in colorBuffer

    ; here are the final fractions multiplied to colors
    ; 1, 1.5/2, 1/2, 1.5/4, 1/4, 1.5/8, 1/8, 0, 0
ret ;}

; Called from VBlankHandler
VBlank_checkTransferColors: ;{
    ld a, [mapUpdateFlag]
    or a
    ret nz ; exit if map needs to be updated

    ld a, [transferColorsFlag]
    or a
    ret z ; exit if no colors need to be transferred

    ld a, [screenFlashGBC]
    cp $82
        jr z, .doTitleFlash
    cp $83
        jr z, .doQueenFlash

    ld a, [screenFlashGBCOld]
    ld b, a
    and $80
        jr z, .other

    ld a, b
    cp $82
        jr z, .undoTitleFlash
    cp $83
        jr z, .undoQueenFlash

    ; other causes for color updates, such as fade in
    .other:
        call copyAllColorsToVram_colorBuffer
    jr .end

    .undoTitleFlash:
        xor a ; black
        jr .titleFlash

    .doTitleFlash:
        ld a, $ff ; white

    .titleFlash:
        ; write aa to all 8 gbc color palettes's first color
        ld hl, rBCPS
        ld de, rBCPD
        ld [hl], BCPSF_AUTOINC | $00
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $08
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $10
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $18
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $20
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $28
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $30
        ld [de], a
        ld [de], a
        ld [hl], BCPSF_AUTOINC | $38
        ld [de], a
        ld [de], a
    jr .end

    .undoQueenFlash:
        ld hl, .undoQueenFlashData
        jr .queenFlash

    .doQueenFlash:
        ld hl, .doQueenFlashData

    .queenFlash:
        ld de, rBCPD
        ld b, $03 ; number of gbc color palettes to replace

        .loop_B:
            ld a, [hl+]
            ldh [rBCPS], a
            ld a, [hl+]
            push hl
            ld h, HIGH(colorBuffer)
            ld l, a
            ld c, $03 ; number of colors to replace in a gbc color palette

            ; copy gbc color palette over another one
            .loop_C:
                ; replace color with color of QueenFlashData gbc color palette
                ld a, [hl+]
                ld [de], a
                ld a, [hl+]
                ld [de], a
                dec c
            jr nz, .loop_C ; exit when colors 1,2,3 of gbc color palette are replaced

            pop hl
            dec b
        jr nz, .loop_B

    .end:
    ld a, [screenFlashGBC]
    ld [screenFlashGBCOld], a

    xor a
    ld [transferColorsFlag], a
ret

.undoQueenFlashData:
    db BCPSF_AUTOINC | $18 + 2, $18 + 2
    db BCPSF_AUTOINC | $20 + 2, $20 + 2
    db BCPSF_AUTOINC | $28 + 2, $28 + 2
.doQueenFlashData:
    db BCPSF_AUTOINC | $18 + 2, $58 + 2
    db BCPSF_AUTOINC | $20 + 2, $58 + 2
    db BCPSF_AUTOINC | $28 + 2, $58 + 2
;}

/*VBlank_transferData: ;{
    ; load tempTransferSize into bc
    ld b, $00
    ld a, [tempTransferSize]
    ld c, a
    ; add tempTransferSize to hVramTransfer.srcAddr
    ld hl, hVramTransfer.srcAddrLow
    ld a, [hl]
    add c
    ld [hl+], a
    ld a, [hl]
    adc b
    ld [hl+], a
    ; load hVramTransfer.destAddr into de
    ld a, [hl+]
    ld e, a
    ld a, [hl+]
    ld d, a

    ld a, [transferType]
    or a
    ret z ; exit if no transfer

    dec a
    jr nz, .endIf_A ; if transfer tilemap

    .if_A:
        push de
        ld hl, vramTransferColorIDBuffer
        ; change vram bank to 1 (color specification)
        ld a, $ff
        ldh [rVBK], a

        ; transfer color id data
        .loop_A:
            ld a, [hl+]
            ld [de], a
            inc de
            dec c
        jr nz, .loop_A

        ; restore vram bank to 0
        xor a
        ldh [rVBK], a
        pop de

        ld a, [tempTransferSize]
        ld c, a

    .endIf_A:
    ld hl, vramTransferDataBuffer

    ; transfer data
    .loop_B:
        ld a, [hl+]
        ld [de], a
        inc de
        dec c
    jr nz, .loop_B

    ; write destAddrLow
    ld hl, hVramTransfer.destAddrLow
    ld a, e
    ld [hl+], a
    ld a, d
    ld [hl+], a

    ld a, [tempTransferSize]
    ld c, a
    ; hVramTransfer.size -= tempTransferSize
    ld a, [hl]
    sub c
    ld [hl+], a ; low byte
    ld c, a
    ld a, [hl]
    sbc b
    ld [hl+], a ; high byte
    ld b, a
    ; note that by the end, bc needs to contain hVramTransfer.size, 
    ; because of the caller function VBlank_vramDataTransfer
ret ;}
*/


; darken palette for fadein
; b denominator power of 2 (min 0, max 4) 
;   color is divided by 2^b, except when b == 4, where color becomes 0
; c length $40 == eight palettes of four colors for both bg and obj
; hl, colorBuffer
; de, rawColorBuffer
divideColorsByDenominator: ;{
    ld a, b
    cp $04
    jr nc, .noColor

    ; copy all colors from rawColorBuffer to colorBuffer
    .loop_A:
        ; copy one color (low and high bytes)
        ld a, [de]
        inc e
        ld [hl+], a
        ld a, [de]
        inc e
        ld [hl+], a
    jr nz, .loop_A ; exit when e == 0 (all $80 bytes transferred)
    ld l, e ; hl is now colorBuffer

    ld a, b
    or a
    ret z ; return if palette doesnt need darkening

    cp $02
    jr z, .quarterColor

    jr nc, .eighthColor

; half color
    ld de, %011110111101111
    .loop_B:
        ; load color into ab
        ld a, [hl+]
        ld b, a
        ld a, [hl]
        ; divide by 2 with bit shift
        srl a
        rr b
        ; save color back to colorBuffer
        and d ; corrects result of division
        ld [hl-], a
        ld a, b
        and e ; same deal here
        ld [hl+], a

        inc l ; move to next color
        bit 7, l
    jr z, .loop_B ; exit loop when all colors are darkened
    ret

.quarterColor:
    ld de, %001110011100111
    .loop_C:
        ; load color into ab
        ld a, [hl+]
        ld b, a
        ld a, [hl]
        ; divide by 4 with bit shift
        srl a
        rr b
        srl a
        rr b
        ; save color back to colorBuffer
        and d ; corrects result of division
        ld [hl-], a
        ld a, b
        and e ; same deal here
        ld [hl+], a

        inc l ; move to next color
        bit 7, l
    jr z, .loop_C ; exit loop when all colors are darkened
    ret

.eighthColor:
    ld de, %000110001100011
    .loop_D:
        ; load color into ab
        ld a, [hl+]
        ld b, a
        ld a, [hl]
        ; divide by 8 with bit shift
        srl a
        rr b
        srl a
        rr b
        srl a
        rr b
        ; save color back to colorBuffer
        and d ; corrects result of division
        ld [hl-], a
        ld a, b
        and e ; same deal here
        ld [hl+], a

        inc l ; move to next color
        bit 7, l
    jr z, .loop_D ; exit loop when all colors are darkened
    ret

.noColor:
    xor a
    .loop_E:
        ; write the color black
        ld [hl+], a
        ld [hl+], a

        bit 7, l
    jr z, .loop_E ; exit loop when all colors are black
    ret
;}



bootRoutineDMG:
    ; Initialize registers
    xor a
    ldh [rIF], a
    ldh [rIE], a
    di
    ldh [rSCY], a
    ldh [rSCX], a
    ldh [rSTAT], a
    ldh [rSB], a
    ldh [rSC], a
    ldh [rNR52], a
    ld a, $80
    ldh [rLCDC], a

    ; Wait for rendering to be off
    .waitLoop:
        ldh a, [rLY]
        cp $94
    jr nz, .waitLoop
    ; Init LCD parameters
    ld a, $03
    ldh [rLCDC], a

    ld a, $93
    ldh [rBGP], a

    ; Clear $8000-$9FFF (VRAM)
    xor a
    ld hl, $9fff
    ld c, $20
    ld b, $00
    .clearLoop:
            ld [hl-], a
            dec b
            jr nz, .clearLoop
        dec c
    jr nz, .clearLoop

    ; Init stack pointer before calling a function
    ld sp, stack.bottom ; $DFFF

    ld hl, gfx_creditsFontDMG
    ld de, vramDest_creditsFont
    ld bc, $0200	; $0C90 for Redux screen
    call copyToVram

    ld de, DMGMessage ; src
    ld hl, _SCRN0 + 3*$20 ; dest
    ld bc, $0020 ; length of a row in vram tilemap
    
    .transferTilemapLoop:
    ld a, [de]
    inc de
    cp $f0
        jr z, .end
    cp $f1
        jr z, .newline

    sub $21
    ld [hl+], a
    jr .transferTilemapLoop
    
    .newline:
    ld a, l
    and $e0
    ld l, a
    add hl, bc
    jr .transferTilemapLoop

    .end:
    ; Enable LCD (only background)
    ld a, $c1
    ldh [rLCDC], a

    ; stop all execution forever
    .haltLoop:
        halt
        nop
    jr .haltLoop

DMGMessage: include "data/dmg_message.asm"
;DMGMessage: include "SRC/dmg/m2dmg_message.asm"
gfx_creditsFontDMG:     incbin "gfx/titleCredits/creditsFont.2bpp"
;gfx_creditsFontDMG: incbin "SRC/dmg/m2dmg.2bpp"

SECTION "ROM Bank $010 - Chunk from bank 3", ROMX[queen_headFrameA], BANK[$10]
; Queen head tilemaps
queenBank10_headFrameA: ; 03:6FA2
    db $BB, $B1, $B2, $B3, $B4, $FF
    db $C0, $C1, $C2, $C3, $C4, $FF
    db $D0, $D1, $D2, $D3, $D4, $D5
    db $FF, $FF, $E2, $E3, $E4, $E5
    db $FF, $FF, $FF, $FF, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
queenBank10_headFrameB: ; 03:6FC6
    db $BB, $B1, $F5, $B8, $B9, $BA
    db $C0, $C1, $C7, $C8, $C9, $CA
    db $D0, $E6, $D7, $D8, $FF, $FF
    db $FF, $F6, $E7, $E8, $FF, $FF
    db $FF, $FF, $F7, $F8, $FF, $FF
    db $FF, $FF, $FF, $FF, $FF, $FF
queenBank10_headFrameC: ; 03:6FEA
    db $FF, $BC, $BD, $BE, $FF, $FF
    db $FF, $CB, $CC, $CD, $FF, $FF
    db $DA, $DB, $DC, $DD, $FF, $FF
    db $EA, $EB, $EC, $ED, $DE, $FF
    db $FA, $FB, $FC, $FD, $EE, $D9
    db $FF, $FF, $FF, $FF, $FF, $FF
