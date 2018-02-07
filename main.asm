.segment "HEADER"
	
.byte	"NES", $1A	; iNES header identifier
.byte	2		; 2x 16KB PRG code
.byte	1		; 1x  8KB CHR data
.byte	$01, $00	; mapper 0, vertical mirroring

.segment "ZEROPAGE"
.include "variables.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CHR ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "TILES"
.incbin "mario.chr"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Vectors
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "VECTORS"
.word nmi
.word reset
.word irq

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Reset
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"
reset:
  sei           ; mask interrupts
  lda #0
  sta $2000     ; disable nmi
  sta $2001     ; disable rendering
  sta $4015     ; disable APU sound
  sta $4010     ; disable DMC IRQ
  lda #$40
  sta $4017     ; disable APU IRQ
  cld           ; disable decimal mode
  ldx #$FF
  txs           ; initialize stack

  ; wait for first vblank
  bit $2002
  :
    bit $2002
    bpl :-

  ; clear out RAM
  lda #0
  ldx #0
  :
    sta $0000, x
    sta $0100, x
    sta $0200, x
    sta $0300, x
    sta $0400, x
    sta $0500, x
    sta $0600, x
    sta $0700, x
    inx
    bne :-

  ; place all sprites offscreen at y = 255
  lda #255
  ldx #0
  :
    sta oam, x
    inx
    inx
    inx
    inx
    bne :-

  ; wait for second vblank
  :
    bit $2002
    bpl :-

  ; now the nes is ready and we need to enable nmi
	lda #%10010000   ; enable NMI, sprites from Pattern Table 0, background from Pattern Table 1
  sta $2000
  lda #%00011110   ; enable sprites, enable background, no clipping on left side
  sta $2001
	; tell the PPU we aren't doing any scrolling at the end of NMI
	lda #$00
	sta $2005
	sta $2005

  ; initialize frame counter
  lda #$30
  sta frame_counter

	jsr load_palettes
	jsr load_sprites
	jsr load_background
	jsr init_player

  jmp main

.segment "BSS"
  nmt_update: .res 256 ; nametable buffer
  ; palette:    .res 32  ; palette buffer

.segment "OAM"
  oam: .res 256

.segment "CODE"
nmi:
  ; DMA Copy
  lda #$00
  sta $2003  ; set the low byte (00) of the RAM address
  lda #$02
  sta $4014  ; set the high byte (02) of the RAM address, start the transfer
  
  ; increase frame counter
  dec frame_counter
  bne reset_counter
  jmp :+
reset_counter:
	jsr player_timer_callback
  lda #$30
  sta frame_counter
  :

  jsr read_controller_1
  jsr update_player
  jsr draw_player 
  rti

.segment "CODE"
irq:
  rti

.segment "CODE"
main:
  jmp main

.include "metasprite.asm"
.include "macros.asm"
.include "subroutines.asm"
.include "data.asm"
.include "load-assets.asm"
.include "read-controllers.asm"
.include "update-player.asm"
