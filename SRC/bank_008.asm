; Disassembly of "Metroid2.gb"
; This file was created with:
; mgbdis v1.4 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

SECTION "ROM Bank $008", ROMX[$4000], BANK[$8]

bg_queenHead::
    db $b0, $b1, $b2, $b3, $b4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $c0, $c1, $c2, $c3, $c4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $d0, $d1, $d2, $d3, $d4, $d5, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $e2, $e3, $e4, $e5, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

collision_finalLab:     include "tilesets/finalLab/collision.asm"
collision_plantBubbles: include "tilesets/plantBubbles/collision.asm"
collision_ruinsInside:  include "tilesets/ruinsInside/collision.asm"
collision_queen:        include "tilesets/queen/collision.asm"
collision_caveFirst:    include "tilesets/caveFirst/collision.asm"
collision_surface:      include "tilesets/surface/collision.asm"
collision_lavaCaves:    include "tilesets/lavaCaves/collision.asm"
collision_ruinsExt:     include "tilesets/ruinsExt/collision.asm"

metatiles_plantBubbles:   
    include "tilesets/plantBubbles/metatiles.asm"
    include "tilesets/plantBubbles/colorid.asm"
metatiles_ruinsInside:    
    include "tilesets/ruinsInside/metatiles.asm"
    include "tilesets/ruinsInside/colorid.asm"
metatiles_finalLab:       
    include "tilesets/finalLab/metatiles.asm"
    include "tilesets/finalLab/colorid.asm"
metatiles_queen:          
    include "tilesets/queen/metatiles.asm"
    include "tilesets/queen/colorid.asm"
metatiles_caveFirst:      
    include "tilesets/caveFirst/metatiles.asm"
    include "tilesets/caveFirst/colorid.asm"
metatiles_surface:
    include "tilesets/surface/metatiles.asm"
    include "tilesets/surface/colorid.asm"
metatiles_lavaCavesMid:   
    include "tilesets/lavaCaves/metatiles_mid.asm"
    include "tilesets/lavaCaves/colorid_mid.asm"
metatiles_lavaCavesEmpty: 
    include "tilesets/lavaCaves/metatiles_empty.asm"
    include "tilesets/lavaCaves/colorid_empty.asm"
metatiles_lavaCavesFull:  
    include "tilesets/lavaCaves/metatiles_full.asm"
    include "tilesets/lavaCaves/colorid_full.asm"
metatiles_ruinsExt:       
    include "tilesets/ruinsExt/metatiles.asm"
    include "tilesets/ruinsExt/colorid.asm"



; Check if killed target number of metroids
earthquakeCheck:: ;{ 08:7EBC:
    ld hl, .thresholds
	
    .loop:
	    ; If we have reached the end of .thresholds, then return
	    ld a, [hl+]
        cp $ff
	    jr z, .return

	    ; If metroidCountReal = .thresholds[hl], then branch ahead to set the timer
        ld b, a
        ld a, [metroidCountReal]
        cp b
        jr z, .setTimer
    jr .loop

.setTimer:
; If more than 1 Metroid is left, set timer to 3 and exit
    ld a, $03
    ld [nextEarthquakeTimer], a
    ld a, [metroidCountReal]
    cp $01
    ret nz

; If only 1 metroid (the queen) is left, set timer to 1
    ld a, $01
    ld [nextEarthquakeTimer], a
.return:
    ret

; Earthquake threshholds (terminated with $FF)
.thresholds:
    db $46, $42, $34, $24, $23, $21, $14, $13, $12, $09, $01, $ff
;}
    
; 8:7EEA - Collision Table Pointers
collisionPointerTable::
    dw collision_plantBubbles ; 0
    dw collision_ruinsInside  ; 1
    dw collision_queen        ; 2
    dw collision_caveFirst    ; 3
    dw collision_surface      ; 4
    dw collision_lavaCaves    ; 5
    dw collision_ruinsExt     ; 6
    dw collision_finalLab     ; 7

; 8:7EFA Solidity threshholds
solidityIndexTable:: include "tilesets/solidityValues.asm"

; 8:7F1A Metatile definition pointers
metatilePointerTable::
    dw metatiles_finalLab       ; 0 - 2
    dw metatiles_ruinsInside    ; 1 - 1
    dw metatiles_plantBubbles   ; 2 - 0
    dw metatiles_queen          ; 3 - 3
    dw metatiles_caveFirst      ; 4 - 4
    dw metatiles_surface        ; 5 - 5
    dw metatiles_lavaCavesEmpty ; 6 - 7
    dw metatiles_lavaCavesFull  ; 7 - 8
    dw metatiles_lavaCavesMid   ; 8 - 6
    dw metatiles_ruinsExt       ; 9 - 9

bank8_freespace: ; 7:7B90 - Freespace (filled with $00)