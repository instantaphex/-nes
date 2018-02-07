tmp1: .res 1
tmp2: .res 1
tmp3: .res 1

;sprite struct
sprite_addr: .res 2 ; general purpose metasprite pointer
sprite_direction: .res 1 ; flag to determine if sprite_addr should be flipped
sprite_x: .res 1
sprite_y: .res 1
sprite_id: .res 1

frame_counter: .res 1 ; frame counter
buttons1: .res 1 ; conroller variable for player 1
buttons2: .res 1 ; conroller variable for player 1

bg_ptr_low: .res 1 ; bg pointer low byte
bg_ptr_hi: .res 1 ; bg pointer high byte

player_x: .res 1
player_y: .res 1

player_speed_x: .res 1
player_speed_y: .res 1

player_curr_sprite: .res 2 ; pointer to players current sprite

player_direction: .res 1 ; facing left or right (0 - right, 1 - left)

;.struct player 
;		x .byte
;    y .byte
;    speed_x .byte
;    speed_y .byte
;    frame .word
;    direction .byte
;.endstruct

;the_player: .tag player
