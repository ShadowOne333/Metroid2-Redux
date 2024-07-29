; Disassembly of "m2 ejrtq v1.3.gbc"
; This file was created with:
; mgbdis v2.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $007", ROMX[$4000], BANK[$7]

gfx_plantBubbles:: incbin "tilesets/plantBubbles/BG.chr",0,$800
gfx_ruinsInside::  incbin "tilesets/ruinsInside/BG.chr",0,$800
gfx_queenBG::      incbin "tilesets/queen/BG.chr",0,$800
gfx_caveFirst::    incbin "tilesets/caveFirst/BG.chr",0,$800
gfx_surfaceBG::    incbin "tilesets/surface/BG.chr",0,$800
gfx_lavaCavesA::   incbin "tilesets/lavaCaves/BG_A.chr",0,$530
gfx_lavaCavesB::   incbin "tilesets/lavaCaves/BG_B.chr",  0,$530
gfx_lavaCavesC::   incbin "tilesets/lavaCaves/BG_C.chr",  0,$530

; 7:7790 - Item graphics (0x40 each)
; Plasma Beam, Ice Beam, Wave Beam, Spazer Beam
; Bombs, Screw Attack, Varia Suit, High Jump Boots
; Space Jump, Spider Ball, Spring Ball
gfx_items:: incbin "gfx/items.2bpp"

; 7:7A50 - Item Orb
gfx_itemOrb:: incbin "gfx/itemOrb.2bpp"

; 7:7A90 - Missile Tank, Door, Missile Block, Refills
gfx_commonItems:: incbin "gfx/commonItems.2bpp"

colorid_items::    incbin "gfx/items.attrmap"
colorid_itemOrb::    incbin "gfx/itemOrb.attrmap"
colorid_commonItems::    incbin "gfx/commonItems.attrmap"

gfxInfo_itemOrb:: db BANK(gfx_itemOrb)
    dw gfx_itemOrb, vramDest_enemies, $0040, colorid_itemOrb



bank7_freespace: ; 7:7B90 -- Freespace
