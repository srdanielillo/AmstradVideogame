;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module entity
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _cpct_memcpy
	.globl _cpct_memset
	.globl _m_num_entities
	.globl _m_next_free_entity
	.globl _m_zero_type_at_the_end
	.globl _m_entities
	.globl _man_entitiy_init
	.globl _man_entitiy_create
	.globl _man_entity_forall
	.globl _man_entity_destroy
	.globl _man_entity_set4destruction
	.globl _man_entity_update
	.globl _man_entity_freeSpace
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_m_entities::
	.ds 280
_m_zero_type_at_the_end::
	.ds 1
_m_next_free_entity::
	.ds 2
_m_num_entities::
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
;src/man/entity.c:8: void man_entitiy_init(){
;	---------------------------------
; Function man_entitiy_init
; ---------------------------------
_man_entitiy_init::
;src/man/entity.c:11: cpct_memset(m_entities, 0, sizeof(m_entities));
	ld	hl, #0x0118
	push	hl
	xor	a, a
	push	af
	inc	sp
	ld	hl, #_m_entities
	push	hl
	call	_cpct_memset
;src/man/entity.c:12: m_next_free_entity = m_entities;
	ld	hl, #_m_entities
	ld	(_m_next_free_entity), hl
;src/man/entity.c:13: m_num_entities = 0;
	ld	hl,#_m_num_entities + 0
	ld	(hl), #0x00
;src/man/entity.c:14: m_zero_type_at_the_end = e_type_invalid;
	ld	hl,#_m_zero_type_at_the_end + 0
	ld	(hl), #0x00
	ret
;src/man/entity.c:17: Entity_t* man_entitiy_create() {
;	---------------------------------
; Function man_entitiy_create
; ---------------------------------
_man_entitiy_create::
;src/man/entity.c:18: Entity_t* e = m_next_free_entity;
	ld	bc, (_m_next_free_entity)
;src/man/entity.c:19: m_next_free_entity = e +1;
	ld	hl, #0x0007
	add	hl,bc
	ld	(_m_next_free_entity), hl
;src/man/entity.c:20: e -> type = e_type_default;
	ld	a, #0x7f
	ld	(bc), a
;src/man/entity.c:21: ++m_num_entities;
	ld	hl, #_m_num_entities+0
	inc	(hl)
;src/man/entity.c:22: return e;
	ld	l, c
	ld	h, b
	ret
;src/man/entity.c:25: void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
;	---------------------------------
; Function man_entity_forall
; ---------------------------------
_man_entity_forall::
;src/man/entity.c:26: Entity_t* e = m_entities;
	ld	bc, #_m_entities+0
;src/man/entity.c:27: while(e -> type != e_type_invalid){
00101$:
	ld	a, (bc)
	or	a, a
	ret	Z
;src/man/entity.c:28: ptrfunc(e);
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
;src/man/entity.c:29: ++e;
	ld	hl, #0x0007
	add	hl,bc
	ld	c, l
	ld	b, h
	jr	00101$
;src/man/entity.c:33: void man_entity_destroy(Entity_t* dead_e){
;	---------------------------------
; Function man_entity_destroy
; ---------------------------------
_man_entity_destroy::
	push	ix
	ld	ix,#0
	add	ix,sp
;src/man/entity.c:34: Entity_t* de = dead_e;
	ld	e,4 (ix)
	ld	d,5 (ix)
;src/man/entity.c:35: Entity_t* last = m_next_free_entity;
	ld	hl, (_m_next_free_entity)
;src/man/entity.c:36: --last;
	ld	bc, #0xfff9
	add	hl,bc
	ld	c, l
	ld	b, h
;src/man/entity.c:37: if(de != last){
	ld	a, e
	sub	a, c
	jr	NZ,00109$
	ld	a, d
	sub	a, b
	jr	Z,00102$
00109$:
;src/man/entity.c:38: cpct_memcpy(de, last, sizeof(Entity_t));
	push	bc
	pop	iy
	push	bc
	ld	hl, #0x0007
	push	hl
	push	iy
	push	de
	call	_cpct_memcpy
	pop	bc
00102$:
;src/man/entity.c:40: last -> type = e_type_invalid;
	xor	a, a
	ld	(bc), a
;src/man/entity.c:41: m_next_free_entity = last;
	ld	(_m_next_free_entity), bc
;src/man/entity.c:42: --m_num_entities;
	ld	hl, #_m_num_entities+0
	dec	(hl)
	pop	ix
	ret
;src/man/entity.c:45: void man_entity_set4destruction(Entity_t* dead_e){
;	---------------------------------
; Function man_entity_set4destruction
; ---------------------------------
_man_entity_set4destruction::
;src/man/entity.c:46: dead_e -> type |=  e_type_dead;
	pop	de
	pop	bc
	push	bc
	push	de
	ld	a, (bc)
	set	7, a
	ld	(bc), a
	ret
;src/man/entity.c:49: void man_entity_update() {
;	---------------------------------
; Function man_entity_update
; ---------------------------------
_man_entity_update::
;src/man/entity.c:50: Entity_t* e = m_entities;
	ld	hl, #_m_entities+0
;src/man/entity.c:51: while(e -> type != e_type_invalid){
00104$:
	ld	a, (hl)
	or	a, a
	ret	Z
;src/man/entity.c:52: if(e -> type & e_type_dead ){
	rlca
	jr	NC,00102$
;src/man/entity.c:53: man_entity_destroy(e);
	push	hl
	push	hl
	call	_man_entity_destroy
	pop	af
	pop	hl
	jr	00104$
00102$:
;src/man/entity.c:56: ++e;
	ld	bc, #0x0007
	add	hl, bc
	jr	00104$
;src/man/entity.c:61: u8 man_entity_freeSpace(){
;	---------------------------------
; Function man_entity_freeSpace
; ---------------------------------
_man_entity_freeSpace::
;src/man/entity.c:62: return MAX_ENTITIES - m_num_entities;
	ld	hl, #_m_num_entities
	ld	a, #0x28
	sub	a, (hl)
	ld	l, a
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
