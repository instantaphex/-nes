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
	lda #%00000001
  sta $4015 ;enable square 1

  lda #%10111111 ;Duty 10, Volume F
  sta $4000

  lda #$C9    ;0C9 is a C# in NTSC mode
  sta $4002
  lda #$00
  sta $4003
	RTS

PlayerBPressed:
	RTS

PlayerStartPressed:
	RTS

PlayerSelectPressed:
	RTS

PlayerUpPressed:
	LDX #$00
MoveUpLoop:
	LDA $0200, x ; get sprite 1 y pos
	SEC				   ; set carry
	SBC #$01     ; y -= 1
	STA $0200, x
	INX
	INX
	INX
	INX
	CPX #$10
	BNE MoveUpLoop
	RTS

PlayerDownPressed:
	LDX #$00
MoveDownLoop:
	LDA $0200, x ; get sprite 1 y pos
  CLC				   ; clear carry
	ADC #$01     ; y += 1
	STA $0200, x ; move all 4 sprites
	INX
	INX
	INX
	INX
	CPX #$10
	BNE MoveDownLoop
	RTS

PlayerLeftPressed:
	LDX #$00
MoveLeftLoop:
	; first flip sprite horizontally
	LDA $0202, x     ; get attribute byte
	ORA #%01000000   ; flip horizontally
	STA $0202, x     ; store the flip

	LDA $0203, x ; get sprite 1 x pos
	SEC				   ; set carry
	SBC #$01     ; x -= 1
	STA $0203, x ; move all 4 sprites

	INX
	INX
	INX
	INX
	CPX #$10
	BNE MoveLeftLoop
	RTS

PlayerRightPressed:
	LDX #$00
MoveRightLoop:
	LDA $0203, x     ; get sprite 1 x pos
	CLC				       ; clear carry
	ADC #$01         ; x += 1
	STA $0203, x     ; move all 4 sprites

	; unset flip sprite horizontally
	LDA $0202, x     ; get attribute byte
	AND #%01000000   ; check if flipped
	BEQ DontFlip
	EOR #%01000000   ; flip horizontally
	STA $0202, x     ; store the flip
DontFlip:
	INX
	INX
	INX
	INX
	CPX #$10
	BNE MoveRightLoop
	RTS
