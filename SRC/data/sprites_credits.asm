; Sprite Pointers
creditsSpritePointerTable:

    dw sprite_titleStart ; 00
    dw sprite_titleClear ; 01
    dw sprite_title_cursorA ; 02
    dw sprite_title_cursorB ; 03
    dw sprite_title_cursorC ; 04
    dw sprite_title_cursorD ; 05
    dw sprite_title_shootingStar ; 06
    dw sprite_suited_standing ; 07
    dw sprite_suited_run_frameA_top ; 08
    dw sprite_suited_run_frameB_frameD_top ; 09
    dw sprite_suited_run_frameC_top ; 0a
    dw sprite_suited_run_frameA_frameC_bottom ; 0b
    dw sprite_suited_run_frameB_frameD_bottom ; 0c
    dw sprite_title_shootingStar ; 0d
    dw sprite_suitless_default_head ; 0e
    dw sprite_suitless_default_hand ; 0f
    dw sprite_suitless_default_body ; 10
    dw sprite_suitless_kneeling ; 11
    dw sprite_suited_kneeling ; 12
    dw sprite_suitless_frameB_hand ; 13
    dw sprite_suitless_frameC_hand ; 14
    dw sprite_suitless_frameD_head ; 15
    dw sprite_suitless_frameE_head ; 16
    dw sprite_suitless_frameF_head ; 17
    dw sprite_suitless_frameG_hairWaving_frameA_head ; 18
    dw sprite_suitless_frameH_head ; 19
    dw sprite_hairWaving_frameB_head ; 1a
    dw sprite_credits_starA ; 1b
    dw sprite_credits_starB ; 1c
    dw sprite_title_overlayII ; 1d
    dw sprite79D2 ; 1e
    dw sprite_jump_frameA ; 1f
    dw sprite_jump_frameB ; 20
    dw sprite_jump_frameC ; 21
    dw sprite_jump_frameD ; 22
    dw sprite_title_one ; 23 - File 1
    dw sprite_title_two ; 24 - File 2
    dw sprite_title_three ; 25 - File 3


; Metasprite Data:
sprite_title_one:
    db   0, 54, $8E, $80
    db METASPRITE_END
sprite_title_two:
    db   0, 54, $8F, $80
    db METASPRITE_END
sprite_title_three:
    db   0, 54, $90, $80
    db METASPRITE_END
sprite_suited_run_frameA_top:
    db -31, -4, $01, $80
    db -24, -8, $4C, $80
    db -24, -0, $4E, $80
    db -13,-16, $50, $80
    db -13, -8, $52, $80
    db -24,-20, $54, $80
    db -24,-12, $56, $80
    db -24,  4, $58, $80
    db -24, 12, $5A, $80
    db  -8,-20, $5C, $80
    db  -8,-12, $5E, $80
    db  -8, -4, $60, $80
    db  -8,  4, $62, $80
    db  -8, 12, $64, $80
    db METASPRITE_END
sprite_suited_run_frameB_frameD_top:
    db -30, -4, $01, $80
    db -23, -8, $8a, $80
    db -23, -0, $8c, $80
    db -24,-20, $8e, $80
    db -24,-12, $90, $80
    db -24,  4, $92, $80
    db -24, 12, $94, $80
    db -10,-20, $96, $80
    db -10,-12, $98, $80
    db -10, 10, $9a, $80
    db  -8,-20, $9c, $80
    db  -8,-12, $9e, $80
    db  -8, -4, $a0, $80
    db  -8,  4, $a2, $80
    db  -8, 12, $a4, $80
    db METASPRITE_END
sprite_suited_run_frameC_top:
    db -31, -4, $01, $80
    db -24, -9, $6e, $80
    db -24, -1, $70, $80
    db -23,-20, $72, $80
    db -24,-12, $74, $80
    db -24, -4, $76, $80
    db -24,  4, $78, $80
    db -24, 12, $7a, $80
    db -11,-17, $7c, $80
    db  -8,-20, $7e, $80
    db -13,  9, $80, $80
    db  -8,-12, $82, $80
    db  -8, -4, $84, $80
    db  -8,  4, $86, $80
    db  -8, 12, $88, $80
    db METASPRITE_END
sprite_suited_standing:
    db -32, -4, $01, $80
    db -24, -9, $02, $80
    db -24, -1, $04, $80
    db -24,-20, $06, $80
    db -24,-12, $08, $80
    db -24,  4, $0a, $80
    db -24, 12, $0c, $80
    db -12,-17, $0e, $80
    db   4,-17, $10, $80
    db  -4,-25, $12, $80
    db -12,  8, $14, $80
    db  -8,-16, $16, $80
    db  -8, -8, $18, $80
    db  -8,  0, $1a, $80
    db  -8,  8, $1c, $80
    db   8,-16, $1e, $80
    db   8, -8, $20, $80
    db   8,  0, $22, $80
    db   8,  8, $24, $80
    db  24,-12, $26, $80
    db  24,  3, $26, $a0
    db  40,-20, $28, $80
    db  40,-12, $2a, $80
    db  40, 11, $28, $a0
    db  40,  3, $2a, $a0
    db METASPRITE_END
sprite_title_shootingStar:
    db   0,  0, $82, $80
    db METASPRITE_END
sprite_titleStart:
    db   0,  0, $84, $00
    db   0,  8, $85, $00
    db   0, 16, $86, $00
    db   0, 24, $87, $00
    db   0, 32, $88, $00
    db METASPRITE_END
sprite_titleClear:
    db   0,  0, $89, $00
    db   0,  8, $8A, $00
    db   0, 16, $8B, $00
    db   0, 24, $8C, $00
    db   0, 32, $8D, $00
    db METASPRITE_END
sprite_title_cursorA:
    db   0,  0, $80, $00
    db METASPRITE_END
sprite_title_cursorB:
    db   0,  0, $81, $00
    db METASPRITE_END
sprite_title_cursorC:
    db   0,  0, $82, $00
    db METASPRITE_END
sprite_title_cursorD:
    db   0,  0, $83, $00
    db METASPRITE_END
sprite_suited_run_frameA_frameC_bottom:
    db   8, -8, $66, $80
    db   8, -0, $68, $80
    db  24, -0, $6a, $80
    db  40, -0, $6c, $80
    db METASPRITE_END
sprite_suited_run_frameB_frameD_bottom:
    db   8,-12, $a6, $80
    db   8, -4, $a8, $80
    db   8,  4, $aa, $80
    db  24, -1, $ac, $80
    db METASPRITE_END
sprite_jump_frameA:
    db -16,-16, $b2, $80
    db -16, -8, $b4, $80
    db -16,  0, $b4, $a0
    db -16,  8, $b2, $a0
    db   0,-16, $ae, $c0
    db   0, -8, $b0, $c0
    db   0,  0, $b0, $e0
    db   0,  8, $ae, $e0
    db METASPRITE_END
sprite_jump_frameB:
    db  -8,-16, $b6, $80
    db  -8, -8, $b8, $80
    db  -8,  0, $b8, $a0
    db  -8,  8, $b6, $a0
    db -16,-16, $ae, $80
    db -16, -8, $b0, $80
    db -16,  0, $b0, $a0
    db -16,  8, $ae, $a0
    db   0,-16, $ae, $c0
    db   0, -8, $b0, $c0
    db   0,  0, $b0, $e0
    db   0,  8, $ae, $e0
    db METASPRITE_END
sprite_jump_frameC:
    db -16,-16, $ae, $80
    db -16, -8, $b0, $80
    db -16,  0, $b0, $a0
    db -16,  8, $ae, $a0
    db   0,-16, $b2, $c0
    db   0, -8, $b4, $c0
    db   0,  0, $b4, $e0
    db   0,  8, $b2, $e0
    db METASPRITE_END
sprite_jump_frameD:
    db -16,-16, $ae, $80
    db -16, -8, $b0, $80
    db -16,  0, $b0, $a0
    db -16,  8, $ae, $a0
    db   0,-16, $ae, $c0
    db   0, -8, $b0, $c0
    db   0,  0, $b0, $e0
    db   0,  8, $ae, $e0
    db METASPRITE_END
sprite_suitless_default_head:
    db -32, -8, $1e, $80
    db -32, -0, $20, $80
    db -32, -8, $22, $80
    db -32, -0, $24, $80
    db METASPRITE_END
sprite_suitless_default_hand:
    db -16,-10, $26, $80
    db   0,-16, $32, $80
    db   0,-16, $3a, $80
    db METASPRITE_END
sprite_suitless_default_body:
    db -16, -2, $28, $80
    db -16,  6, $2a, $80
    db -16,-10, $2c, $80
    db -16, -2, $2e, $80
    db  -8,  6, $30, $80
    db   0, -8, $34, $80
    db   0, -0, $36, $80
    db   0,  8, $38, $80
    db   0, -5, $3c, $80
    db  16, -6, $3e, $80
    db  16,  2, $40, $80
    db  32, -8, $42, $80
    db  32,  0, $44, $80
    db  32,  8, $46, $80
    db METASPRITE_END
sprite_suitless_kneeling:
    db   0, -8, $00, $80
    db   0,  0, $02, $80
    db   0,  8, $05, $80
    db   0, -8, $06, $80
    db   0,  0, $08, $80
    db  16,-12, $0a, $80
    db  16, -4, $0c, $80
    db  16,  4, $0e, $80
    db  16, 12, $10, $80
    db  17, -4, $12, $80
    db  17,  4, $14, $80
    db  32,-16, $16, $80
    db  32, -8, $18, $80
    db  32,  0, $1a, $80
    db  32,  8, $1c, $80
    db  33,-12, $3a, $80
    db METASPRITE_END
sprite_suited_kneeling:
    db  -8, -4, $01, $80
    db  -0, -9, $02, $80
    db  -0, -1, $04, $80
    db  -0,-20, $06, $80
    db  -0,-12, $08, $80
    db  -0,  4, $2c, $80
    db  -0, 12, $2e, $80
    db  12,-18, $30, $80
    db  22,-28, $32, $80
    db  22,-20, $34, $80
    db   8, 10, $36, $80
    db  16,-20, $38, $80
    db  16,-12, $3a, $80
    db  16, -4, $3c, $80
    db  16,  4, $3e, $80
    db  16, 12, $40, $80
    db  16, 20, $42, $80
    db  32,-18, $44, $80
    db  32,-10, $46, $80
    db  32, -2, $48, $80
    db  32,  6, $4a, $80
    db METASPRITE_END
sprite_suitless_frameB_hand:
    db -16,-26, $48, $80
    db -16,-18, $4a, $80
    db -16,-10, $4c, $80
    db -16,-18, $4e, $80
    db METASPRITE_END
sprite_suitless_frameC_hand:
    db -30,-16, $50, $80
    db -32, -8, $52, $80
    db -32, -0, $20, $80
    db -16,-10, $54, $80
    db -32, -8, $56, $80
    db -32, -0, $24, $80
    db -33,-15, $4e, $C0
    db METASPRITE_END
sprite_suitless_frameD_head:
    db -32, -8, $58, $80
    db -32, -0, $5a, $80
    db -32, -8, $5c, $80
    db -32, -0, $5e, $80
    db METASPRITE_END
sprite_suitless_frameE_head:
    db -32, -8, $60, $80
    db -32, -0, $62, $80
    db -32, -8, $64, $80
    db -32, -0, $66, $80
    db METASPRITE_END
sprite_suitless_frameF_head:
    db -32, -8, $68, $80
    db -32, -0, $6a, $80
    db -32,-16, $6c, $80
    db -32, -8, $6e, $80
    db -32, -0, $70, $80
    db METASPRITE_END
sprite_suitless_frameG_hairWaving_frameA_head:
    db -32, -8, $72, $80
    db -32, -0, $74, $80
    db -32,-16, $77, $80
    db -32, -8, $78, $80
    db -32, -0, $7a, $80
    db METASPRITE_END
sprite_suitless_frameH_head:
    db -32, -8, $7c, $80
    db -32, -0, $7e, $80
    db -32, -8, $80, $80
    db -32, -0, $82, $80
    db METASPRITE_END
sprite_hairWaving_frameB_head:
    db -32, -8, $84, $80
    db -32, -0, $86, $80
    db -32,-16, $89, $80
    db -32, -8, $8a, $80
    db -32, -0, $8c, $80
    db METASPRITE_END
sprite_credits_starA:
    db  -4, -4, $BA, $80
    db METASPRITE_END
sprite_credits_starB:
    db  -4, -4, $BC, $80
    db METASPRITE_END
sprite_title_overlayII:
    db -71, 11, $91, $00
    db -71, 19, $92, $00
    db -71, 27, $93, $00
    db -63,  9, $94, $00
    db -55,  9, $95, $00
    db -47,  9, $96, $00
    db -60, 25, $97, $00
    db -52, 26, $98, $00
    db METASPRITE_END
sprite79D2:
    db METASPRITE_END
