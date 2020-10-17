;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module entity
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_memset
	.globl _m_reserved_entities
	.globl _m_next_free_entity
	.globl _m_entities
	.globl _man_entitiy_init
	.globl _man_entitiy_create
	.globl _man_entity_forall
	.globl _man_entity_destroy
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_m_entities::
	.ds 25
_m_next_free_entity::
	.ds 2
_m_reserved_entities::
	.ds 1
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
;src/man/entity.c:7: void man_entitiy_init(){
;	---------------------------------
; Function man_entitiy_init
; ---------------------------------
_man_entitiy_init::
;src/man/entity.c:8: cpct_memset(m_entities, 0, sizeof(m_entities));
	ld	hl, #0x0019
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_m_entities
	push	hl
	call	_cpct_memset
;src/man/entity.c:9: m_next_free_entity = &m_entities[0];
	ld	hl, #_m_entities
	ld	(_m_next_free_entity), hl
	ret
;src/man/entity.c:12: Entity_t* man_entitiy_create() {
;	---------------------------------
; Function man_entitiy_create
; ---------------------------------
_man_entitiy_create::
;src/man/entity.c:13: Entity_t* e = m_next_free_entity;
	ld	bc, (_m_next_free_entity)
;src/man/entity.c:14: m_next_free_entity = e +1;
	ld	hl, #0x0005
	add	hl,bc
	ld	(_m_next_free_entity), hl
;src/man/entity.c:15: e -> type = e_type_default;
	ld	a, #0x7f
	ld	(bc), a
;src/man/entity.c:16: return e;
	ld	l, c
	ld	h, b
	ret
;src/man/entity.c:19: void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
;	---------------------------------
; Function man_entity_forall
; ---------------------------------
_man_entity_forall::
;src/man/entity.c:20: Entity_t* e = m_entities;
	ld	bc, #_m_entities+0
;src/man/entity.c:21: while(e -> type != e_type_invalid){
00101$:
	ld	a, (bc)
	or	a, a
	ret	Z
;src/man/entity.c:22: ptrfunc(e);
	push	bc
	push	bc
	ld	hl, #6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	call	___sdcc_call_hl
	pop	af
	pop	bc
;src/man/entity.c:23: ++e;
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	jr	00101$
;src/man/entity.c:27: void man_entity_destroy(Entity_t* dead_e){
;	---------------------------------
; Function man_entity_destroy
; ---------------------------------
_man_entity_destroy::
;src/man/entity.c:29: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
