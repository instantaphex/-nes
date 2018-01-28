LatchButtons:
	LDA #$01
	STA $4016
	LDA #$00
	STA $4016

ReadA:
	LDA $4016
	AND #%00000001
	BEQ ReadADone ; if a ins't pressed, skip the rest
	
	; A button logic

ReadADone:

ReadB:
	LDA $4016
	AND #%00000001
	BEQ ReadBDone

	; b button logic

ReadBDone:

ReadSelect:
	LDA $4016
	AND #%00000001
	BEQ ReadSelectDone
	
	; select logic

ReadSelectDone:

ReadStart:
	LDA $4016
	AND #%00000001
	BEQ ReadStartDone
	
	; start logic

ReadStartDone:

ReadUp:
	LDA $4016
	AND #%00000001
	BEQ ReadUpDone

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

ReadUpDone:

ReadDown:
	LDA $4016
	AND #%00000001
	BEQ ReadDownDone

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

ReadDownDone:

ReadLeft:
	LDA $4016
	AND #%00000001
	BEQ ReadLeftDone

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

ReadLeftDone:

ReadRight:
	LDA $4016
	AND #%00000001
	BEQ ReadRightDone

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

ReadRightDone:
