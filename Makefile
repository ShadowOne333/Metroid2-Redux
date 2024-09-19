all2bpp := SRC/gfx/items.2bpp SRC/gfx/itemOrb.2bpp SRC/gfx/commonItems.2bpp \
SRC/gfx/enemies/enemiesA.2bpp SRC/gfx/enemies/enemiesB.2bpp \
SRC/gfx/enemies/enemiesC.2bpp SRC/gfx/enemies/enemiesD.2bpp \
SRC/gfx/enemies/enemiesE.2bpp SRC/gfx/enemies/enemiesF.2bpp \
SRC/gfx/enemies/arachnus.2bpp \
SRC/gfx/enemies/metAlpha.2bpp SRC/gfx/enemies/metGamma.2bpp \
SRC/gfx/enemies/metZeta.2bpp SRC/gfx/enemies/metOmega.2bpp \
SRC/gfx/enemies/queenSPR.2bpp SRC/gfx/enemies/surfaceSPR.2bpp \
SRC/gfx/titleCredits/itemFont.2bpp SRC/gfx/titleCredits/theEnd.2bpp \
SRC/gfx/titleCredits/creditsSprTilesVaria.2bpp SRC/gfx/titleCredits/creditsSprTilesSuitless.2bpp \
SRC/gfx/titleCredits/creditsNumbers.2bpp \
SRC/gfx/titleCredits/creditsFont.2bpp SRC/gfx/titleCredits/titleScreen.2bpp \
SRC/gfx/samus/hud.2bpp \
SRC/gfx/samus/samusPowerSuit.2bpp SRC/gfx/samus/samusVariaSuit.2bpp \
SRC/gfx/samus/cannonBeam.2bpp SRC/gfx/samus/cannonMissile.2bpp \
SRC/gfx/samus/beamIce.2bpp SRC/gfx/samus/beamWave.2bpp SRC/gfx/samus/beamSpazer.2bpp SRC/gfx/samus/beamPlasma.2bpp \
SRC/dmg/m2dmg.2bpp \

allattrmap := $(all2bpp:%.2bpp=%.attrmap)

all: SRC/gfx/titleCredits/titleScreen_add80.tilemap $(all2bpp) $(allattrmap) out/ejrtq.gbc

SRC/dmg/m2dmg.2bpp SRC/dmg/m2dmg.pal SRC/dmg/m2dmg.tilemap SRC/dmg/m2dmg.attrmap: SRC/dmg/m2dmg.png
	rgbgfx -o $(basename $@).2bpp $< -u -P -T -A

SRC/gfx/titleCredits/creditsSprTilesVaria.2bpp SRC/gfx/titleCredits/creditsSprTilesVaria.attrmap: SRC/gfx/titleCredits/creditsSprTilesVaria.png
SRC/gfx/titleCredits/creditsSprTilesSuitless.2bpp SRC/gfx/titleCredits/creditsSprTilesSuitless.attrmap: SRC/gfx/titleCredits/creditsSprTilesSuitless.png
SRC/gfx/titleCredits/creditsSprTilesVaria.2bpp SRC/gfx/titleCredits/creditsSprTilesVaria.attrmap SRC/gfx/titleCredits/creditsSprTilesSuitless.2bpp SRC/gfx/titleCredits/creditsSprTilesSuitless.attrmap:
	rgbgfx -o $(basename $@).2bpp $< -c gbc:SRC/gfx/titleCredits/creditsSprTiles.pal -Z -A

SRC/gfx/titleCredits/creditsNumbers.2bpp SRC/gfx/titleCredits/creditsNumbers.attrmap: SRC/gfx/titleCredits/creditsNumbers.png
	rgbgfx -o $(basename $@).2bpp $< -c gbc:SRC/gfx/color_all.pal -n 16 -Z -A

SRC/gfx/titleCredits/titleScreen.2bpp SRC/gfx/titleCredits/titleScreen.pal SRC/gfx/titleCredits/titleScreen.tilemap SRC/gfx/titleCredits/titleScreen.attrmap: SRC/gfx/titleCredits/titleScreen.png
	rgbgfx -o $(basename $@).2bpp $< -u -P -T -A

SRC/gfx/titleCredits/titleScreen_add80.tilemap: SRC/gfx/titleCredits/titleScreen.tilemap
	python scripts/fix_titleScreenTilemap.py SRC/gfx/titleCredits/titleScreen.tilemap

SRC/gfx/enemies/queenSPR.2bpp SRC/gfx/enemies/queenSPR.attrmap: SRC/gfx/enemies/queenSPR.png
	rgbgfx -o $(basename $@).2bpp $< -c gbc:SRC/gfx/enemies/queen_all.pal -n 16 -A

%.2bpp %.attrmap: %.png
	rgbgfx -o $(basename $@).2bpp $< -c gbc:SRC/gfx/color_all.pal -n 16 -A

out/game.o: SRC/game.asm SRC/bank_*.asm out
	rgbasm -o $@ -I $(<D) $<

out/ejrtq.gbc: out/game.o
	rgblink -n out/ejrtq.sym -m out/ejrtq.map -o $@ $<
	rgbfix -v $@

	@if which md5sum &>/dev/null; then md5sum $@; else md5 $@; fi

out:
	mkdir $@

clean:
	rm -f out/game.o out/ejrtq.gbc out/ejrtq.sym out/ejrtq.map SRC/gfx/titleCredits/titleScreen.pal
	find . \( -iname '*.2bpp' -o -iname '*.attrmap' -o -iname '*.tilemap' \) -exec rm {} +
