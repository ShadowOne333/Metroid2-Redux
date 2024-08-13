; Disassembly of "m2 ejrtq v1.3.gbc"
; This file was created with:
; mgbdis v2.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $006", ROMX[$4000], BANK[$6]

; Patched in at runtime
gfx_cannonBeam:: incbin "gfx/samus/cannonBeam.2bpp"
gfx_cannonMissile:: incbin "gfx/samus/cannonMissile.2bpp"

; These graphics are patched into VRAM when loading a save or collecting the item
gfx_beamIce:: incbin "gfx/samus/beamIce.2bpp"
gfx_beamWave:: incbin "gfx/samus/beamWave.2bpp"
gfx_beamSpazer:: incbin "gfx/samus/beamSpazer.2bpp"	; Stub for an enterprising modder
gfx_beamPlasma:: incbin "gfx/samus/beamPlasma.2bpp"

gfx_hud:: INCBIN "gfx/samus/hud.2bpp", $b0

; 06:4320 - Power suit and common sprite graphics
gfx_samusPowerSuit:: INCBIN "gfx/samus/samusPowerSuit.2bpp"

; 06:4E20
gfx_samusVariaSuit:: incbin "gfx/samus/samusVariaSuit.2bpp"

; 06:5920 - Enemy graphics pages -- 64 tiles each
gfx_enemiesA::   incbin "gfx/enemies/enemiesA.2bpp",0,$400
gfx_enemiesB::   incbin "gfx/enemies/enemiesB.2bpp",0,$400
gfx_enemiesC::   incbin "gfx/enemies/enemiesC.2bpp",0,$400
gfx_enemiesD::   incbin "gfx/enemies/enemiesD.2bpp",0,$400
gfx_enemiesE::   incbin "gfx/enemies/enemiesE.2bpp",0,$400
gfx_enemiesF::   incbin "gfx/enemies/enemiesF.2bpp",0,$400
gfx_arachnus::   incbin "gfx/enemies/arachnus.2bpp",0,$400
gfx_surfaceSPR:: incbin "gfx/enemies/surfaceSPR.2bpp",0,$400 

colorid_enemiesA::    incbin "gfx/enemies/enemiesA.attrmap"
colorid_enemiesB::    incbin "gfx/enemies/enemiesB.attrmap"
colorid_enemiesC::    incbin "gfx/enemies/enemiesC.attrmap"
colorid_enemiesD::    incbin "gfx/enemies/enemiesD.attrmap"
colorid_enemiesE::    incbin "gfx/enemies/enemiesE.attrmap"
colorid_enemiesF::    incbin "gfx/enemies/enemiesF.attrmap"
colorid_arachnus::    incbin "gfx/enemies/arachnus.attrmap"
colorid_surfaceSPR::    incbin "gfx/enemies/surfaceSPR.attrmap"

colorid_cannonBeam::    incbin "gfx/samus/cannonBeam.attrmap"
colorid_cannonMissile::    incbin "gfx/samus/cannonMissile.attrmap"
colorid_beamIce::    incbin "gfx/samus/beamIce.attrmap"
colorid_beamWave::    incbin "gfx/samus/beamWave.attrmap"
colorid_beamSpazer::    incbin "gfx/samus/beamSpazer.attrmap"
colorid_beamPlasma::    incbin "gfx/samus/beamPlasma.attrmap"
colorid_hud::    incbin "gfx/samus/hud.attrmap", $b
colorid_samusPowerSuit::    incbin "gfx/samus/samusPowerSuit.attrmap"
colorid_samusVariaSuit::    incbin "gfx/samus/samusVariaSuit.attrmap"


gfxInfo_hud: db BANK(gfx_hud)
    dw gfx_hud, vramDest_hud, $0350, colorid_hud

gfxInfo_samusPowerSuit: db BANK(gfx_samusPowerSuit)
    dw gfx_samusPowerSuit, vramDest_samus, $07b0, colorid_samusPowerSuit


samus_onTheFlyGfx_tileIDPointerTable:
    dw samus_onTheFlyGfx_tileIDTable.FacingScreen
    dw samus_onTheFlyGfx_tileIDTable.StandingL
    dw samus_onTheFlyGfx_tileIDTable.StandingR
    dw samus_onTheFlyGfx_tileIDTable.StandingUpL
    dw samus_onTheFlyGfx_tileIDTable.StandingUpR
    dw samus_onTheFlyGfx_tileIDTable.Run1
    dw samus_onTheFlyGfx_tileIDTable.Run1ShootL
    dw samus_onTheFlyGfx_tileIDTable.Run1ShootR
    dw samus_onTheFlyGfx_tileIDTable.Run1ShootUpL
    dw samus_onTheFlyGfx_tileIDTable.Run1ShootUpR
    dw samus_onTheFlyGfx_tileIDTable.Run2
    dw samus_onTheFlyGfx_tileIDTable.Run2ShootL
    dw samus_onTheFlyGfx_tileIDTable.Run2ShootR
    dw samus_onTheFlyGfx_tileIDTable.Run2ShootUpL
    dw samus_onTheFlyGfx_tileIDTable.Run2ShootUpR
    dw samus_onTheFlyGfx_tileIDTable.Run3
    dw samus_onTheFlyGfx_tileIDTable.Run3ShootL
    dw samus_onTheFlyGfx_tileIDTable.Run3ShootR
    dw samus_onTheFlyGfx_tileIDTable.Run3ShootUpL
    dw samus_onTheFlyGfx_tileIDTable.Run3ShootUpR
    dw samus_onTheFlyGfx_tileIDTable.JumpL
    dw samus_onTheFlyGfx_tileIDTable.JumpR
    dw samus_onTheFlyGfx_tileIDTable.JumpUpL
    dw samus_onTheFlyGfx_tileIDTable.JumpUpR
    dw samus_onTheFlyGfx_tileIDTable.JumpDown
    dw samus_onTheFlyGfx_tileIDTable.CrouchL
    dw samus_onTheFlyGfx_tileIDTable.CrouchR
    dw samus_onTheFlyGfx_tileIDTable.Spin
    dw samus_onTheFlyGfx_tileIDTable.SpinScrew
    dw samus_onTheFlyGfx_tileIDTable.SpinSpace
    dw samus_onTheFlyGfx_tileIDTable.SpinSpaceScrew
    dw samus_onTheFlyGfx_tileIDTable.Ball
    dw samus_onTheFlyGfx_tileIDTable.BallSpring

; sets of tiles should be <= 14 tiles (excluding terminator byte $FF)
samus_onTheFlyGfx_tileIDTable:
    .FacingScreen: ;00
        db $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $FF
    .StandingL:
        db $16, $11, $17, $18, $19, $1A, $0B, $0C, $0D, $0E, $0F, $FF
    .StandingR:
        db $10, $11, $12, $13, $14, $15, $0B, $0C, $0D, $0E, $0F, $FF
    .StandingUpL:
        db $5E, $5F, $60, $61, $5C, $5D, $0B, $0C, $0D, $0E, $0F, $9E, $FF
    .StandingUpR: ;04
        db $58, $59, $5A, $5B, $5C, $5D, $0B, $0C, $0D, $0E, $0F, $9E, $FF
    .Run1:
        db $40, $41, $42, $43, $44, $46, $47, $48, $49, $4A, $4B, $4C, $FF
    .Run1ShootL:
        db $20, $21, $22, $23, $25, $46, $47, $48, $49, $4A, $4B, $4C, $FF
    .Run1ShootR:
        db $40, $41, $42, $43, $45, $46, $47, $48, $49, $4A, $4B, $4C, $FF
    .Run1ShootUpL: ;08
        db $5E, $5F, $60, $61, $FE, $46, $47, $48, $49, $4A, $4B, $4C, $9E, $FF
    .Run1ShootUpR:
        db $58, $59, $5A, $5B, $FE, $46, $47, $48, $49, $4A, $4B, $4C, $9E, $FF
    .Run2:
        db $30, $31, $32, $33, $FE, $34, $35, $36, $37, $38, $39, $3A, $3B, $FF
    .Run2ShootL:
        db $20, $21, $22, $23, $25, $34, $35, $36, $37, $38, $39, $3A, $3B, $FF
    .Run2ShootR: ;0C
        db $40, $41, $42, $43, $45, $34, $35, $36, $37, $38, $39, $3A, $3B, $FF
    .Run2ShootUpL:
        db $5E, $5F, $60, $61, $FE, $34, $35, $36, $37, $38, $39, $3A, $3B, $9E, $FF
    .Run2ShootUpR:
        db $58, $59, $5A, $5B, $FE, $34, $35, $36, $37, $38, $39, $3A, $3B, $9E, $FF
    .Run3:
        db $20, $21, $22, $23, $24, $26, $27, $28, $29, $FF
    .Run3ShootL: ;10
        db $20, $21, $22, $23, $25, $26, $27, $28, $29, $FF
    .Run3ShootR:
        db $40, $41, $42, $43, $45, $26, $27, $28, $29, $FF
    .Run3ShootUpL:
        db $5E, $5F, $60, $61, $FE, $26, $27, $28, $29, $9E, $FF
    .Run3ShootUpR:
        db $58, $59, $5A, $5B, $FE, $26, $27, $28, $29, $9E, $FF
    .JumpL: ;14
        db $16, $11, $17, $18, $2D, $2E, $4D, $3D, $3E, $3F, $FF
    .JumpR:
        db $10, $11, $12, $13, $2D, $2E, $2F, $3D, $3E, $3F, $FF
    .JumpUpL:
        db $5E, $5F, $60, $61, $2D, $4E, $4F, $3D, $3E, $3F, $9E, $FF
    .JumpUpR:
        db $58, $59, $5A, $5B, $2D, $4E, $4F, $3D, $3E, $3F, $9E, $FF
    .JumpDown: ;18
        db $50, $51, $52, $53, $2D, $54, $55, $56, $3D, $3E, $57, $FF
    .CrouchL:
        db $16, $11, $17, $18, $2B, $2C, $1D, $1E, $1F, $FF
    .CrouchR:
        db $10, $11, $12, $13, $1B, $1C, $1D, $1E, $1F, $FF
    .Spin:
        db $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $9E, $FF
    .SpinScrew: ;1C
        db $72, $73, $74, $75, $76, $77, $78, $79, $7A, $7B, $7C, $7D, $9E, $FF
    .SpinSpace:
        db $82, $83, $84, $85, $86, $87, $88, $89, $8A, $8B, $8C, $8D, $9E, $FF
    .SpinSpaceScrew:
        db $92, $93, $94, $95, $96, $97, $98, $99, $9A, $9B, $9C, $9D, $9E, $FF
    .Ball:
        db $6E, $6F, $70, $71, $8E, $8F, $90, $91, $FF
    .BallSpring: ;20
        db $7E, $7F, $80, $81, $8E, $8F, $90, $91, $FF


samus_onTheFlyGfx_loadGfx:
    ; get pointer to tileIDPointer
    ld hl, samus_onTheFlyGfx_tileIDPointerTable
    ld a, [samus_onTheFlyGfx_indexNew]
    sla a
    ld e, a
    ld d, $00
    add hl, de
    
    ; load tileIDPointer into bc
    ld a, [hl+]
    ld c, a
    ld a, [hl]
    ld b, a

    ; transfer tiles to buffer
    ld a, HIGH(samus_gfxInfoBuffer)
    ldh [hTemp.a], a
    ld a, LOW(samus_gfxInfoBuffer)
    ldh [hTemp.b], a

    ld hl, gfx_samusPowerSuit
    ld de, colorid_samusPowerSuit
    ld a, [samusItems]
    and itemMask_varia
    jr z, .noVaria
        ld hl, gfx_samusVariaSuit
        ld de, colorid_samusVariaSuit
    .noVaria:
    xor a
    ld [samus_onTheFlyGfx_bufferSize], a

    .loop_tileToBuffer:
        ; a is tile id
        ld a, [bc]
        inc bc
        cp $ff
        jr z, .end_tileToBuffer

        push bc 
        push hl
            ; transfer color id to colorIDBuffer
            ; get color id address
            ld h, $00
            ld l, a
            add hl, de
            ldh [hTemp.c], a
            
            ; get current tile address for the right buffer in colorIDBuffer
            ld b, HIGH(colorIDBuffer)
            ld a, [samus_onTheFlyGfx_bufferSize]
            ld c, a
            ld a, [samusVRAMBuffer]
            swap a
            add c
            ld c, a

            ; write color id
            ld a, [hl]
            ld [bc], a
        pop hl
        push hl
            ; bc is tile id * $0010
            ldh a, [hTemp.c]
            swap a
            ld c, a
            and $0F
            ld b, a
            xor c
            ld c, a

            ; hl is now gfx_samus + bc, bc is freed for other purposes
            add hl, bc
            
            push de
            ; b is now a counter from $10 to $00, counts all 16 bytes of a tile
            ldh a, [hTemp.a]
            ld d, a
            ldh a, [hTemp.b]
            ld e, a
            ld b, $10
            .loop_byteToBuffer:
                ld a, [hl+]
                ld [de], a
                inc de
                dec b
            jr nz, .loop_byteToBuffer
            ld a, d
            ldh [hTemp.a], a
            ld a, e
            ldh [hTemp.b], a
            pop de

            ; tile is successfully transferred to buffer
        pop hl ; hl returns to gfx_samus
        pop bc ; bc returns to tileIDPointer

        ; add 1 to buffer size for each tile transferred
        ld a, [samus_onTheFlyGfx_bufferSize]
        inc a
        ld [samus_onTheFlyGfx_bufferSize], a
    jr .loop_tileToBuffer

    ; transfer of all tiles complete, prepare HBlank_DMAToVram
    .end_tileToBuffer:

    ; source is buffer
    ld hl, samus_gfxInfoBuffer
    ; destination is vram
    ld de, vramDest_samus
    ld a, [samusVRAMBuffer]
    add d
    ld d, a
    ; size is buffer size * $10
    ld b, $00
    ld a, [samus_onTheFlyGfx_bufferSize]
    swap a
    ld c, a

    jp HBlank_DMAToVram


spiderBallOrientationTable:: ;{ 06:7E03
; Given an input and a collision state, this produces a rotational direction for the spider ball
; - Note that this only considers cardinal directions. Perhaps, by adding 
;  data for diagonal directions, the controls of the spider ball could be improved
;
; Values
;  0: Don't move
;  1: Move counter-clockwise
;  2: Move clockwise
;       ______________________________________________ 0: No input
;      |   ___________________________________________ 1: Right
;      |  |   ________________________________________ 2: Left
;      |  |  |   _____________________________________ 3: X: R+L
;      |  |  |  |   __________________________________ 4: Up
;      |  |  |  |  |   _______________________________ 5: R+U
;      |  |  |  |  |  |   ____________________________ 6: L+U
;      |  |  |  |  |  |  |   _________________________ 7: X: R+L+U
;      |  |  |  |  |  |  |  |   ______________________ 8: Down
;      |  |  |  |  |  |  |  |  |   ___________________ 9: D+R
;      |  |  |  |  |  |  |  |  |  |   ________________ A: D+L
;      |  |  |  |  |  |  |  |  |  |  |   _____________ B: X: R+L+U
;      |  |  |  |  |  |  |  |  |  |  |  |   __________ C: X: U+D
;      |  |  |  |  |  |  |  |  |  |  |  |  |   _______ D: X: R+U+D
;      |  |  |  |  |  |  |  |  |  |  |  |  |  |   ____ E: X: L+U+D
;      |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   _ F: X: R+L+U+D
;      |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |

    ; IMPROVEMENT PATCH
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    0: In air     v
    db 0, 2, 1, 0, 1, 0, 1, 0, 2, 2, 0, 0, 0, 0, 0, 0 ;    1: Outside corner: Of left-facing wall and ceiling
    db 0, 1, 2, 0, 1, 1, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0 ;    2: Outside corner: Of left-facing wall and floor
    db 0, 0, 0, 0, 1, 1, 1, 0, 2, 2, 2, 0, 0, 0, 0, 0 ;    3: Flat surface:   Left-facing wall
    db 0, 2, 1, 0, 2, 2, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 ;    4: Outside corner: Of right-facing wall and ceiling
    db 0, 2, 1, 0, 0, 2, 1, 0, 0, 2, 1, 0, 0, 0, 0, 0 ;    5: Flat surface:   Ceiling
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    6: Unused:         Top-left and bottom-right corners of ball in contact
    db 0, 2, 1, 0, 1, 0, 1, 0, 2, 2, 0, 0, 0, 0, 0, 0 ;    7: Inside corner:  Of left-facing wall and ceiling
    db 0, 1, 2, 0, 2, 0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0 ;    8: Outside corner: Of right-facing wall and floor
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    9: Unused:         Bottom-left and top-right corners of ball in contact
    db 0, 1, 2, 0, 0, 1, 2, 0, 0, 1, 2, 0, 0, 0, 0, 0 ;    A: Flat surface:   Floor
    db 0, 1, 2, 0, 1, 1, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0 ;    B: Inside corner:  Of left-facing wall and floor
    db 0, 0, 0, 0, 2, 2, 2, 0, 1, 1, 1, 0, 0, 0, 0, 0 ;    C: Flat surface:   Right-facing wall
    db 0, 2, 1, 0, 2, 2, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0 ;    D: Inside corner:  Of right-facing wall and ceiling
    db 0, 1, 2, 0, 2, 0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0 ;    E: Inside corner:  Of right-facing wall and floor
    db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    F: Unused:         Embedded in solid
    
    ; ORIGINAL VALUES
    ;db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    0: In air
    ;db 0, 2, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    1: Outside corner: Of left-facing wall and ceiling
    ;db 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ;    2: Outside corner: Of left-facing wall and floor
    ;db 0, 0, 0, 0, 1, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ;    3: Flat surface:   Left-facing wall
    ;db 0, 0, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    4: Outside corner: Of right-facing wall and ceiling
    ;db 0, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    5: Flat surface:   Ceiling
    ;db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    6: Unused:         Top-left and bottom-right corners of ball in contact
    ;db 0, 0, 1, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0 ;    7: Inside corner:  Of left-facing wall and ceiling
    ;db 0, 0, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ;    8: Outside corner: Of right-facing wall and floor
    ;db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    9: Unused:         Bottom-left and top-right corners of ball in contact
    ;db 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    A: Flat surface:   Floor
    ;db 0, 0, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    B: Inside corner:  Of left-facing wall and floor
    ;db 0, 0, 0, 0, 2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ;    C: Flat surface:   Right-facing wall
    ;db 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ;    D: Inside corner:  Of right-facing wall and ceiling
    ;db 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    E: Inside corner:  Of right-facing wall and floor
    ;db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ;    F: Unused:         Embedded in solid
;}

bank6_freespace: ; 06:7F03 - Freespace
