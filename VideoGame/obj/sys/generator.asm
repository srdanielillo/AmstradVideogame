;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module generator
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _generateNewStar
	.globl _man_entity_freeSpace
	.globl _man_entitiy_create
	.globl _cpct_getRandom_mxor_u8
	.globl _cpct_memcpy
	.globl _init_e
	.globl _sys_generator_update
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
;src/sys/generator.c:12: void generateNewStar(){
;	---------------------------------
; Function generateNewStar
; ---------------------------------
_generateNewStar::
;src/sys/generator.c:13: Entity_t* e = man_entitiy_create();
	call	_man_entitiy_create
	ld	c, l
	ld	b, h
;src/sys/generator.c:14: cpct_memcpy (e, &init_e, sizeof(Entity_t));
	ld	e, c
	ld	d, b
	push	bc
	ld	hl, #0x0007
	push	hl
	ld	hl, #_init_e
	push	hl
	push	de
	call	_cpct_memcpy
	pop	bc
;src/sys/generator.c:16: e -> y   = cpct_rand() % 200;
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	push	bc
	push	de
	call	_cpct_getRandom_mxor_u8
	ld	h, l
	ld	a, #0xc8
	push	af
	inc	sp
	push	hl
	inc	sp
	call	__moduchar
	pop	af
	ld	a, l
	pop	de
	pop	bc
	ld	(de), a
;src/sys/generator.c:18: e -> vx  = -1-(cpct_rand() & 0x03);
	inc	bc
	inc	bc
	inc	bc
	push	bc
	call	_cpct_getRandom_mxor_u8
	pop	bc
	ld	a, l
	and	a, #0x03
	ld	e, a
	ld	a, #0xff
	sub	a, e
	ld	(bc), a
	ret
_init_e:
	.db #0x01	; 1
	.db #0x4f	; 79	'O'
	.db #0x01	; 1
	.db #0xff	; -1
	.db #0xff	; 255
	.dw #0x0000
;src/sys/generator.c:21: void sys_generator_update(){
;	---------------------------------
; Function sys_generator_update
; ---------------------------------
_sys_generator_update::
;src/sys/generator.c:22: u8 free = man_entity_freeSpace();
	call	_man_entity_freeSpace
;src/sys/generator.c:23: if(free){
	ld	a, l
	or	a, a
	ret	Z
;src/sys/generator.c:24: generateNewStar();
	jp  _generateNewStar
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
