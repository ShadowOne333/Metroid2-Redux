; ------------------------------------------------------------------------------
;                    Super Game Boy border injector template
;                             by Marc Robledo 2024
;
;   More info at https://github.com/marcrobledo/super-game-boy-border-injector
; ------------------------------------------------------------------------------

; GAME BOOT OFFSET
; ----------------
; Put here the game's boot jp offset found in in $0101.
; Usually $0150, but could be different depending on game.
DEF GAME_BOOT_OFFSET EQU $0150

; BANK 0 ROM FREE SPACE
; ---------------------
; 16 bytes in bank 0 are needed for the game's boot hook subroutine.
; Hopefully, there should be enough space at the end of bank 0 or in the
; interruption or rst vector ($0000-$00ff).
; In the worst scenario, you will need to carefully move some code/data to
; other banks.
;DEF BANK0_FREE_SPACE EQU $3FF0	; Removed in favour of the Bank 0 free space label

; MBC type
; --------
; (see more here: https://gbdev.io/pandocs/MBCs.html)
; MBC needs to be here specified in these special cases:
; - MBC1 + expanded ROM to 1Mb or bigger (Zelda Link's Awakening [non-DX])
; - MBC2 (bank to switch has to be written to $2100 instead of $2000: https://gbdev.io/pandocs/MBC2.html#registers)
; - (to-do!) MBC5 + expanded ROM to 8Mb
; other cases will just ignore this value
; keep in mind that, in these special cases, the hook subroutine will grow
; from 16 bytes to 25 bytes!
DEF MBC EQU 5

; NEW CODE LOCATION
; -----------------
; We need an empty bank to store all new code plus border data, which will be
; quite big.
; If the game has no empty bank, just use a bank higher than the original
; game's bank number, RGBDS will expand the ROM and fix the header.
; Safe bank numbers, depending on original game's ROM size:
; - 32kb   --> impossible to do it without changing MBC
; - 64kb   --> bank $04
; - 128kb  --> bank $08
; - 256kb  --> bank $10
; - 512kb  --> bank $21 (bank $20 needs more code to be accessed in MBC1)
; - 1024kb --> bank $41 (bank $40 needs more code to be accessed in MBC1)
DEF SGB_CODE_BANK EQU $12	; Originally Bank $21, change to Bank $12 for Metroid 2

; CUSTOM GB PALETTE
; -----------------
; set CUSTOM_GB_PALETTE_ENABLED to 1 if you want a custom GB palette for the
; entire game screen
; colors are RGB15 which means RGB components can go from 0 up to 31
; warning: even if set to 0, do not delete BUILD_CUSTOM_GB_PALETTE macro!
DEF CUSTOM_GB_PALETTE_ENABLED EQU 0
MACRO BUILD_CUSTOM_GB_PALETTE
    RGB 27, 30, 25	;color 0 (light)
    RGB 17, 23, 14	;color 1
    RGB 6, 13, 10	;color 2
    RGB 1, 3, 4		;color 3 (dark)
ENDM
