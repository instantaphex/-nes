read_controller_1:
	; latch buttons player 1
  lda #$01
	sta $4016
  lda #$00
	sta $4016
	ldx #$08
@loop:
	lda $4016
	lsr A			   ; Put controller pressed bool in carry
	rol buttons1 ; put carry into buttons1
	dex ; x -= 1
	bne @loop; DEX will set zero flag if the count down is complete.  BNE will check zero flag
	rts	

read_controller_2:
	; latch buttons player 1
  lda #$01
	sta $4017
  lda #$00
	sta $4017
	ldx #$08
@loop:
	lda $4017
	lsr A			   ; Put controller pressed bool in carry
	rol buttons2 ; put carry into buttons2
	dex ; x -= 1
	bne @loop ; DEX will set zero flag if the count down is complete.  BNE will check zero flag
	rts
