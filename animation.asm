.macro play_animation animation, counter, sprite_ptr
    ; load sprite frame counter
	lda counter
    ; advance frame (initially $ff and rolls over to 0)
    clc
    adc #1
    ; if (current_frame == num frames) { reset() }
    cmp player_walk_num_frames
    bcc skip_reset
    lda #0
skip_reset:
    ; store frame + 1
    sta counter
    ; multiply a by 2 in order to get correct byte offset
    asl a
    ; transfer a to x for Absolute,X addressing mode
    tax
	; set current sprite to current animation frame
	lda animation, x
	sta sprite_ptr + 0
	inx 
	lda animation, x
	sta sprite_ptr + 1
.endmacro