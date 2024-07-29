palettes_Title:
    ;   ---Background Palettes---
    incbin "gfx/titleCredits/titleScreen.pal"
    Palette $000000, $000000, $000000, $000000
    ;    ----Object Palettes----
    incbin "gfx/titleCredits/titleScreen.pal"
    Palette $000000, $000000, $000000, $000000

palettes_Credits:
    ;   ---Background Palettes---
    Palette $000000, $f9f1ba, $7db7d8, $1e2d65
    Palette $000000, $f6b785, $7092d6, $31205c
    Palette $000000, $f49874, $8965c6, $410252
    Palette $000000, $fb2525, $be0b5a, $620055
    dw $0000, $331f, $09f7, $00a9
    dw $0000, $51bc, $3410, $0406
    dw $0000, $1ed5, $00e4, $0041
    dw $0000, $6339, $214b, $0464
    ;    ----Object Palettes----
    incbin "gfx/titleCredits/creditsSprTiles.pal"

; The following were the original palettes
;For some reason they were written as plain Hex instead of using the .pal file
    ;Palette $000000, $dbae54, $c31819, $6c1441
    ;Palette $000000, $d8cc51, $c95523, $6c1426
    ;Palette $000000, $7eb18f, $3e7a51, $143a00
    ;Palette $000000, $eefbff, $42ff73, $6c1441
    ;Palette $000000, $995240, $5b1a00, $290009
   ; Palette $000000, $cac3ef, $8377b4, $552b80

    Palette $000000, $000000, $000000, $000000

    Palette $000000, $88ccaa, $445533, $223300

palettes_surface:
    include "tilesets/surface/colors.asm"

palettes_surfaceNight:
    include "tilesets/surface/colors_night.asm"

palettes_caveFirst:
    include "tilesets/caveFirst/colors.asm"

palettes_lavaCavesA:
    include "tilesets/lavaCaves/colors_A.asm"

palettes_lavaCavesB:
    include "tilesets/lavaCaves/colors_B.asm"

palettes_lavaCavesC:
    include "tilesets/lavaCaves/colors_C.asm"

palettes_ruinsExtArea1:
    include "tilesets/ruinsExt/colors_area1.asm"

palettes_ruinsInsideGold:
    include "tilesets/ruinsInside/colors_gold.asm"

palettes_ruinsExtArea2:
    include "tilesets/ruinsExt/colors_area2.asm"

palettes_ruinsInsideWater:
    include "tilesets/ruinsInside/colors_water.asm"

palettes_plantBubblesArea3Lower:
    include "tilesets/plantBubbles/colors_area3lower.asm"

palettes_ruinsExtArea3Upper:
    include "tilesets/ruinsExt/colors_area3upper.asm"

palettes_ruinsInsideIndustrial:
    include "tilesets/ruinsInside/colors_industrial.asm"

palettes_ruinsInsideTower:
    include "tilesets/ruinsInside/colors_tower.asm"

palettes_ruinsExtArea5:
    include "tilesets/ruinsExt/colors_area5.asm"

palettes_omegaNest:
    include "tilesets/plantBubbles/colors_omegaNest.asm"

palettes_lavaCavesQueenRoad:
    include "tilesets/lavaCaves/colors_queenRoad.asm"

palettes_queenPool:
    include "tilesets/caveFirst/colors_queenPool.asm"

palettes_finalLab:
    include "tilesets/finalLab/colors.asm"

palettes_queen:
    include "tilesets/queen/colors.asm"
