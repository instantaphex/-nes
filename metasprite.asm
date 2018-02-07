LEFT = 1
RIGHT = 0

.proc draw_metasprite
	ldy #$00
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
		lda #%00000000 ; (player_curr_sprite), y
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
		lda sprite_x ; (player_curr_sprite), y
		sec
		sbc (sprite_addr), y
		sta oam, y
		jmp end_byte_3
add_offset:
		lda (sprite_addr), y
		clc
		adc sprite_x 
		sta oam, y
end_byte_3:

		; increase y by for to start at the next row	
		iny

		cpy #$10 ; loop four times, once per row
	bne :-
	rts
.endproc