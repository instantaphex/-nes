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