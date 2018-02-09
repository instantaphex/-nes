PLAYER_FACING_RIGHT = 0
PLAYER_FACING_LEFT = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Set initial player values		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
init_player:
	; set position
	lda #$80
	sta player_x
	sta player_y

	; set speed x and y
	lda #$01
	sta player_speed_x
	sta player_speed_y

	; set direction
	lda #PLAYER_FACING_RIGHT
	sta player_direction
	load_pointer player_curr_sprite, player_map
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Timer Callback
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
player_timer_callback:
	;load_pointer player_curr_sprite, player1
	rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Draw Player
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.proc draw_player
	; set up pointer to current animation frame
	;load_pointer sprite_addr, player_map
	;lda player_x
	;sta sprite_x
	;lda player_y
	;sta sprite_y
	;lda player_direction
	;sta sprite_direction
	;lda #$02
	;sta sprite_id
	;jsr draw_metasprite
	draw_2x2_metasprite player_map, player_x, player_y, player_direction, #$01
	rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Handle input for player
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
update_player:
	lda buttons1
	and #%10000000
	bne player_a_pressed 

	lda buttons1
	and #%01000000
	bne player_b_pressed 
	
	lda buttons1
	and #%00100000
	bne player_start_pressed 

	lda buttons1
	and #%00010000
	bne player_select_pressed 

	lda buttons1
	and #%00001000
	bne player_up_pressed 

	lda buttons1
	and #%00000100
	bne player_down_pressed 

	lda buttons1
	and #%00000010
	bne player_left_pressed 

	lda buttons1
	and #%00000001
	bne player_right_pressed 

	rts	

player_a_pressed:
	rts	

player_b_pressed:
	rts

player_start_pressed:
	rts

player_select_pressed:
	rts	

player_up_pressed:
	lda player_y
	sec
	sbc player_speed_y
	sta player_y
	rts	

player_down_pressed:
	lda player_y
	clc
	adc player_speed_y
	sta player_y
	rts	

player_left_pressed:
	lda #PLAYER_FACING_LEFT
	sta player_direction
	lda player_x
	sec
	sbc player_speed_x
	sta player_x
	rts	

player_right_pressed:
	lda #PLAYER_FACING_RIGHT
	sta player_direction
	lda player_x
	clc
	adc player_speed_x
	sta player_x
	rts	
