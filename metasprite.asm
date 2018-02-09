LEFT = 1
RIGHT = 0

.proc draw_metasprite
    ; set up oam offset based on sprite id
    ldx sprite_id ; sprite id 0
    ldy sprite_id_constants, x ; low byte for oam offset
	:
		; deal with byte 0 - y pos
		lda (sprite_addr), y
		clc
		adc sprite_y 
		sta oam, y

		; deal with byte 1 - tile
		iny
		lda (sprite_addr), y
		sta oam, y

		; deal with byte 2 - attributes
		iny
		lda sprite_direction
		cmp #LEFT
		beq set_flipped_horizontal
		; if we don't need to flip, just set whats defaulted
		lda #%00000000
		sta oam, y
		jmp done_flipping_sprite
set_flipped_horizontal:
		lda #%01000000
		sta oam, y
done_flipping_sprite:

		; deal with byte 3 - x pos
		iny
		; if player is facing left subtract offset if not, add it
		lda sprite_direction
		cmp #LEFT
		bne add_offset
subtract_offset:
		; put offset into tmp
		lda sprite_x
		sec
		sbc (sprite_addr), y
		sta oam, y
		jmp :+
add_offset:
		lda (sprite_addr), y
		clc
		adc sprite_x 
		sta oam, y
        :
		; increase y by for to start at the next row	
		iny
        ; increase x for oam
		cpy #$10 ; loop four times, once per row
	bne :--
	rts
.endproc