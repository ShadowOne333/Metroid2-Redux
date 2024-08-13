import os
import subprocess
import hashlib

def run_or_exit(args, err):
    completed_process = subprocess.run(args, shell=True)
    if completed_process.returncode != 0:
        print("\n" + err + "\n")
        exit(completed_process.returncode)
        

all_gfx = ["SRC/gfx/items", "SRC/gfx/itemOrb", "SRC/gfx/commonItems", "SRC/gfx/enemies/enemiesA", "SRC/gfx/enemies/enemiesB", "SRC/gfx/enemies/enemiesC", "SRC/gfx/enemies/enemiesD", "SRC/gfx/enemies/enemiesE", "SRC/gfx/enemies/enemiesF", "SRC/gfx/enemies/arachnus", "SRC/gfx/enemies/metAlpha", "SRC/gfx/enemies/metGamma", "SRC/gfx/enemies/metZeta", "SRC/gfx/enemies/metOmega", "SRC/gfx/enemies/queenSPR", "SRC/gfx/enemies/surfaceSPR", "SRC/gfx/titleCredits/itemFont", "SRC/gfx/titleCredits/theEnd", "SRC/gfx/titleCredits/creditsSprTilesVaria", "SRC/gfx/titleCredits/creditsSprTilesSuitless", "SRC/gfx/titleCredits/creditsNumbers", "SRC/gfx/titleCredits/creditsFont", "SRC/gfx/titleCredits/titleScreen", "SRC/gfx/samus/hud", "SRC/gfx/samus/samusPowerSuit", "SRC/gfx/samus/samusVariaSuit", "SRC/gfx/samus/cannonBeam", "SRC/gfx/samus/cannonMissile", "SRC/gfx/samus/beamIce", "SRC/gfx/samus/beamWave", "SRC/gfx/samus/beamSpazer", "SRC/gfx/samus/beamPlasma"]


if not os.path.exists('out/'):
    os.mkdir('out/')
    
print('Running scripts')
run_or_exit("python ./scripts/enemy_csv2asm.py -i ./SRC/data/enemies.csv -o ./SRC/data", "Script Error.")
run_or_exit("python ./scripts/samus_csv2asm.py -i ./SRC/samus/samus.csv -o ./SRC/samus", "Script Error.")
print('Success\n')

completed_process = subprocess.run("rgbasm -V", shell=True)
if completed_process.returncode != 0:
    print("RGBDS not detected. Downloading...")
    run_or_exit("curl -LJO \"https://github.com/gbdev/rgbds/releases/download/v0.7.0/rgbds-0.7.0-win32.zip\"", "Failed to download.")
    run_or_exit("tar -xvf rgbds-0.7.0-win32.zip", "Failed to extract RGBDS archive.")
    run_or_exit("rgbasm -V", "Unable to use downloaded RGBDS.")

print('RGBDS detected')

print('Converting graphics')
for gfx in all_gfx:
    if gfx.startswith("SRC/gfx/titleCredits/creditsSprTiles"):
        run_or_exit("rgbgfx -o " + gfx + ".2bpp " + gfx + ".png -c gbc:SRC/gfx/titleCredits/creditsSprTiles.pal -Z -A", "Converter Error.")
    elif gfx == "SRC/gfx/titleCredits/creditsNumbers":
        run_or_exit("rgbgfx -o " + gfx + ".2bpp " + gfx + ".png -c gbc:SRC/gfx/color_all.pal -n 16 -Z -A", "Converter Error.")
    elif gfx == "SRC/gfx/titleCredits/titleScreen":
        run_or_exit("rgbgfx -o " + gfx + ".2bpp " + gfx + ".png -u -P -T -A", "Converter Error.")
        run_or_exit("python scripts/fix_titleScreenTilemap.py SRC/gfx/titleCredits/titleScreen.tilemap", "Script Error.")
    elif gfx == "SRC/gfx/enemies/queenSPR":
        run_or_exit("rgbgfx -o " + gfx + ".2bpp " + gfx + ".png -c gbc:SRC/gfx/enemies/queen_all.pal -n 16 -A", "Converter Error.")
    else:
        run_or_exit("rgbgfx -o " + gfx + ".2bpp " + gfx + ".png -c gbc:SRC/gfx/color_all.pal -n 16 -A", "Converter Error.")
print('Success\n')

print('Assembling .asm files')
run_or_exit("rgbasm -o out/game.o -I SRC/ SRC/game.asm", "Assembler Error.")
print('Success\n')

print('Linking .o files')
run_or_exit("rgblink -n out/ejrtq.sym -m out/ejrtq.map -o out/ejrtq.gb out/game.o", "Linker Error.")
print('Success\n')

print('Fixing header')
run_or_exit("rgbfix -v out/ejrtq.gb", "RGBFIX Error.")
print('Done\n')

with open("out/ejrtq.gb", "rb") as f:
    md5_hash = hashlib.md5(f.read())
print('MD5 hash: ' + md5_hash.hexdigest())
