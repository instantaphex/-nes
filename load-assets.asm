;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Load Assets
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
load_palettes:
  lda $2002    ; read PPU status to reset the high/low latch
  lda #$3F
  sta $2006    ; write the high byte of $3F00 address
  lda #$00
  sta $2006    ; write the low byte of $3F00 address
  ldx #$00
:
  lda palette, x        ;load palette byte
  sta $2007             ;write to PPU
  inx ;set index to next byte
  cpx #$20            
  bne :- ;if x = $20, 32 bytes copied, all done
	rts	

;load_sprites:
;	ldx #$00			;init sentinel to 0
;:
;	lda player_walking_1, x
;	sta oam, x	;store into ram address ($200 + x)
;	inx ;x++
;	cpx #$10			
;	bne :- 
;	rts	

load_background:
	lda $2002				; reset high/low latch
	lda #$20
	sta $2006				; write high byte
	lda #$00
	sta $2006				; write low byte

	; set up pointer to bg
	lda #<background  ; #LOW(background) ; #$00
	sta bg_ptr_low  ; put low byte of bg into pointer
	lda #>background ; #HIGH(background)
	sta bg_ptr_hi   ; put high byte into pointer

	ldx #$04
	ldy #$00
:
	lda (bg_ptr_low), y	; one byte from address + y
	sta $2007
	iny ; increment inner loop counter
	bne :- 
	inc bg_ptr_hi
  dex 
	bne :- 
	rts
