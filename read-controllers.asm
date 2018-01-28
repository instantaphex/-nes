ReadController1:
	; latch buttons player 1
  LDA #$01
	STA $4016
  LDA #$00
	STA $4016
	LDX #$08
ReadController1Loop:
	LDA $4016
	LSR A			   ; Put controller pressed bool in carry
	ROL buttons1 ; put carry into buttons1
	DEX					 ; x -= 1
	BNE ReadController1Loop  ; DEX will set zero flag if the count down is complete.  BNE will check zero flag
	RTS

ReadController2:
	; latch buttons player 1
  LDA #$01
	STA $4017
  LDA #$00
	STA $4017
	LDX #$08
ReadController2Loop:
	LDA $4017
	LSR A			   ; Put controller pressed bool in carry
	ROL buttons2 ; put carry into buttons2
	DEX					 ; x -= 1
	BNE ReadController2Loop  ; DEX will set zero flag if the count down is complete.  BNE will check zero flag
	RTS
