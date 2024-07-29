; Disassembly of "m2 ejrtq v1.3.gbc"
; This file was created with:
; mgbdis v2.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $005", ROMX[$4000], BANK[$5]

titleCreditsBank:

; 05:5F34 - Includes credits font, item font, and sprite numbers
;  The title screen assumes these for files are contiguous
gfx_titleScreen:     incbin "gfx/titleCredits/titleScreen.2bpp"
gfx_creditsFont:     incbin "gfx/titleCredits/creditsFont.2bpp"
gfx_itemFont:        incbin "gfx/titleCredits/itemFont.2bpp"
gfx_creditsNumbers:  incbin "gfx/titleCredits/creditsNumbers.2bpp"

; 05:6F34
gfx_creditsSprTilesVaria: incbin "gfx/titleCredits/creditsSprTilesVaria.2bpp"
gfx_creditsSprTilesSuitless: incbin "gfx/titleCredits/creditsSprTilesSuitless.2bpp"

; 05:7E34
gfx_theEnd: incbin "gfx/titleCredits/theEnd.2bpp"

colorid_titleScreen:             incbin "gfx/titleCredits/titleScreen.attrmap", 0, $20 ; this only works bc all sprites are first and unique
colorid_creditsFont:             incbin "gfx/titleCredits/creditsFont.attrmap"
colorid_itemFont:                incbin "gfx/titleCredits/itemFont.attrmap"
colorid_creditsNumbers:          incbin "gfx/titleCredits/creditsNumbers.attrmap"
colorid_creditsSprTilesVaria:    incbin "gfx/titleCredits/creditsSprTilesVaria.attrmap"
colorid_creditsSprTilesSuitless: incbin "gfx/titleCredits/creditsSprTilesSuitless.attrmap"
colorid_theEnd:                  incbin "gfx/titleCredits/theEnd.attrmap"

gfxInfo_titleScreen: db BANK(gfx_titleScreen)
    dw gfx_titleScreen, vramDest_titleChr, $0b70, colorid_titleScreen

gfxInfo_creditsFont: db BANK(gfx_creditsFont)
    dw gfx_creditsFont, vramDest_creditsFont, $0200, colorid_creditsFont

gfxInfo_itemFont: db BANK(gfx_itemFont)
    dw gfx_itemFont, vramDest_itemFont, $0200, colorid_itemFont

gfxInfo_creditsNumbers: db BANK(gfx_creditsNumbers)
    dw gfx_creditsNumbers, vramDest_creditsNumbers, $0200, colorid_creditsNumbers

gfxInfo_creditsSprTilesVaria: db BANK(gfx_creditsSprTilesVaria)
    dw gfx_creditsSprTilesVaria, vramDest_creditsSpriteChr, $0be0, colorid_creditsSprTilesVaria

gfxInfo_creditsSprTilesSuitless: db BANK(gfx_creditsSprTilesSuitless)
    dw gfx_creditsSprTilesSuitless, vramDest_creditsSpriteChr, $08e0, colorid_creditsSprTilesSuitless

gfxInfo_theEnd: db BANK(gfx_theEnd)
    dw gfx_theEnd, vramDest_theEnd, $0100, colorid_theEnd


; 05:5B34 -- Title screen tilemap
titleTilemap: incbin "gfx/titleCredits/titleScreen_add80.tilemap", $20, $20*17 + 20
titleAttrmap: incbin "gfx/titleCredits/titleScreen.attrmap", $20, $20*17 + 20

;------------------------------------------------------------------------------
; Draw two digits of ending timer
credits_drawTimerDigits: ;{ 05:4000
    ; Temp storage for timer number
    ldh [hTemp.b], a
    ; Extract the tens digit
    swap a
    ; Adjust the value for display
    rlca
    or $e1
    dec a
    call credits_drawOneDigit
    ; Reload timer value from temp
    ldh a, [hTemp.b]
    ; Adjust the value for display
    rlca
    or $e1
    dec a
    ; fallthrough

;------------------------------------------------------------------------------
; Draw one digit of ending timer
credits_drawOneDigit: ;{ 05:4015
    ; Temp storage for the digit to be displayed
    ldh [hTemp.a], a
    ; HL = oam buffer pointer
    ld h, HIGH(wram_oamBuffer)
    ldh a, [hOamBufferIndex]
    ld l, a
    ; Write y pixel
    ldh a, [hSpriteYPixel]
    ld [hl+], a
    ; Write x pixel
    ldh a, [hSpriteXPixel]
    ld [hl+], a
    ; Increment X pixel position for next digit
    add $08
    ldh [hSpriteXPixel], a
    ; Reload tile number from temp, write tile number
    ldh a, [hTemp.a]
    ld [hl+], a
    ; Write sprite attribute
    ldh a, [hSpriteAttr]
    ld [hl+], a
    ; Store final value of oam index
    ld a, l
    ldh [hOamBufferIndex], a
ret ;}

;------------------------------------------------------------------------------
; VBlank subroutine called during credits
VBlank_drawCreditsLine: ;{ 05:403D
    ; Load credits text pointer
    ld a, [credits_textPointerLow]
    ld l, a
    ld a, [credits_textPointerHigh]
    ld h, a
    ; Load tilemap destination pointer
    ld a, [pTilemapDestLow]
    ld e, a
    ld a, [pTilemapDestHigh]
    ld d, a
    ; Enable SRAM to access credits text
    ld a, $0a
    ld [$0000], a
    ; Check if newline
    ld a, [hl]
    cp $f1
    jr z, .else
        ; Write normal line
        ld b, $14
        .writeLineLoop:
            ld a, [hl+] ; Load character
            sub $21 ; Adjust character encoding to ASCII
            ld [de], a ; Write character
            inc de
            dec b
        jr nz, .writeLineLoop
        jr .endIf
    .else:
        ; Write a blank line
        ld b, $14
        .writeBlankLoop:
            ld a, $ff
            ld [de], a
            inc de
            dec b
        jr nz, .writeBlankLoop
        ; Increment credits text pointer to next byte
        inc hl
    .endIf:

    ; Disable SRAM
    ld a, $00
    ld [$0000], a
    ; Store new value of credits text pointer
    ld a, l
    ld [credits_textPointerLow], a
    ld a, h
    ld [credits_textPointerHigh], a
    ; Clear ready flag
    xor a
    ld [credits_nextLineReady], a

    call OAM_DMA
ret ;}

;------------------------------------------------------------------------------
; called by gameMode_boot
loadTitleScreen: ;{ 05:408F
    ld hl, gfxInfo_titleScreen
    call VBlank_copyGfxInfo

    ; Load title tilemap
    ld de, _SCRN0
    ld hl, titleTilemap
    ld bc, $0400
    call copyToVram

    ld a, $ff
    ldh [rVBK], a ; vram bank color spec

    ld de, _SCRN0
    ld hl, titleAttrmap
    ld bc, $0400
    call copyToVram

    xor a
    ldh [rVBK], a ; restore vram bank
    
    ; Draw II overlap
    ld a, $44
    ldh [hSpriteXPixel], a
    ld a, $74
    ldh [hSpriteYPixel], a
    ld a, $1d
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall

    ; Load "Save" text
    ld hl, saveTextTilemap
    ld de, vramDest_itemText
    ld bc, $0014
    call copyToVram
    
    call VBlank_loadDefaultHud

    ; Initialize window position
    ld a, $07
    ldh [rWX], a
    ld a, $88
    ldh [rWY], a
    ; Reset scroll
    xor a
    ld [scrollY], a
    ; Enable rendering (window disabled)
    ld a, $c3
    ldh [rLCDC], a
    ; Play title music
    ld a, $11
    ld [songRequest], a
    ; Clear variables
    xor a
    ld [title_unusedD039], a
    ld [title_clearSelected], a
    
    ; If loading from a file, have the Clear option be selected? Odd.
    ld a, [loadingFromFile]
    and a
    jr z, .endIf
        ld a, $01
        ld [title_clearSelected], a
    .endIf:

    ; Set countdown timer to max for flashing effect
    ld a, $ff
    ld [countdownTimerHigh], a
    ld [countdownTimerLow], a
    ; Set game mode to title
    ld a, $01
    ldh [gameMode], a
ret ;}

VBlank_loadDefaultHud:
    ; Load HUD
    ld hl, hudBaseTilemap
    ld de, vramDest_statusBar
    ld bc, $0014
    call copyToVram

    ld a, $ff
    ldh [rVBK], a ; vram bank color spec
    
    ; set color of hud
    ld hl, hudBaseColor
    ld de, vramDest_statusBar
    ld bc, $0014
    call copyToVram

    ; set item text color to 7
    ld hl, vramDest_itemText
    ld c, $14
def hudItemTextColor = @ + $0001 ; im reusing that $87 value in HBlank_loadDefaultHud, this may be unconventional
    ld a, $87
    .writeLineLoop:
        ld [hl+], a
        dec c
    jr nz, .writeLineLoop

    xor a
    ldh [rVBK], a ; restore vram bank
ret

HBlank_loadDefaultHud:
    ; Load HUD
    ld hl, hudBaseTilemap
    ld de, vramDest_statusBar
    ld bc, $0014
    call HBlank_copyToVram

    ld a, $ff
    ldh [rVBK], a ; vram bank color spec
    
    ; set color of hud
    ld hl, hudBaseColor
    ld de, vramDest_statusBar
    ld bc, $0014
    call HBlank_copyToVram

    ; set item text color to 7
    ; copy the value from VBlank_loadDefaultHud over
    ld hl, hudItemTextColor
    ld de, vramDest_itemText
    ld bc, $0001
    call HBlank_copyToVram
    ; smear it over the whole line of tiles
    ld hl, vramDest_itemText
    ld de, vramDest_itemText + 1
    ld bc, $0014 - $0001
    call HBlank_copyToVram

    xor a
    ldh [rVBK], a ; restore vram bank
ret

hudBaseTilemap:  ; 05:40F0
    db $9D, $9D, $9D, $9D, $9D, $9E, $A9, $A9, $AF, $9F, $9E, $A9, $A9, $A9, $AF, $FF, $FF, $9E, $A9, $A9
hudBaseColor:
    db $86, $86, $86, $86, $86, $87, $87, $87, $87, $86, $87, $87, $87, $87, $87, $86, $A6, $87, $87, $87
saveTextTilemap: ; 05:4104
    db $FF, $D2, $C0, $D5, $C4, $DE, $DF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
;------------------------------------------------------------------------------
titleScreenRoutine: ;{ 05:4118
;{ Title display logic
    call OAM_clearTable

; Handle flashing
    ; Set default palette
    ld a, $01
    ld [screenFlashGBC], a
    ; Jump ahead if the lower 2 bits of the high byte aren't clear
    ld a, [countdownTimerHigh]
    and %00000011 ;$03
    jr nz, .endIf_A
        ; Jump ahead if the lower byte isn't less than $10
        ld a, [countdownTimerLow]
        cp $10
        jr nc, .endIf_A
            ; Only set the palette every other frame
            bit 1, a
            jr z, .endIf_A
                ; Flash
                ld a, $82
                ld [screenFlashGBC], a
    .endIf_A:

; Handle logic and drawing of the title star
    ; if starX < 3 then don't move it
    ld a, [titleStarX]
    cp $03
    jr c, .endIf_B
        ; Move left
        sub $02
        ld [titleStarX], a
        ; Move down
        ld a, [titleStarY]
        add $01
        ld [titleStarY], a
        ; Pointless jump (evidence of a commented out else branch?)
        jr .endIf_B
    .endIf_B:

    ; Try respawning the title star
    ; if rDIV != frameCounter, skip ahead
    ldh a, [rDIV]
    ld b, a
    ldh a, [frameCounter]
    cp b
    jr nz, .endIf_C
        ; If frame is odd, skip ahead
        and $01
        jr nz, .endIf_C
            ; Reset position of star
            ; Y position is essentially random
            ld a, b
            ld [titleStarY], a
            ; Move to right side
            ld a, $ff
            ld [titleStarX], a
    .endIf_C:

   ; Draw the title star
    ld a, [titleStarY]
    ldh [hSpriteYPixel], a
    ld a, [titleStarX]
    ldh [hSpriteXPixel], a
    ; Get the base sprite number
    ld a, $06
    ldh [hSpriteId], a
    ; Toggle the lower bit of the sprite priority bit regularly -- but this does nothing??
    ;  Perhaps the original intent was to have the sprite flicker between sprites $06 and $05
    ldh a, [frameCounter]
    and %00000010
    srl a
    ldh [hSpriteAttr], a
    call drawNonGameSprite_longCall

; Draw cursor
    ; Set Y position
    ld a, $74 ; Aligned with START text (normal height)
    ldh [hSpriteYPixel], a
    ; Check if the clear option is selected
    ld a, [title_clearSelected]
    and a
    jr z, .endIf_D
        ld a, $80 ; Aligned with CLEAR text
        ldh [hSpriteYPixel], a
    .endIf_D:

    ; Set x position and attributes
    ld a, $38
    ldh [hSpriteXPixel], a
    xor a
    ldh [hSpriteAttr], a
    ; Get animation frame for cursor
    ;  Animate every 4 frames using two bits from the frame counter
    ldh a, [frameCounter]
    and %00001100
    srl a
    srl a
    ld e, a
    ld d, $00
    ld hl, titleCursorTable
    add hl, de
    ld a, [hl]
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall

; Draw sprite for save number
    ld a, [activeSaveSlot]
    add $23
    ldh [hSpriteId], a
    ; Y position is same as the cursor
    ; Also, the number sprites have a ridiculous baked-in x-offset
    call drawNonGameSprite_longCall

; Draw II overlap
    ld a, $44
    ldh [hSpriteXPixel], a
    ld a, $74
    ldh [hSpriteYPixel], a
    ld a, $1d
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall

; Draw the start text
    ld a, $00
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall

; Draw the clear text
    ; Check if it's available
    ld a, [title_showClearOption]
    and a
    jr z, .endIf_E
        ; Show "Clear" text
        ld a, $80
        ldh [hSpriteYPixel], a
        ld a, $01
        ldh [hSpriteId], a
        call drawNonGameSprite_longCall
    .endIf_E:
    call title_clearUnusedOamSlots
;} End of display logic for title

;{ Title input logic
    ; Toggle clear option when select is pressed
    ldh a, [hInputRisingEdge]
    cp PADF_SELECT
    jr nz, .endIf_F
        ; Play sound effect
        ld a, $15
        ld [sfxRequest_square1], a
        ; Toggle flag
        ld a, [title_showClearOption]
        xor $ff
        ld [title_showClearOption], a
    .endIf_F:

    ; If right is pressed, increment save slot
    ldh a, [hInputRisingEdge]
    cp PADF_RIGHT
    jr nz, .endIf_G
        ldh a, [hInputPressed]
        cp PADF_RIGHT
        jr nz, .endIf_G
            ; Play sound effect
            ld a, $15
            ld [sfxRequest_square1], a
            ; Increment slot number
            ld a, [activeSaveSlot]
            inc a
            ld [activeSaveSlot], a
            ; Wrap back to zero
            cp $03
            jr nz, .endIf_G
                xor a
                ld [activeSaveSlot], a
    .endIf_G:

    ; If left is pressed, decrement save slot
    ldh a, [hInputRisingEdge]
    cp PADF_LEFT
    jr nz, .endIf_H
        ldh a, [hInputPressed]
        cp PADF_LEFT
        jr nz, .endIf_H
            ; Play sound effect
            ld a, $15
            ld [sfxRequest_square1], a
            ; Decrement slot number
            ld a, [activeSaveSlot]
            dec a
            ld [activeSaveSlot], a
            ; Wrap around to slot 3
            cp $ff
            jr nz, .endIf_H
                ld a, $02
                ld [activeSaveSlot], a
    .endIf_H:

    ; You must hold down for clear to be selected
    xor a
    ld [title_clearSelected], a
    ; Don't bother if the option isn't shown
    ld a, [title_showClearOption]
    and a
    jr z, .endIf_I
        ; Check if down is pressed
        ldh a, [hInputPressed]
        bit PADB_DOWN, a
        jr z, .endIf_I
            ; Set flag
            ld a, $01
            ld [title_clearSelected], a
            ; Check edge of input
            ldh a, [hInputRisingEdge]
            bit PADB_DOWN, a
            jr z, .endIf_I
                ; Play sound effect
                ld a, $15
                ld [sfxRequest_square1], a
    .endIf_I:

    ; Exit title routine if start is not pressed
    ldh a, [hInputRisingEdge]
    cp PADF_START
        ret nz
;} End of title input logic

    ; Clear debug flag
    xor a
    ld [debugFlag], a
    ; Flash
    ld a, $01
    ld [screenFlashGBC], a
    ; Check if save is being deleted
    ld a, [title_clearSelected]
    and a
        jr nz, .clearSaveBranch

    ; Play sound
    ld a, $15
    ld [sfxRequest_square1], a
    ; Play Samus fanfare
    ld a, $12
    ld [songRequest], a

    ; Initialize flag to loading a new game
    xor a
    ld [loadingFromFile], a
    ; Enable SRAM
    ld a, $0a
    ld [$0000], a
    
; Check magic number
    ; WARNING: THIS CODE IS COMPLETELY BUSTED AND ONLY WORKS ON ACCIDENT.
    ; Explanation: This routine should check if the magic number in the
    ;  save file matches the one in the ROM. In practice, only the first
    ;  byte of the magic number needs to be correct. 
    ; 
    ; The `cp $08` after the comparison loop makes me think that that loop
    ;  is supposed to count the number of matching bytes between the two
    ;  magic numbers (since both should have a length of 8). However, no
    ;  such counting takes place, and the comparison is merely done against
    ;  whatever happened to be the last byte that loaded from the ROM instead.
    ;
    ; Thus:
    ; - This only prevents invalid save files from being loaded because the
    ;    first byte of the magic number ($01) happens to be less than $08.
    ; - This only allows valid save files to be loaded because the byte
    ;    immediately after the magic number in ROM ($0F) happens to be
    ;    greater than $08.
    ;
    ; In other words, you could easily break this code on accident.
    ;
    ; For a fun creepypasta, take an uninitialized SRAM, and modify the 
    ;  first byte of one of the save files ($A000, $A040, or $A080) to be $01.
    
    ld hl, saveFile_magicNumber
    ; Get base address of save slot
    ; de = $A000 + (activeSaveSlot * $40)
    ld a, [activeSaveSlot]
    sla a
    sla a
    swap a
    ld e, a
    ld d, HIGH(saveData_baseAddr) ;$A0
    ; Loop until we find a mismatch between the magic number in ROM and the save slot
    .checkLoop:
        ld a, [hl+]
        ld b, a
        ld a, [de]
        inc de
        cp b
    jr z, .checkLoop
    ; Check if the last byte read from ROM was greater than $08
    ld a, b
    cp $08
    jr c, .endIf_J
        ld a, $ff
        ld [loadingFromFile], a
    .endIf_J:

    ; Save the last save slot used
    ld a, [activeSaveSlot]
    ld [saveLastSlot], a
    ; Disable SRAM
    ld a, $00
    ld [$0000], a
    ; New game
    ld a, $0b
    ldh [gameMode], a
    ; If loading from a file, ignore the game mode being set to new game
    ld a, [loadingFromFile]
    and a
        ret z
    ; Load from file
    ld a, $0c
    ldh [gameMode], a
ret

.clearSaveBranch:
    ; Play sound effect
    ld a, $0f
    ld [sfxRequest_noise], a
    ; Get base address of save slot
    ; de = $A000 + (activeSaveSlot * $40)
    ld a, [activeSaveSlot]
    sla a
    sla a
    swap a
    ld l, a
    ld h, HIGH(saveData_baseAddr) ; $A0
    ; Enable SRAM
    ld a, $0a
    ld [$0000], a
    ; Erase first two bytes (part w/the magic number)
    xor a
    ld [hl+], a
    ld [hl], a
    ; Disable SRAM
    ld [$0000], a
    ; Get rid of the clear option
    xor a
    ld [title_showClearOption], a
ret
;}

;------------------------------------------------------------------------------
; Note: This doesn't contain the weird bookkeeping optimization that the OAM clearing routine in bank 1 has
title_clearUnusedOamSlots: ;{ 05:42D4
    ; Zero out all OAM values
    ld h, HIGH(wram_oamBuffer)
    ldh a, [hOamBufferIndex]
    ld l, a
    .clearLoop:
        xor a
        ld [hl+], a
        ld a, l
        cp OAM_MAX
    jr c, .clearLoop
ret
;}

;------------------------------------------------------------------------------
; Used by title
titleCursorTable: ; 05:42E1
    db $02, $03, $04, $03

;------------------------------------------------------------------------------
; Game Mode $13 - Credits
creditsRoutine:: ;{ 05:55A3
    ; Set sprite pixel to Samus' position
    ldh a, [hSamusYPixel]
    ldh [hSpriteYPixel], a
    ldh a, [hSamusXPixel]
    ldh [hSpriteXPixel], a

    call credits_animateSamus
    call credits_scrollHandler
    call credits_drawTimer
    call credits_moveStars
    call credits_drawStars
    call title_clearUnusedOamSlots
ret
;}

credits_drawTimer: ;{ 05:55BE
    ; Check if credits are done
    ld a, [credits_scrollingDone]
    and a
        ret z
    ; Draw hours
    ld a, $88
    ldh [hSpriteYPixel], a
    ld a, $42
    ldh [hSpriteXPixel], a
    ld a, [gameTimeHours]
    call credits_drawTimerDigits
    ; Draw minutes
    ld a, $56
    ldh [hSpriteXPixel], a
    ld a, [gameTimeMinutes]
    call credits_drawTimerDigits
ret
;}

credits_moveStars: ;{ 05:55DC - Move the stars during the credits
    ; Iterate through all 16 stars
    ld hl, credits_starArray
    ld b, $10
    .starLoop:
        ; Move down every 4th frame
        ldh a, [frameCounter]
        and $03
        jr nz, .endIf_A
            ; move down one pixel
            ld a, [hl]
            add $01
            ld [hl], a
            ; Loop stars back to the top
            cp $a0
            jr c, .endIf_A
                ld a, $10
                ld [hl], a
        .endIf_A:
        
        ; Get x coordinate
        inc hl
        ; Move left every frame
        ld a, [hl]
        sub $01
        ld [hl], a
        ; Once the stars reach the left edge
        cp $f8
        jr c, .endIf_B
            ; Warp them back to the right edge
            ld a, $a8
            ld [hl], a
        .endIf_B:
        
        ; Get y coordinate of next star
        inc hl
        ; Check loop counter
        dec b
    jr nz, .starLoop
ret
;}

credits_drawStars: ;{ 05:5603 - Draw stars to the OAM buffer during credits
    ; Iterate through all 16 stars
    ld hl, credits_starArray
    ld b, $10
    .starLoop:
        ; Load y pos and x pos of star
        ld a, [hl+]
        ldh [hSpriteYPixel], a
        ld a, [hl+]
        ldh [hSpriteXPixel], a
        ; LSB of loop counter determines if star graphic is $1B or $1C
        ld a, b
        and $01
        add $1b
        ldh [hSpriteId], a
        ; push/pop variables to avoid clobbering
        push hl
        push bc
            call drawNonGameSprite_longCall
        pop bc
        pop hl
        ; Check loop counter
        dec b
    jr nz, .starLoop
ret
;}

;------------------------------------------------------------------------------
; Animate Samus during credits
credits_animateSamus: ;{ 05:5620
    ld a, [credits_samusAnimState]
    or a
        jp z, .standingStart
    cp $01
        jp z, .running
    cp $03
        jp z, .spinRising
    cp $04
        jr z, .spinFalling
    cp $12
        jr z, .untying_frameM
    cp $14
        jr z, .suited_standingEnd
    cp $15
        jr z, .hairWaving


; Animation state functions {
.default: ; $06 - Draw Suitless Samus standing (hair up, hands down)
    sub $05
    ld e, a
    ld d, $00
    ld hl, .samusTable
    add hl, de
    ld a, [hl]
    call credits_drawSamus
    ; Wait for timer to expire
    ld a, [countdownTimerLow]
    and a
        ret nz
    ; Set timer for next state
    ld hl, .nextCountdownTable
    ld a, [credits_samusAnimState]
    sub $05
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl]
    ld [countdownTimerLow], a
    ; Increment state
    ld a, [credits_samusAnimState]
    inc a
    ld [credits_samusAnimState], a
ret

.hairWaving: ; $15 - Animate Suitless Samus's hair flowing
    ; Animate every 16th frame
    ldh a, [frameCounter]
    and $10
    swap a
    ; Add 0 or 1 to this base index of the hair waving animation
    add $13
    call credits_drawSamus
ret

.suited_standingEnd: ; $14 - Draw Suited Samus standing
    ; Stand forever
    ld a, $0a
    call credits_drawSamus
ret

.untying_frameM: ; $12 - Draw suitless Samus unfurling her hair (frame 3)
    ld a, $12
    call credits_drawSamus
    ; Wait for timer to expire
    ld a, [countdownTimerLow]
    and a
        ret nz
    ; Set next state to hair waving
    ld a, $15
    ld [credits_samusAnimState], a
ret

.spinFalling: ; $04 - Draw Samus spin jumping (falling)
    ; Move down
    ldh a, [hSamusYPixel]
    add $03
    ldh [hSamusYPixel], a
    ; Frame to Render = 4 + (frameCounter mod 4)
    ldh a, [frameCounter]
    and $03
    add $04
    call credits_drawSamus
    ; Detect when Samus hits the ground (what ground?)
    ldh a, [hSamusYPixel]
    and $fc ; Ignore the lower bits to give some leeway
    cp $60
        ret nz

    ; Set timer for next state
    ld a, $20
    ld [countdownTimerLow], a
    ; Select ending
    ld a, [gameTimeHours]
    cp $03
    jr nc, .else_A
        ; Best ending - Suitless kneeling -> hair untying
        ld a, [credits_samusAnimState]
        inc a
        ld [credits_samusAnimState], a

        ld hl, gfxInfo_creditsSprTilesSuitless
        jp HBlank_copyGfxInfo
    .else_A:
        ; Second best - Suited kneeling -> suited standing
        ld a, $13
        ld [credits_samusAnimState], a
        ret
; end state

.spinRising: ; $03 - Draw Samus spin jumping (rising)
    ; Move Samus up until she reaches a certain point
    ldh a, [hSamusYPixel]
    and $f0 ; Ignore the lower bits to give some leeway
    cp $e0
    jr z, .endIf_B
        ; Move up
        ldh a, [hSamusYPixel]
        sub $03
        ldh [hSamusYPixel], a
    .endIf_B:
    ; Frame to Render = 4 + (frameCounter mod 4)
    ldh a, [frameCounter]
    and $03
    add $04
    call credits_drawSamus
    ; Wait for timer to expire
    ld a, [countdownTimerLow]
    and a
        ret nz
    ; Increment state to falling
    ld a, [credits_samusAnimState]
    inc a
    ld [credits_samusAnimState], a
ret

.standingStart: ; $00 - Draw suited Samus standing
    ld a, $0a
    call credits_drawSamus
    ; Worst ending (>= 7 hours) - Samus only stands
    ld a, [gameTimeHours]
    cp $07
        ret nc
    ; Wait for timer to expire ($FF frames, as set in prepareCreditsRoutine)
    ld a, [countdownTimerLow]
    and a
        ret nz

    ; Initialize counters for running animation
    xor a
    ld [credits_runAnimCounter], a
    xor a
    ld [credits_runAnimFrame], a
    ; Set timer to $1200 (4608 frames, or 76.8 seconds)
    ld a, $12
    ld [countdownTimerHigh], a
    ; Increment state to running
    ld a, [credits_samusAnimState]
    inc a
    ld [credits_samusAnimState], a
ret

.running: ; $01 - Draw Samus running
    ; Increment counter between animation frames
    ld a, [credits_runAnimCounter]
    inc a
    ld [credits_runAnimCounter], a
    cp $06
    jr c, .endIf_C
        ; Reset counter
        xor a
        ld [credits_runAnimCounter], a
        ; Increment frame being displayed (in range 0-3)
        ld a, [credits_runAnimFrame]
        inc a
        ld [credits_runAnimFrame], a
        cp $04
        jr nz, .endIf_C
            ld a, $00
            ld [credits_runAnimFrame], a
    .endIf_C:

    ld a, [credits_runAnimFrame]
    call credits_drawSamus

    ; Second-worst ending: (between 5 and 7 hours)
    ; - Samus never stops running, so we never move on from this animation procedure
    ld a, [gameTimeHours]
    cp $05
        ret nc
    ; Keep running until credits stop
    ld a, [credits_scrollingDone]
    and a
        ret z

    ; Set timer for next state to $0040
    xor a
    ld [countdownTimerLow], a ; Should be countdownTimerHigh
    ld a, $40
    ld [countdownTimerLow], a
    ; Set anim state to jumping
    ld a, [credits_samusAnimState]
    inc a
    inc a
    ld [credits_samusAnimState], a
ret

; sub $05
.samusTable:
    db $09, $0b, $0c, $0d, $0c, $0b, $0e, $0b, $0f, $0b, $0e, $10, $11, $ff, $08
.nextCountdownTable:
    db $30, $08, $10, $08, $08, $08, $08, $08, $08, $0a, $0a, $0a, $20, $ff, $00
;}
;}

;------------------------------------------------------------------------------

; Game Mode $12 - Prepare Credits
prepareCredits: ;{ 05:587F
    ; countdownTimer is set to $FF by missile refill
    ld a, [countdownTimerLow]
    and a
    jr z, .endIf_A
        ; fadeInColorTimer = floor(8.5 - countdownTimerLow / 32.0)
        cpl
        swap a
        and $0f
        inc a
        rra
        ld [fadeInColorTimer], a

        ; Fadeout until countdown timer reaches $0E
        ld a, [countdownTimerLow]
        cp $0e
            ret nc
        ; Clear timer
        xor a
        ld [countdownTimerLow], a
        ; Remove the low health beep sound
        ld a, $ff
        ld [sfxRequest_lowHealthBeep], a
    .endIf_A:
    
    ; Disable LCD
    ld a, $03
    ldh [rLCDC], a

    call clearTilemaps    
    ; Clear OAM buffer
    ld hl, wram_oamBuffer + $FF ; $C0FF
    ld a, $ff
    ld c, $01
    ld b, $00
    .loop_A:
            ld [hl-], a
            dec b
        jr nz, .loop_A
        dec c
    jr nz, .loop_A

    ld hl, palettes_Credits
    call loadColors_farCall

    ; Load various graphics
    ld hl, gfxInfo_creditsFont
    call VBlank_copyGfxInfo

    ld hl, gfxInfo_creditsSprTilesVaria
    call VBlank_copyGfxInfo

    ld hl, gfxInfo_theEnd
    call VBlank_copyGfxInfo

    ld hl, gfxInfo_creditsNumbers
    call VBlank_copyGfxInfo

    ; Initialize credits text pointer
    ld a, LOW(creditsTextBuffer)
    ld [credits_textPointerLow], a
    ld a, HIGH(creditsTextBuffer)
    ld [credits_textPointerHigh], a
    
    ; Clear unused variable
    xor a
    ld [credits_unusedVar], a
    ld [fadeInColorTimer], a
    
    ; Initialize star array
    ld hl, credits_starPositions
    ld de, credits_starArray
    ld b, $10 ; Should be $20, however, this causes some stars to visibly drop in and out
    .loop_B:
        ld a, [hl+]
        ld [de], a
        inc de
        dec b
    jr nz, .loop_B

    call loadCreditsText

    ; Reset scroll
    xor a
    ld [scrollY], a
    ld [scrollX], a

    ; Reactivate display
    ld a, $c3 | LCDCF_OBJ16
    ldh [rLCDC], a

    ; Set timer for initial animation state (standing still in suit)
    ld a, $ff
    ld [countdownTimerLow], a
    ; Set Samus' position
    ld a, $60
    ldh [hSamusYPixel], a
    ld a, $88
    ldh [hSamusXPixel], a
    ; Play credits music
    ld a, $13
    ld [songRequest], a
    ; Init animation state
    xor a
    ld [credits_samusAnimState], a
    ; Move to credits game mode
    ldh a, [gameMode]
    inc a
    ldh [gameMode], a
ret
;}


;------------------------------------------------------------------------------
; Lets VBlank_drawCreditsLine know when another line is ready to be displayed
credits_scrollHandler: ;{ 05:593E
    ; Load credits text pointer
    ld a, [credits_textPointerLow]
    ld l, a
    ld a, [credits_textPointerHigh]
    ld h, a
    ; Enable SRAM
    ld a, $0a
    ld [$0000], a
    ; Load character
    ld a, [hl]
    ld b, a
    ; Disable SRAM
    ld a, $00
    ld [$0000], a
    ; Check if we're at the end of the credits
    ld a, b
    cp $f0
    jr nz, .else
        ld a, $01
        ld [credits_scrollingDone], a
        ret
    .else:
        ld a, [credits_scrollYSubpixels]
        add $4a
        ld [credits_scrollYSubpixels], a
        ret nc ; return from caller function

        ld a, [scrollY]
        inc a
        ld [scrollY], a
        and $07
        ret nz

        ld a, [scrollY]
        add $a0
        ld [tileY], a
        ld a, $08
        ld [tileX], a
        call getTilemapAddress
        ld a, $ff
        ld [credits_nextLineReady], a
        ret
;} end proc

;------------------------------------------------------------------------------
credits_drawSamus: ;{ 05:5989
    cp $02
        jr z, .run_frameC
    cp $03
        jr z, .run_frameD

; Functions called by table {
    ld hl, .data_table
    rlca
    ld e, a
    ld d, $00
    add hl, de
    ld a, [hl+]
    ld e, a
    ld a, [hl]
    ld h, a
    ld l, e
    .loop:
        ld a, [hl+]
        cp $FF
            ret z

        ldh [hSpriteId], a
        push hl
        call drawNonGameSprite_longCall
        pop hl
    jr .loop


.run_frameC:
    ld a, $0a
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall
    ; Flip bottom, adjust position
    ld a, OAMF_XFLIP
    ldh [hSpriteAttr], a
    ldh a, [hSpriteXPixel]
    dec a
    ldh [hSpriteXPixel], a
    ld a, $0b
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall
    ; Clear flip
    xor a
    ldh [hSpriteAttr], a
ret

.run_frameD:
    ld a, $09
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall
    ; Flip bottom
    ld a, OAMF_XFLIP
    ldh [hSpriteAttr], a
    ld a, $0c
    ldh [hSpriteId], a
    call drawNonGameSprite_longCall
    ; Clear flip
    xor a
    ldh [hSpriteAttr], a
ret

.data_table:
    dw .data_run_frameA ; 00 - Samus running
    dw .data_run_frameB ; 01 - Samus running 
    dw $0000 ; 02 - Samus running
    dw $0000 ; 03 - Samus running
    
    dw .data_jump_frameA ; 04 - Spin jump
    dw .data_jump_frameB ; 05 - Spin jump
    dw .data_jump_frameC ; 06 - Spin jump
    dw .data_jump_frameD ; 07 - Spin jump
    
    dw .data_suited_kneeling   ; 08 - Suited Samus kneeling (ready to jump)
    dw .data_suitless_kneeling ; 09 - Suitless Samus kneeling
    dw .data_suited_standing   ; 0A - Suited Samus standing
    
    dw .data_suitless_frameA ; 0B - Suitless Samus hair up, hand down
    dw .data_suitless_frameB ; 0C - Suitless Samus reaching up to hair
    dw .data_suitless_frameC ; 0D - Suitless Samus untying bun
    dw .data_suitless_frameD ; 0E - Suitless Samus head turned left
    dw .data_suitless_frameE ; 0F - Suitless Samus head turned right
    dw .data_suitless_frameF ; 10 - Suitless Samus hair unfurling 1
    dw .data_suitless_frameG_hairWaving_frameA ; 11 - Suitless Samus hair unfurling 2
    dw .data_suitless_frameH ; 12 - Suitless Samus hair unfurling 3
    
    dw .data_suitless_frameG_hairWaving_frameA ; 13 - Suitless Samus hair waving 1
    dw .data_hairWaving_frameB ; 14 - Suitless Samus hair waving 2

.data_run_frameA:
    db $08, $0b, $ff
.data_run_frameB:
    db $09, $0c, $ff
.data_jump_frameA:
    db $1f, $ff
.data_jump_frameB:
    db $20, $ff
.data_jump_frameC:
    db $21, $ff
.data_jump_frameD:
    db $22, $ff
.data_suited_standing:
    db $07, $ff
.data_suited_kneeling:
    db $12, $ff
.data_suitless_kneeling:
    db $11, $ff
.data_suitless_frameA:
    db $0e, $0f, $10, $ff
.data_suitless_frameB:
    db $0e, $13, $10, $ff
.data_suitless_frameC:
    db $14, $10, $ff
.data_suitless_frameD:
    db $15, $0f, $10, $ff
.data_suitless_frameE:
    db $16, $0f, $10, $ff
.data_suitless_frameF:
    db $17, $0f, $10, $ff
.data_suitless_frameG_hairWaving_frameA:
    db $18, $0f, $10, $ff
.data_suitless_frameH:
    db $19, $0f, $10, $ff
.data_hairWaving_frameB:
    db $1a, $0f, $10, $ff
;}
;}

; Set of initial positions for stars
credits_starPositions: ;{ 05:5B14
    ;  ( y, x )
    db $28, $90
    db $18, $70
    db $68, $30
    db $50, $88
    db $40, $18
    db $18, $20
    db $90, $68
    db $48, $40
;}

; 05:7F34

; 06:7920
creditsText: include "data/credits.asm"

bank5_freespace: ; 05:7Fxx