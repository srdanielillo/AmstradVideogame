;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module physics
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sys_physics_update_one_entity
	.globl _man_entity_forall
	.globl _man_entity_destroy
	.globl _sys_phyisics_update
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
;src/sys/physics.c:4: void sys_physics_update_one_entity(Entity_t *e){
;	---------------------------------
; Function sys_physics_update_one_entity
; ---------------------------------
_sys_physics_update_one_entity::
	push	ix
	ld	ix,#0
	add	ix,sp
	push	af
;src/sys/physics.c:5: u8 newx = e->x + e->vx;
	ld	c,4 (ix)
	ld	b,5 (ix)
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	ld	-1 (ix), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	a, -1 (ix)
	add	a, l
	ld	-2 (ix), a
;src/sys/physics.c:7: if(newx > e -> x){
	ld	a, -1 (ix)
	sub	a, -2 (ix)
	jr	NC,00102$
;src/sys/physics.c:8: man_entity_destroy(e);
	push	bc
	call	_man_entity_destroy
	pop	af
	jr	00104$
00102$:
;src/sys/physics.c:11: e->x = newx;
	ld	a, -2 (ix)
	ld	(de), a
00104$:
	ld	sp, ix
	pop	ix
	ret
;src/sys/physics.c:15: void sys_phyisics_update(){
;	---------------------------------
; Function sys_phyisics_update
; ---------------------------------
_sys_phyisics_update::
;src/sys/physics.c:16: man_entity_forall( sys_physics_update_one_entity );
	ld	hl, #_sys_physics_update_one_entity
	push	hl
	call	_man_entity_forall
	pop	af
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
