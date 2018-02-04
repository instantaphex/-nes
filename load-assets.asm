;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Load Assets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LoadPalettes:
  LDA $2002    ; read PPU status to reset the high/low latch
  LDA #$3F
  STA $2006    ; write the high byte of $3F00 address
  LDA #$00
  STA $2006    ; write the low byte of $3F00 address
  LDX #$00
LoadPalettesLoop:
  LDA palette, x        ;load palette byte
  STA $2007             ;write to PPU
  INX                   ;set index to next byte
  CPX #$20            
  BNE LoadPalettesLoop  ;if x = $20, 32 bytes copied, all done
	RTS

LoadSprites:
	LDX #$00			;init sentinel to 0
LoadSpritesLoop:
	LDA player_right_meta, x
	STA $200, x	;store into ram address ($200 + x)
	INX						;x++
	CPX #$10			;if (x != $04) 
	BNE LoadSpritesLoop
	RTS

LoadBackground:
	LDA $2002				; reset high/low latch
	LDA #$20
	STA $2006				; write high byte
	LDA #$00
	STA $2006				; write low byte

	; set up pointer to bg
	LDA #LOW(background) ; #$00
	STA bg_ptr_low  ; put low byte of bg into pointer
	LDA #HIGH(background)
	STA bg_ptr_hi   ; put high byte into pointer

	LDX #$04
	LDY #$00
LoadBackgroundLoop:
	LDA [bg_ptr_low], y	; one byte from address + y
	STA $2007
	INY									; increment inner loop counter
	BNE LoadBackgroundLoop 
	INC bg_ptr_hi
  DEX	
	BNE LoadBackgroundLoop
	RTS
