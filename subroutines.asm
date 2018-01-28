vblankwait:
  BIT $2002
  BPL vblankwait
	RTS

DMACopy:
  LDA #$00
  STA $2003  ; set the low byte (00) of the RAM address
  LDA #$02
  STA $4014  ; set the high byte (02) of the RAM address, start the transfer
	RTS
