
SECTION "ROM Bank $011", ROMX[$4000], BANK[$11]
gfx_metAlpha:: incbin "gfx/enemies/metAlpha.2bpp",0,$400
gfx_metGamma:: incbin "gfx/enemies/metGamma.2bpp",0,$400
gfx_metZeta::  incbin "gfx/enemies/metZeta.2bpp",0,$400
gfx_metOmega:: incbin "gfx/enemies/metOmega.2bpp",0,$400
gfx_ruinsExt:: incbin "tilesets/ruinsExt/BG.chr",0,$800
gfx_finalLab:: incbin "tilesets/finalLab/BG.chr",0,$800
gfx_queenSPR:: incbin "gfx/enemies/queenSPR.2bpp",0,$500

colorid_metAlpha::    incbin "gfx/enemies/metAlpha.attrmap"
colorid_metGamma::    incbin "gfx/enemies/metGamma.attrmap"
colorid_metZeta::    incbin "gfx/enemies/metZeta.attrmap"
colorid_metOmega::    incbin "gfx/enemies/metOmega.attrmap"
colorid_queenSPR::    incbin "gfx/enemies/queenSPR.attrmap"

