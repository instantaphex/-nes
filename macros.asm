;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Macro to point a pointer to an address
;
; usage:
;		LoadPointer pointer, address
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro load_pointer ptr, addr
	lda #<addr
	sta ptr + 0
	lda #>addr
	sta ptr + 1
.endmacro

.macro add16 addr, amt
	clc
	lda addr
	adc amt
	sta addr
	lda addr+1
	adc #$00
	sta addr+1
.endmacro