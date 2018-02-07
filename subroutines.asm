vblank_wait:
  bit $2002
  bpl vblank_wait
	rts

dma_copy:
  lda #$00
  sta $2003  ; set the low byte (00) of the RAM address
  lda #$02
  sta $4014  ; set the high byte (02) of the RAM address, start the transfer
	rts
