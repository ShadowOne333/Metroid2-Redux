# METROID 2: RETURN OF SAMUS REDUX

----------------------------------------------------------------------------------

# **Index**

* [**Metroid 2 Redux Info**](#metroid-2-redux)

* [**Proposed Features**](#proposed-features)
<!--* [**Changelog**](#changelog)-->

* [**Optional Patches**](#optional-patches)

* [**Patching and Usage Instructions**](#instructions)

* [**Build Instructions**](#build-instructions)

* [**Credits**](#credits)

* [**Project Licence**](#license)

-------------------

## Metroid 2 Redux

This is the source code for a Metroid 2 Redux romhack.
This source code and romhack is based on the initial disassembly work made by [MarioFan2468](https://forum.metroidconstruction.com/index.php?action=profile;u=45628) from the [Metroid Construction](https://forum.metroidconstruction.com/) forums of the original [Metroid II - EJRTQ Colorization](https://www.romhacking.net/hacks/4388/) romhack.

Original description from the disassembly:
> A disassembly of one of my favorite Game Boy games. A first-pass over every function of code has been completed, but there are still plenty of improvements to be made to make the code more intelligible and usable. Feel free to contribute.

MarioFan2468's Source Code release can be found in this post at Metroid Construction:
https://forum.metroidconstruction.com/index.php/topic,5789.msg73737.html#msg73737

-------------------

## Proposed Features

* (DONE) Full disassembly of the EJRTQ romhack. Original disassembly by MarioFan2468, further modified by ShadowOne333.
* (DONE) Reworked the Credits/Ending Suitless Samus' palette to match the canon depiction colours for Samus. Similar to the ["Canon Samus"](https://www.romhacking.net/hacks/4579/) patch from RHDN.
* (DONE) Fixed some rogue pixels in Samus' sprites for her visor.
* (DONE) Implemented a bunch of Improvement Patches documented in the disassembly by MarioFan2468 into the main source code EJRTQ disassembly. These include:
	- Pause during the Queen Metroid fight
	- Improved Spider Ball
	- Intersection transition
	- Vertical Enemy Loading fix
* Implement a proper [Map system based on the Map Patch by Moehr](https://forum.metroidconstruction.com/index.php/topic,5569.0.html)
* Implement beam stacking, this means that getting Ice Beam and Spazer should give the effects of both beams combined, same with Wave+Ice, and so on (like in Super Metroid).
* (DONE) Change Missile Doors requirement from 5 to 1 (Located in Bank 02, Line 7631)
* (DONE)  Change small energy amount from 5 to 10 (Located in Bank 02, Line 469)
* Make Morph Ball roll only when moving, otherwise stay still.
* Change Bomb timings (Possibly implement some pseudo IBJ)
* Change Plasma Beam colour to green. This would probably require splitting both Spazer and Plasma into two graphics and colouring the Plasma one green
* Make it so Space Jump can be triggered again even if Samus returns to her upright stance, or if the next input for the next jump failed (to avoid having to fall all the way down before being able to re-enable Space Jump)
* Make all frozen enemies blue (some get turned to purple when hit with the Ice Beam, this is particularly noticeable when there's enemies with two different palettes and they get frozen)
* Add Health and Missiles refills to the Omega Nest

## Colour Changes:

* (DONE) Recolour Samus' Gunship
* (DONE) Recolour Suitless Samus' in the credits' special ending to match her canon design
* (DONE) Change the colour of the dark brown background in the first tunnel area to be darker (Right from Landing Site)

* (DONE) Recolour sprites based on the original artwork found here:
	https://metroiddatabase.com/wp-content/uploads/Metroid-2-Return-of-Samus/art/m2_enemies-1800x837.jpg
	- Samus' Spring Ball sprite (was all white since the initial DX release)

	ENEMIES: (DONE)
	- Arachnus (Changed colours to match artwork)
	- Hornoad underbellyoad (Dark Green -> Yellowish)
	- Autoad (Green -> Blue with Purple claws)
	- Gullug (Properly recolour the wings)
	- Halzyn (Green? -> Blue with Purple body)
	- Pincherfly (Changed to Green with Red)
	- Shirk (Green -> White with Blue)
	- Skorp (Green/Red -> Red with Blue)
	- Octrol (Red -> Purple)
	- Drivel (Purple -> Yellowish)
	- Yumme (Changed to Blue)
	- Skreek (Add yellow detail in mouth)
	- Ramulken (Make its lower body red)
	- Gunzoo (Changed eye colour)
		
	METROIDS: (DONE) 
	- Gamma Metroid -> Recoloured outer shell
	- Zeta Metroid -> This one needs a proper recolour, otherwise it looks too yellow. Recoloured its shell parts to be somewhat green-ish instead of Yellow. Also made its arms yellowish.
	- Omega Metroid -> Recoloured its shell parts to be somewhat green-ish instead of Yellow. Also made its arms yellowish.
	- Queen Metroid -> Recoloured parts of her mouth, legs and also her stretching neck. The neck for some reason doesn't detect some palettes, so I worked with what I could.

-------------------

## Optional patches

(The following patches are not implemented yet)
* Save Stations refill both health and missiles
* Heavy Physics: Change Samus' falling speed to be quicker (?). A Heavy physics patch (simialr to Super Metroid Redux) in other words so Samus doesn't feel so floaty.
* Remove the Alarm that sounds when Samus' Health is low.

-------------------

## Instructions

To play Metroid 2 Redux, the following is required:

* mGBA - GBA Emulator
* Metroid II GB ROM with the following info:
	- Metroid II - Return of Samus (World).gb
	- No-intro ROM
	- CRC32: 9639948ad274fa15281f549e5f9c4d87
	- MD5: 9639948AD274FA15281F549E5F9C4D87
	- SHA-1: 74A2FAD86B9A4C013149B1E214BC4600EFB1066D

* Lunar IPS or Floating IPS (FLIPS) patchers, or [Romhacking.net's Online Patcher by Marc Robledo](https://www.romhacking.net/patch/)
* Metroid2_Redux.ips patch

Grab the patches from inside the /patches/ folder from the GitHub page, or alternatively, download the .zip file from the Releases page (once a proper release is out) and apply the patch over your Zelda II ROM with Lunar IPS.

If you want to apply any of the optional patches, you can use each Optional patch individually from inside the /patches/optional folder depending on your liking over your already patched Metroid 2 Redux ROM, or you can either compile them manually from the source code, although this is not recommended if you are not familiar with compilations or Z80 assembly.

-------------------

## Build Instructions

1. Install [rgbds](https://github.com/rednex/rgbds#1-installing-rgbds)
2. Either run `make all` or `build.bat`, depending on your preference.
3. The assembled game and a [BGB](http://bgb.bircd.org/) compatible `.sym` file will appear in the `out` folder.

The resultant file should have this hash: `md5: 9639948ad274fa15281f549e5f9c4d87`

## How to Contribute

1. Fork this repository (if you please).
2. Make something better. Perhaps start by doing something like:
   - Checking the issue tracker.
   - Giving a function or variable a (better) name.
   - Properly defining a RAM address (eg. labelName: ds 1).
   - Turning a magic number into a constant.
   - Turning a raw pointer (eg. $4242) into a proper label (eg. enemyAI_squeek).
   - Adding a missing label.
   - Adding informative comments.
   - etc.
3. Verify that your changes still result in a byte-for-byte identical game.
4. Submit a pull request.

Please refrain from moving any chunk of code into a separate file without first discussing it in the issue tracker.

If you have questions or comments, please drop by the #metroid-ii channel on the [MetConst Discord](https://discord.gg/xDwaaqa).

## Directory Structure

Subject to change.

- `docs` - Assorted notes regarding the game's formats and structure
- `out` - Output directory for the build process
- `scripts` - Various scripts to extra data from the game
- `patches` - Basic modifications to improve or change the game.
- `SRC` - Top level source code
- `SRC/data` - General data that hasn't been or can't be categorized elsewhere
- `SRC/gfx` - Generic tile data
- `SRC/maps` - Level data banks, along with the associated enemy data and door scripts
- `SRC/ram` - Definitions/declarations for VRAM, SRAM, WRAM, and HRAM.
- `SRC/tilesets` - Tile graphics, metatile definitions, and collision tables for each tileset

## Resources

- [mgbdis](https://github.com/mattcurrie/mgbdis) - The disassember used to create this project.
- [PJ's Bank Logs](http://patrickjohnston.org/ASM/ROM%20data/RoS/) - A rather extensive, but unbuildable, disassembly of the game.
- [MetConst Wiki](https://wiki.metroidconstruction.com/doku.php?id=return_of_samus) - Some of the information here is outdated.
- [M2 Music Tools](https://github.com/kkzero241/M2MusicTools) - A song extractor written by kkzero.
- [LA DX Disassembly](https://github.com/zladx/LADX-Disassembly) - A disassembly project of another game that also uses rgbds.

### Editors

- [M2Edit](https://m2sw.zophar.net/m2edit/) - Abandoned editor from 2004. Stable, but closed source and lacks enemy and door editing capabilities.
- [ROSE](https://github.com/liamnajor/ROSE) - WIP editor. Web based.
- [YAM2E](https://github.com/ConConner/YAM2E) - Very early WIP editor.

-------------------

## Credits

* **MarioFan2468** - For the original disassembly of the EJRTQ romhack, which this project is based on.
* **Moehr** - For the Map Patch for Metroid II.
* **Quantam / Justin Olbrantz** - For the original [Metroid II - EJRTQ 1.3](https://www.romhacking.net/hacks/4388/) colorization of the hack.
* **Azurelore** - For the original [Metroid II - EJRT 1.2 colorization hack](https://www.aderack.com/m2/), which Quantam complete rewrote and continued with EJRTQ 1.3


-------------------

## License

Metroid 2 Redux is a project licensed under the terms of the GPLv3, which means that you are given legal permission to copy, distribute and/or modify this project, as long as:

1) The source for the available modified project is shared and also available to the public without exception.
2) The modified project subjects itself different naming convention, to differentiate it from the main and licensed Metroid 2 Redux project.

You can find a copy of the license in the LICENSE file.

