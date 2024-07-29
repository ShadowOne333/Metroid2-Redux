; Sprite Pointers
samusSpritePointerTable:

    dw sprite425F ; $00 - Facing screen
    dw sprite429C ; $01 - Standing (right)
    dw sprite42FE ; $02 - Standing (right, aiming up)
    dw sprite4360 ; $03 - Running (right, frame 1), Jump-start (right)
    dw sprite4391 ; $04 - Running (right, frame 2)
    dw sprite43C6 ; $05 - Running (right, frame 3)
    dw sprite4476 ; $06 - Running (right, firing forwards, frame 1)
    dw sprite44AB ; $07 - Running (right, firing forwards, frame 2)
    dw sprite44E8 ; $08 - Running (right, firing forwards, frame 3)
    dw sprite45AC ; $09 - Jumping (facing right)
    dw sprite4606 ; $0A - Jumping (facing right, aiming up)
    dw sprite4660 ; $0B - Crouching (facing right)
    dw sprite46B2 ; $0C - Jumping (facing right, aiming down)
    dw sprite425F ; $0D - Facing screen (unused? duplicate)
    dw sprite42CD ; $0E - Standing (left)
    dw sprite432F ; $0F - Standing (left, aiming up)
    dw sprite43EB ; $10 - Running (left, frame 1), Jump-start (left)
    dw sprite441C ; $11 - Running (left, frame 2)
    dw sprite4451 ; $12 - Running (left, frame 3)
    dw sprite4511 ; $13 - Running (left, firing forwards, frame 1)
    dw sprite4546 ; $14 - Running (left, firing forwards, frame 2)
    dw sprite4583 ; $15 - Running (left, firing forwards, frame 3)
    dw sprite45D9 ; $16 - Jumping (facing left)
    dw sprite4633 ; $17 - Jumping (facing left, aiming up)
    dw sprite4689 ; $18 - Crouching (facing left)
    dw sprite46DB ; $19 - Jumping (facing left, aiming down)
    dw sprite4197 ; $1A - Spin jump (right, frame 1)
    dw sprite41B0 ; $1B - Spin jump (right, frame 2)
    dw sprite41C9 ; $1C - Spin jump (right, frame 3)
    dw sprite41E2 ; $1D - Spin jump (right, frame 4)
    dw sprite410F ; $1E - Morph (left, frame 1)
    dw sprite4120 ; $1F - Morph (left, frame 2)
    dw sprite4131 ; $20 - Morph (left, frame 3)
    dw sprite4142 ; $21 - Morph (left, frame 4)
    dw sprite41FB ; $22 - Spin jump (left, frame 1)
    dw sprite4214 ; $23 - Spin jump (left, frame 2)
    dw sprite422D ; $24 - Spin jump (left, frame 3)
    dw sprite4246 ; $25 - Spin jump (left, frame 4)
    dw sprite4153 ; $26 - Morph (right, frame 1)
    dw sprite4164 ; $27 - Morph (right, frame 2)
    dw sprite4175 ; $28 - Morph (right, frame 3)
    dw sprite4186 ; $29 - Morph (right, frame 4)
    dw sprite410A ; $2A - Beam (horizontal)
    dw sprite4704 ; $2B - Running (right, aiming up, frame 1)
    dw sprite4735 ; $2C - Running (right, aiming up, frame 2)
    dw sprite476E ; $2D - Running (right, aiming up, frame 3)
    dw sprite4793 ; $2E - Running (left, aiming up, frame 1)
    dw sprite47C4 ; $2F - Running (left, aiming up, frame 2)
    dw sprite47FD ; $30 - Running (left, aiming up, frame 3)
    dw sprite4859 ; $31 - Explosion (frame ?)
    dw sprite4848 ; $32 - Explosion (frame ?)
    dw sprite4827 ; $33 - Explosion (frame ?)
    dw sprite4822 ; $34 - Explosion (frame ?)
    dw sprite489A ; $35 - Bomb (frame 1)
    dw sprite489F ; $36 - Bomb (frame 2)
    dw sprite48A4 ; $37 - Spider (left, frame 1)
    dw sprite48B5 ; $38 - Spider (left, frame 2)
    dw sprite48C6 ; $39 - Spider (left, frame 3)
    dw sprite48D7 ; $3A - Spider (left, frame 4)
    dw sprite48E8 ; $3B - Spider (right, frame 1)
    dw sprite48F9 ; $3C - Spider (right, frame 2)
    dw sprite490A ; $3D - Spider (right, frame 3)
    dw sprite491B ; $3E - Spider (right, frame 4)
    dw sprite40B8 ; $3F - "PRESS START" (Save text)
    dw sprite4093 ; $40 - "COMPLETED" (Save text)


; Metasprite Data:
sprite4093: ; "COMPLETED"
    db   0,  0, $C2, $80
    db   0,  8, $CE, $80
    db   0, 16, $CC, $80
    db   0, 24, $CF, $80
    db   0, 32, $CB, $80
    db   0, 40, $C4, $80
    db   0, 48, $D3, $80
    db   0, 56, $C4, $80
    db   0, 64, $C3, $80
    db METASPRITE_END
sprite40B8: ; "PRESS START"
    db   0,  0, $CF, $00
    db   0,  8, $D1, $00
    db   0, 16, $C4, $00
    db   0, 24, $D2, $00
    db   0, 32, $D2, $00
    db   0, 48, $D2, $00
    db   0, 56, $D3, $00
    db   0, 64, $C0, $00
    db   0, 72, $D1, $00
    db   0, 80, $D3, $00
    db METASPRITE_END
sprite410A:
    db  -4, -4, $7E, $00
    db METASPRITE_END
sprite410F:
    db   4, -8, $00, $00
    db   4,  0, $01, $00
    db  12, -8, $02, $00
    db  12,  0, $03, $00
    db METASPRITE_END
sprite4120:
    db   3, -8, $01, $20
    db   3,  0, $03, $40
    db  11, -8, $00, $40
    db  11,  0, $02, $20
    db METASPRITE_END
sprite4131:
    db   4, -8, $03, $60
    db   4,  0, $02, $60
    db  12, -8, $01, $60
    db  12,  0, $00, $60
    db METASPRITE_END
sprite4142:
    db   3, -8, $02, $40
    db   3,  0, $00, $20
    db  11, -8, $03, $20
    db  11,  0, $01, $40
    db METASPRITE_END
sprite4153:
    db   4, -8, $01, $20
    db   4,  0, $00, $20
    db  12, -8, $03, $20
    db  12,  0, $02, $20
    db METASPRITE_END
sprite4164:
    db   3, -8, $03, $60
    db   3,  0, $01, $00
    db  11, -8, $02, $00
    db  11,  0, $00, $60
    db METASPRITE_END
sprite4175:
    db   4, -8, $02, $40
    db   4,  0, $03, $40
    db  12, -8, $00, $40
    db  12,  0, $01, $40
    db METASPRITE_END
sprite4186:
    db   3, -8, $00, $00
    db   3,  0, $02, $60
    db  11, -8, $01, $60
    db  11,  0, $03, $00
    db METASPRITE_END
sprite4197:
    db   0,-12, $00, $00
    db   0, -4, $01, $00
    db   0,  4, $02, $00
    db   8,-12, $03, $00
    db   8, -4, $04, $00
    db   8,  4, $05, $00
    db   8,  1, $0C, $00
    db METASPRITE_END
sprite41B0:
    db  -4, -8, $0B, $60
    db  -4,  0, $0A, $60
    db   4, -8, $09, $60
    db   4,  0, $08, $60
    db  12, -8, $07, $60
    db  12,  0, $06, $60
    db  10, -8, $0C, $00
    db METASPRITE_END
sprite41C9:
    db   0,-12, $05, $60
    db   0, -4, $04, $60
    db   0,  4, $03, $60
    db   8,-12, $02, $60
    db   8, -4, $01, $60
    db   8,  4, $00, $60
    db   1,-10, $0C, $00
    db METASPRITE_END
sprite41E2:
    db  -4, -8, $06, $00
    db  -4,  0, $07, $00
    db   4, -8, $08, $00
    db   4,  0, $09, $00
    db  12, -8, $0A, $00
    db  12,  0, $0B, $00
    db  -1, -1, $0C, $00
    db METASPRITE_END
sprite41FB:
    db   0,-12, $02, $20
    db   0, -4, $01, $20
    db   0,  4, $00, $20
    db   8,-12, $05, $20
    db   8, -4, $04, $20
    db   8,  4, $03, $20
    db   8,-10, $0C, $00
    db METASPRITE_END
sprite4214:
    db  -4, -8, $0A, $40
    db  -4,  0, $0B, $40
    db   4, -8, $08, $40
    db   4,  0, $09, $40
    db  12, -8, $06, $40
    db  12,  0, $07, $40
    db  10, -1, $0C, $00
    db METASPRITE_END
sprite422D:
    db   0,-12, $03, $40
    db   0, -4, $04, $40
    db   0,  4, $05, $40
    db   8,-12, $00, $40
    db   8, -4, $01, $40
    db   8,  4, $02, $40
    db   1,  1, $0C, $00
    db METASPRITE_END
sprite4246:
    db  -4, -8, $07, $20
    db  -4,  0, $06, $20
    db   4, -8, $09, $20
    db   4,  0, $08, $20
    db  12, -8, $0B, $20
    db  12,  0, $0A, $20
    db  -1, -8, $0C, $00
    db METASPRITE_END
sprite425F:
    db -19,-11, $01, $20
    db -20, -4, $00, $00
    db -19,  4, $01, $00
    db -11,-12, $02, $00
    db -12, -4, $03, $00
    db -11,  4, $04, $00
    db  -4,-13, $05, $00
    db   4,-13, $06, $00
    db  -4, -7, $07, $20
    db  -4,  0, $07, $00
    db  -3,  6, $08, $00
    db   4, -8, $09, $20
    db   4,  1, $09, $00
    db  12, -9, $0A, $20
    db  12,  2, $0A, $00
    db METASPRITE_END
sprite429C:
    db -20, -8, $00, $00
    db -19,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00

    db  -4, -8, $04, $00
    db  -4,  0, $05, $00
    db   4, -8, $06, $00
    db   4,  0, $07, $00
    db  12,-16, $08, $00
    db  12, -8, $09, $00
    
    db  12,  0, $0A, $00
    db  -7,  4, $0F, $00
    db METASPRITE_END
sprite42CD:
    db -19, -8, $01, $20
    db -20,  0, $00, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    
    db  -4, -8, $04, $00
    db  -4,  0, $05, $00
    db   4, -8, $07, $20
    db   4,  0, $06, $20
    db  12,  0, $09, $20
    db  12,  8, $08, $20

    db  12, -8, $0A, $20
    db  -7,-11, $0F, $20
    db METASPRITE_END
sprite42FE:
    db -20, -8, $00, $00
    db -20,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    db  -4, -8, $04, $00
    db  -4,  0, $05, $00
    db   4, -8, $06, $00
    db   4,  0, $07, $00
    db  12,-16, $08, $00
    db  12, -8, $09, $00
    db  12,  0, $0A, $00
    
    db -24, -2, $0E, $00
    db -19, -7, $0B, $00
    db METASPRITE_END
sprite432F:
    db -20, -8, $00, $00
    db -20,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    db  -4, -8, $05, $20
    db  -4,  0, $04, $20
    db   4, -8, $07, $20
    db   4,  0, $06, $20
    db  12, -8, $0A, $20
    db  12,  0, $09, $20
    db  12,  8, $08, $20
    db -20, -4, $0B, $00
    db -24, -6, $0E, $00
    db METASPRITE_END
sprite4360:
    db -20, -4, $00, $00
    db -20,  4, $01, $00
    db -12,-12, $02, $00
    db -12, -4, $03, $00
    db -12,  4, $04, $00

    db  -4, -4, $05, $00
    db  -4,  4, $06, $00
    db   4,-12, $07, $00
    db   4, -4, $08, $00
    db   4,  4, $09, $00
    db  12,-12, $0A, $00
    db  12, -4, $0B, $00
    db METASPRITE_END
sprite4391:
    db -20, -7, $00, $00
    db -19,  1, $01, $00
    db -12, -7, $02, $00
    db -12,  1, $03, $00

    db  -4,-20, $05, $00
    db  -4,-12, $06, $00
    db  -4, -4, $07, $00
    db   4,-17, $08, $00
    db   4, -9, $09, $00
    db   4, -1, $0A, $00
    db  12, -4, $0B, $00
    db  12,  4, $0C, $00
    db METASPRITE_END
sprite43C6:
    db -20, -4, $00, $00
    db -20,  4, $01, $00
    db -12,-12, $02, $00
    db -12, -4, $03, $00
    db -12,  4, $04, $00

    db  -4, -4, $05, $00
    db   4, -4, $06, $00
    db  12,-12, $07, $00
    db  12, -4, $08, $00
    db METASPRITE_END
sprite43EB:
    db -20,-12, $01, $20
    db -20, -4, $00, $20
    db -12,-12, $04, $20
    db -12, -4, $03, $20
    db -12,  4, $02, $20

    db  -4,-12, $06, $20
    db  -4, -4, $05, $20
    db   4,-12, $09, $20
    db   4, -4, $08, $20
    db   4,  4, $07, $20
    db  12, -4, $0B, $20
    db  12,  4, $0A, $20
    db METASPRITE_END
sprite441C:
    db -19,-10, $01, $20
    db -20, -2, $00, $20
    db -12,-10, $03, $20
    db -12, -2, $02, $20

    db  -4, -4, $07, $20
    db  -4,  4, $06, $20
    db  -4, 12, $05, $20
    db   4, -7, $0A, $20
    db   4,  1, $09, $20
    db   4,  9, $08, $20
    db  12,-12, $0C, $20
    db  12, -4, $0B, $20
    db METASPRITE_END
sprite4451:
    db -20,-12, $01, $20
    db -20, -4, $00, $20
    db -12,-12, $04, $20
    db -12, -4, $03, $20
    db -12,  4, $02, $20

    db  -4, -4, $05, $20
    db   4, -4, $06, $20
    db  12, -4, $08, $20
    db  12,  4, $07, $20
    db METASPRITE_END
sprite4476:
    db -20, -4, $00, $00
    db -20,  4, $01, $00
    db -12,-12, $02, $00
    db -12, -4, $03, $00
    db -12,  4, $04, $00
    db -11,  9, $0F, $00
    
    db  -4, -4, $05, $00
    db  -4,  4, $06, $00
    db   4,-12, $07, $00
    db   4, -4, $08, $00
    db   4,  4, $09, $00
    db  12,-12, $0A, $00
    db  12, -4, $0B, $00
    db METASPRITE_END
sprite44AB:
    db -19, -5, $00, $00
    db -19,  3, $01, $00
    db -11,-13, $02, $00
    db -11, -5, $03, $00
    db -11,  3, $04, $00
    db -10,  8, $0F, $00

    db  -4,-20, $05, $00
    db  -4,-12, $06, $00
    db  -4, -4, $07, $00
    db   4,-17, $08, $00
    db   4, -9, $09, $00
    db   4, -1, $0A, $00
    db  12, -4, $0B, $00
    db  12,  4, $0C, $00
    db METASPRITE_END
sprite44E8:
    db -20, -4, $00, $00
    db -20,  4, $01, $00
    db -12,-12, $02, $00
    db -12, -4, $03, $00
    db -12,  4, $04, $00
    db -11,  9, $0F, $00

    db  -4, -4, $05, $00
    db   4, -4, $06, $00
    db  12,-12, $07, $00
    db  12, -4, $08, $00
    db METASPRITE_END
sprite4511:
    db -20,-12, $01, $20
    db -20, -4, $00, $20
    db -12,-12, $04, $20
    db -12, -4, $03, $20
    db -12,  4, $02, $20
    db -11,-17, $0F, $20

    db  -4,-12, $06, $20
    db  -4, -4, $05, $20
    db   4,-12, $09, $20
    db   4, -4, $08, $20
    db   4,  4, $07, $20
    db  12, -4, $0B, $20
    db  12,  4, $0A, $20
    db METASPRITE_END
sprite4546:
    db -19,-11, $01, $20
    db -19, -3, $00, $20
    db -11,-11, $04, $20
    db -11, -3, $03, $20
    db -11,  5, $02, $20
    db -10,-16, $0F, $20

    db  -4, -4, $07, $20
    db  -4,  4, $06, $20
    db  -4, 12, $05, $20
    db   4, -7, $0A, $20
    db   4,  1, $09, $20
    db   4,  9, $08, $20
    db  12,-12, $0C, $20
    db  12, -4, $0B, $20
    db METASPRITE_END
sprite4583:
    db -20,-12, $01, $20
    db -20, -4, $00, $20
    db -12,-12, $04, $20
    db -12, -4, $03, $20
    db -12,  4, $02, $20
    db -11,-17, $0F, $20

    db  -4, -4, $05, $20
    db   4, -4, $06, $20
    db  12, -4, $08, $20
    db  12,  4, $07, $20
    db METASPRITE_END
sprite45AC:
    db -12, -8, $00, $00
    db -11,  0, $01, $00
    db  -4, -8, $02, $00
    db  -4,  0, $03, $00

    db   4,-16, $04, $00
    db   4, -8, $05, $00
    db   4,  0, $06, $00
    db  12,-16, $07, $00
    db  12, -8, $08, $00
    db  12,  0, $09, $00

    db   1,  4, $0F, $00
    db METASPRITE_END
sprite45D9:
    db -11, -8, $01, $20
    db -12,  0, $00, $00
    db  -4, -8, $02, $00
    db  -4,  0, $03, $00
    db   1,-12, $0F, $20

    db   4, -8, $06, $20
    db   4,  0, $05, $20
    db   4,  8, $04, $20
    db  12, -8, $09, $20
    db  12,  0, $08, $20
    db  12,  8, $07, $20
    db METASPRITE_END
sprite4606:
    db -12, -8, $00, $00
    db -12,  0, $01, $00
    db  -4, -8, $02, $00
    db  -4,  0, $03, $00
    db -15, -2, $0E, $00
    db -11, -7, $0A, $00

    db   4,-16, $04, $00
    db   4, -8, $05, $00
    db   4,  0, $06, $00
    db  12,-16, $07, $00
    db  12, -8, $08, $00
    db  12,  0, $09, $00
    db METASPRITE_END
sprite4633:
    db -12, -8, $00, $00
    db -12,  0, $01, $00
    db  -4, -8, $02, $00
    db  -4,  0, $03, $00
    db -11, -4, $0A, $00
    db -15, -6, $0E, $00

    db   4, -8, $06, $20
    db   4,  0, $05, $20
    db   4,  8, $04, $20
    db  12, -8, $09, $20
    db  12,  0, $08, $20
    db  12,  8, $07, $20
    db METASPRITE_END
sprite4660:
    db -10, -8, $00, $00
    db  -9,  0, $01, $00
    db  -2, -8, $02, $00
    db  -2,  0, $03, $00

    db   4, -8, $04, $00
    db   4,  0, $05, $00
    db  12,-16, $06, $00
    db  12, -8, $07, $00
    db  12,  0, $08, $00

    db   3,  4, $0F, $00
    db METASPRITE_END
sprite4689:
    db  -9, -8, $01, $20
    db -10,  0, $00, $00
    db  -2, -8, $02, $00
    db  -2,  0, $03, $00

    db   4, -8, $05, $20
    db   4,  0, $04, $20
    db  12, -8, $08, $20
    db  12,  0, $07, $20
    db  12,  8, $06, $20

    db   3,-11, $0F, $20
    db METASPRITE_END
sprite46B2:
    db -12, -3, $00, $00
    db  -7,  0, $01, $00
    db  -4, -8, $02, $00
    db  -4,  0, $03, $00

    db   4,-16, $04, $00
    db   4, -8, $05, $00
    db   4,  0, $06, $00
    db   8, -1, $0E, $40
    db  12,-16, $08, $00
    db  12, -8, $09, $00
    db  12,  0, $0A, $00
    db METASPRITE_END
sprite46DB:
    db  -7, -8, $01, $20
    db -12, -5, $00, $20
    db  -4, -8, $03, $20
    db  -4,  0, $02, $20

    db   4, -8, $07, $20
    db   4,  0, $05, $20
    db   4,  8, $04, $20
    db   8, -7, $0E, $40
    db  12, -8, $0A, $20
    db  12,  0, $09, $20
    db  12,  8, $08, $20
    db METASPRITE_END
sprite4704:
    db -20, -8, $00, $00
    db -20,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    db -19, -7, $0C, $00
    db -24, -2, $0E, $00
    
    db  -4, -5, $05, $00
    db  -4,  3, $06, $00
    db   4,-13, $07, $00
    db   4, -5, $08, $00
    db   4,  3, $09, $00
    db  12,-13, $0A, $00
    db  12, -5, $0B, $00
    db METASPRITE_END
sprite4735:
    db -19, -8, $00, $00
    db -19,  0, $01, $00
    db -11, -8, $02, $00
    db -11,  0, $03, $00
    db -18, -7, $0D, $00
    db -23, -2, $0E, $00

    db  -4,-21, $05, $00
    db  -4,-13, $06, $00
    db  -4, -5, $07, $00
    db   4,-18, $08, $00
    db   4,-10, $09, $00
    db   4, -2, $0A, $00
    db  12, -5, $0B, $00
    db  12,  3, $0C, $00
    db METASPRITE_END
sprite476E:
    db -20, -8, $00, $00
    db -20,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    db -19, -7, $09, $00
    db -24, -2, $0E, $00

    db  -4, -5, $05, $00
    db   4, -5, $06, $00
    db  12,-13, $07, $00
    db  12, -5, $08, $00
    db METASPRITE_END
sprite4793:
    db -20, -8, $00, $00
    db -20,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    db -20, -4, $0C, $00
    db -24, -6, $0E, $00

    db  -4,-11, $06, $20
    db  -4, -3, $05, $20
    db   4,-11, $09, $20
    db   4, -3, $08, $20
    db   4,  5, $07, $20
    db  12, -3, $0B, $20
    db  12,  5, $0A, $20
    db METASPRITE_END
sprite47C4:
    db -19, -8, $00, $00
    db -19,  0, $01, $00
    db -11, -8, $02, $00
    db -11,  0, $03, $00
    db -19, -4, $0D, $00
    db -23, -6, $0E, $00

    db  -4, -3, $07, $20
    db  -4,  5, $06, $20
    db  -4, 13, $05, $20
    db   4, -6, $0A, $20
    db   4,  2, $09, $20
    db   4, 10, $08, $20
    db  12,-11, $0C, $20
    db  12, -3, $0B, $20
    db METASPRITE_END
sprite47FD:
    db -20, -8, $00, $00
    db -20,  0, $01, $00
    db -12, -8, $02, $00
    db -12,  0, $03, $00
    db -20, -4, $09, $00
    db -24, -6, $0E, $00

    db  -4, -3, $05, $20
    db   4, -3, $06, $20
    db  12, -3, $08, $20
    db  12,  5, $07, $20

    db METASPRITE_END
sprite4822:
    db  -4, -4, $8E, $00
    db METASPRITE_END
sprite4827:
    db -12,-12, $8B, $00
    db -12, -4, $8C, $00
    db -12,  4, $8B, $20
    db  -4,-12, $8D, $00
    db  -4,  4, $8D, $20
    db   4,-12, $8B, $40
    db   4, -4, $8C, $40
    db   4,  4, $8B, $60
    db METASPRITE_END
sprite4848:
    db  -8, -8, $84, $00
    db  -8,  0, $84, $20
    db   0, -8, $84, $40
    db   0,  0, $84, $60
    db METASPRITE_END
sprite4859:
    db -16,-16, $80, $00
    db -16, -8, $81, $00
    db -16,  0, $81, $20
    db -16,  8, $80, $20
    db  -8,-16, $82, $00
    db  -8, -8, $83, $00
    db  -8,  0, $83, $20
    db  -8,  8, $82, $20
    db   0,-16, $82, $40
    db   0, -8, $83, $40
    db   0,  0, $83, $60
    db   0,  8, $82, $60
    db   8,-16, $80, $40
    db   8, -8, $81, $40
    db   8,  0, $81, $60
    db   8,  8, $80, $60
    db METASPRITE_END
sprite489A:
    db  -4, -4, $90, $00
    db METASPRITE_END
sprite489F:
    db  -4, -4, $91, $00
    db METASPRITE_END
sprite48A4:
    db   4, -8, $04, $00
    db   4,  0, $05, $00
    db  12, -8, $06, $00
    db  12,  0, $07, $00
    db METASPRITE_END
sprite48B5:
    db   3, -8, $05, $20
    db   3,  0, $07, $40
    db  11, -8, $04, $40
    db  11,  0, $06, $20
    db METASPRITE_END
sprite48C6:
    db   4, -8, $07, $60
    db   4,  0, $06, $60
    db  12, -8, $05, $60
    db  12,  0, $04, $60
    db METASPRITE_END
sprite48D7:
    db   3, -8, $06, $40
    db   3,  0, $04, $20
    db  11, -8, $07, $20
    db  11,  0, $05, $40
    db METASPRITE_END
sprite48E8:
    db   4, -8, $05, $20
    db   4,  0, $04, $20
    db  12, -8, $07, $20
    db  12,  0, $06, $20
    db METASPRITE_END
sprite48F9:
    db   3, -8, $07, $60
    db   3,  0, $05, $00
    db  11, -8, $06, $00
    db  11,  0, $04, $60
    db METASPRITE_END
sprite490A:
    db   4, -8, $06, $40
    db   4,  0, $07, $40
    db  12, -8, $04, $40
    db  12,  0, $05, $40
    db METASPRITE_END
sprite491B:
    db   3, -8, $04, $00
    db   3,  0, $06, $60
    db  11, -8, $05, $60
    db  11,  0, $07, $00
    db METASPRITE_END