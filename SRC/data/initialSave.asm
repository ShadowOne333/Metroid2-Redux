	dw $07D4     ; Samus' Y position
	dw $0648     ; Samus' X position
	dw $07C0     ; Screen Y position
	dw $0640     ; Screen X position
	
    ; No bank for enemy graphics
	dw gfxInfoSmall_surfaceSPR      ; Enemy tiles source address
	db BANK(gfx_surfaceBG) ; Background tiles source bank
	dw gfxInfoSmall_surfaceBG       ; Background tiles source address
    ; No bank for metatiles
	dw metatiles_surface   ; Metatile definitions source address
    ; No bank for collision
	dw collision_surface   ; Collision data source address
	dw palettes_surface
	db $0F       ; Bank for current room
	
	db $4d       ; Samus solid block threshold
	db $4d       ; Enemy solid block threshold
	db $4d       ; Projectile solid block threshold
	
	db $00       ; Samus' equipment
	db $00       ; Samus' beam
	db $00       ; Samus' energy tanks
	dw $0099     ; Samus' health
	dw $0030     ; Samus' max missiles
	dw $0030     ; Samus' missiles
	
	db $01       ; Direction Samus is facing
	db $02       ; Acid damage
	db $08       ; Spike damage
	db $47       ; Real number of Metroids remaining
	db $04       ; Song for room
	db $00       ; In-game timer, minutes
	db $00       ; In-game timer, hours
	db $39       ; Number of Metroids remaining
