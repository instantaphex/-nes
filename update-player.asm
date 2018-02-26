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
	load_pointer player_curr_sprite, player_walking_1
	lda #$00
	sta player_animation_counter
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Timer Callback
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.proc player_timer_callback
	play_animation player_walk_animation, player_animation_counter, player_curr_sprite
	rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	Draw Player
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.proc draw_player
	draw_2x2_metasprite player_curr_sprite, player_x, player_y, player_direction, #$01
	rts
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Handle input for player
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.proc update_player
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
.endproc

.proc player_a_pressed
	rts	
.endproc

.proc player_b_pressed
	rts
.endproc

.proc player_start_pressed
	rts
.endproc

.proc player_select_pressed
	rts	
.endproc

.proc player_up_pressed
	lda player_y
	sec
	sbc player_speed_y
	sta player_y
	rts	
.endproc

.proc player_down_pressed
	lda player_y
	clc
	adc player_speed_y
	sta player_y
	rts	
.endproc

.proc player_left_pressed
	lda #PLAYER_FACING_LEFT
	sta player_direction
	lda player_x
	sec
	sbc player_speed_x
	sta player_x
	rts	
.endproc

.proc player_right_pressed
	lda #PLAYER_FACING_RIGHT
	sta player_direction
	lda player_x
	clc
	adc player_speed_x
	sta player_x
	rts	
.endproc