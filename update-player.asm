;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Set initial player values		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
InitPlayer:
	; set position
	LDA #$80
	STA player_x
	STA player_y

	; set speed x and y
	LDA #$00
	STA player_speed_x
	STA player_speed_y

	; set direction
	LDA #$00
	STA player_direction
	RTS


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Macro to point a pointer to an address
;
; usage:
;		LoadPointer pointer, address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LoadPointer .macro
	LDA #LOW(\2)
	STA \1 + 0
	LDA #HIGH(\2)
	STA \1 + 1
	.endm


LoadCurrentPlayerSprite:
	LDX #$00
loadPlayerOamBuffLoop:
	LDA player_curr_sprite, x
	STA OAM_BUFFER, x
	INX
	CPX #$10
	BNE loadPlayerOamBuffLoop
	RTS
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Draw players current sprite
;
; usage:
;		LoadPointer player_curr_sprite, player_right_meta
;   JSR DrawMetaSprite
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DrawMetaSprite:
	JSR LoadCurrentPlayerSprite

	; set y position
	LDA player_y
	STA OAM_BUFFER + 8
	STA OAM_BUFFER + 12 
	CLC
	ADC #$08
	STA OAM_BUFFER
	STA OAM_BUFFER + 4

	; set x position
	LDA player_x
	STA OAM_BUFFER + 7
	STA OAM_BUFFER + 15
	CLC
	ADC #$08
	STA OAM_BUFFER + 3
	STA OAM_BUFFER + 11 
	RTS

DrawPlayer:
	LDA player_direction
	CMP #$01
	BEQ DrawPlayerLeft

DrawPlayerRight:
	LoadPointer player_curr_sprite, player_right_meta
	JSR DrawMetaSprite
	JMP DrawPlayerDone

DrawPlayerLeft:
	LoadPointer player_curr_sprite, player_left_meta
	JSR DrawMetaSprite
DrawPlayerDone:
	RTS

UpdatePlayer:
	LDA buttons1
	AND #%10000000
	BNE PlayerAPressed

	LDA buttons1
	AND #%01000000
	BNE PlayerBPressed
	
	LDA buttons1
	AND #%00100000
	BNE PlayerStartPressed

	LDA buttons1
	AND #%00010000
	BNE PlayerSelectPressed

	LDA buttons1
	AND #%00001000
	BNE PlayerUpPressed

	LDA buttons1
	AND #%00000100
	BNE PlayerDownPressed

	LDA buttons1
	AND #%00000010
	BNE PlayerLeftPressed

	LDA buttons1
	AND #%00000001
	BNE PlayerRightPressed

	RTS	

PlayerAPressed:
	RTS

PlayerBPressed:
	RTS

PlayerStartPressed:
	RTS

PlayerSelectPressed:
	RTS

PlayerUpPressed:
	DEC player_y
	RTS

PlayerDownPressed:
	INC player_y
	RTS

PlayerLeftPressed:
	LDA #$01
	STA player_direction
	DEC player_x
	RTS

PlayerRightPressed:
	LDA #$00
	STA player_direction
	INC player_x
	RTS
