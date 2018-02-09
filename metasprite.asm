LEFT = 1
RIGHT = 0

.macro draw_2x2_metasprite sprite_frame, the_x, the_y, direction, id
	; set up pointer to current animation frame
	load_pointer sprite_addr, sprite_frame
	lda the_x
	sta sprite_x
	lda the_y
	sta sprite_y
	lda direction
	sta sprite_direction
	lda id
	sta sprite_id
	jsr draw_metasprite
	rts
.endmacro

.proc draw_metasprite
    ; set up oam offset based on sprite id
    ldy sprite_id ; sprite id 0
    lda sprite_id_constants, y ; low byte for oam offset
    ldy #$00
	:
		; deal with byte 0 - y pos
		lda (sprite_addr), y
		clc
		adc sprite_y 
		sta oam, x

		; deal with byte 1 - tile
		iny
        inx
		lda (sprite_addr), y
		sta oam, x

		; deal with byte 2 - attributes
		iny
        inx
		lda sprite_direction
		cmp #LEFT
		beq set_flipped_horizontal
		; if we don't need to flip, just set whats defaulted
		lda #%00000000
		sta oam, x
		jmp done_flipping_sprite
set_flipped_horizontal:
		lda #%01000000
		sta oam, x
done_flipping_sprite:

		; deal with byte 3 - x pos
		iny
        inx
		; if player is facing left subtract offset if not, add it
		lda sprite_direction
		cmp #LEFT
		bne add_offset
subtract_offset:
		; put offset into tmp
		lda sprite_x
		sec
		sbc (sprite_addr), y
		sta oam, x
		jmp :+
add_offset:
		lda (sprite_addr), y
		clc
		adc sprite_x 
		sta oam, x
        :
		; increase y by for to start at the next row	
		iny
        inx
        ; increase x for oam
		cpy #$10 ; loop four times, once per row
	bne :--
	rts
.endproc