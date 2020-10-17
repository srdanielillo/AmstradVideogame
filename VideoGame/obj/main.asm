;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _createEntity
	.globl _sys_render_update
	.globl _sys_phyisics_update
	.globl _man_entitiy_create
	.globl _man_entitiy_init
	.globl _cpct_setPALColour
	.globl _cpct_setVideoMode
	.globl _cpct_memcpy
	.globl _cpct_disableFirmware
	.globl _init_e
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:31: void createEntity(){
;	---------------------------------
; Function createEntity
; ---------------------------------
_createEntity::
;src/main.c:32: Entity_t* e = man_entitiy_create();
	call	_man_entitiy_create
;src/main.c:33: cpct_memcpy (e, &init_e, sizeof(Entity_t));
	ld	bc, #_init_e+0
	ld	de, #0x0005
	push	de
	push	bc
	push	hl
	call	_cpct_memcpy
	ret
_init_e:
	.db #0x01	; 1
	.db #0x4f	; 79	'O'
	.db #0x01	; 1
	.db #0xff	; -1
	.db #0xff	; 255
;src/main.c:36: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:37: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:38: cpct_setVideoMode(0);
	ld	l, #0x00
	call	_cpct_setVideoMode
;src/main.c:39: cpct_setBorder(HW_BLACK);
	ld	hl, #0x1410
	push	hl
	call	_cpct_setPALColour
;src/main.c:40: cpct_setPALColour(0, HW_BLACK);
	ld	hl, #0x1400
	push	hl
	call	_cpct_setPALColour
;src/main.c:42: man_entitiy_init();
	call	_man_entitiy_init
;src/main.c:43: for(u8 i = 0; i < 5; ++i){
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0x05
	jr	NC,00101$
;src/main.c:44: createEntity();
	push	bc
	call	_createEntity
	pop	bc
;src/main.c:43: for(u8 i = 0; i < 5; ++i){
	inc	c
	jr	00106$
00101$:
;src/main.c:46: sys_phyisics_update();
	call	_sys_phyisics_update
;src/main.c:47: sys_render_update();
	call	_sys_render_update
;src/main.c:49: while(1);
00103$:
	jr	00103$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
