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

.macro load_pointer_from_ptr ptr, addr_ptr
	lda addr_ptr + 0
	sta ptr + 0
	lda addr_ptr + 1
	sta ptr + 1
.endmacro