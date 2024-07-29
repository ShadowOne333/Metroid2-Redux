; Disassembly of "m2 ejrtq v1.3.gbc"
; This file was created with:
; mgbdis v2.0 - Game Boy ROM disassembler by Matt Currie and contributors.
; https://github.com/mattcurrie/mgbdis

INCLUDE "hardware.inc"

INCLUDE "constants.asm"
INCLUDE "data/enemy_nameConstants.asm"
INCLUDE "macros.asm"

; RAM definitions
INCLUDE "ram/vram.asm"
INCLUDE "ram/sram.asm"
INCLUDE "ram/wram.asm"
INCLUDE "ram/hram.asm"

; ROM start
INCLUDE "bank_000.asm" ; excellent
INCLUDE "bank_001.asm" ; perfect
INCLUDE "bank_002.asm" ; perfect
INCLUDE "bank_003.asm" ; good
INCLUDE "bank_004.asm" ; perfect
INCLUDE "bank_005.asm" ; excellent
INCLUDE "bank_006.asm" ; perfect
INCLUDE "bank_007.asm" ; perfect
INCLUDE "bank_008.asm" ; perfect
INCLUDE "maps/bank_009.asm"
INCLUDE "maps/bank_00a.asm"
INCLUDE "maps/bank_00b.asm"
INCLUDE "maps/bank_00c.asm"
INCLUDE "maps/bank_00d.asm"
INCLUDE "maps/bank_00e.asm"
INCLUDE "maps/bank_00f.asm"
INCLUDE "bank_010.asm" ; good
INCLUDE "bank_011.asm" ; good
