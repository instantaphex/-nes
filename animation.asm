.macro play_animation animation, counter, sprite_ptr
    ; load sprite frame counter
	ldx counter
    ; increase x to put offset at the begginning of frame data
    inx
	; set current sprite to current animation frame
	lda animation, x
	sta sprite_ptr + 0
	inx 
	lda animation, x
	sta sprite_ptr + 1

    ; get number of frames and store it in temp1
    lda animation
    sta temp1

    ; check if frame counter is equal to number of frames
	ldx counter
	cpx temp1
	beq reset_counter
	; advance frame counter if counter < number of frames
	inx
	inx
	stx counter
	jmp callback_done
reset_counter:
	lda #$00
	sta counter
callback_done:
.endmacro