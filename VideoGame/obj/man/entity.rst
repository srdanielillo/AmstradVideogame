                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module entity
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _cpct_memset
                             12 	.globl _m_reserved_entities
                             13 	.globl _m_next_free_entity
                             14 	.globl _m_entities
                             15 	.globl _man_entitiy_init
                             16 	.globl _man_entitiy_create
                             17 	.globl _man_entity_forall
                             18 	.globl _man_entity_destroy
                             19 ;--------------------------------------------------------
                             20 ; special function registers
                             21 ;--------------------------------------------------------
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _DATA
   4165                      26 _m_entities::
   4165                      27 	.ds 25
   417E                      28 _m_next_free_entity::
   417E                      29 	.ds 2
   4180                      30 _m_reserved_entities::
   4180                      31 	.ds 1
                             32 ;--------------------------------------------------------
                             33 ; ram data
                             34 ;--------------------------------------------------------
                             35 	.area _INITIALIZED
                             36 ;--------------------------------------------------------
                             37 ; absolute external ram data
                             38 ;--------------------------------------------------------
                             39 	.area _DABS (ABS)
                             40 ;--------------------------------------------------------
                             41 ; global & static initialisations
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _GSINIT
                             45 	.area _GSFINAL
                             46 	.area _GSINIT
                             47 ;--------------------------------------------------------
                             48 ; Home
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _HOME
                             52 ;--------------------------------------------------------
                             53 ; code
                             54 ;--------------------------------------------------------
                             55 	.area _CODE
                             56 ;src/man/entity.c:7: void man_entitiy_init(){
                             57 ;	---------------------------------
                             58 ; Function man_entitiy_init
                             59 ; ---------------------------------
   40C0                      60 _man_entitiy_init::
                             61 ;src/man/entity.c:8: cpct_memset(m_entities, 0, sizeof(m_entities));
   40C0 21 19 00      [10]   62 	ld	hl, #0x0019
   40C3 E5            [11]   63 	push	hl
   40C4 AF            [ 4]   64 	xor	a, a
   40C5 F5            [11]   65 	push	af
   40C6 33            [ 6]   66 	inc	sp
   40C7 21 65 41      [10]   67 	ld	hl, #_m_entities
   40CA E5            [11]   68 	push	hl
   40CB CD 1E 41      [17]   69 	call	_cpct_memset
                             70 ;src/man/entity.c:9: m_next_free_entity = &m_entities[0];
   40CE 21 65 41      [10]   71 	ld	hl, #_m_entities
   40D1 22 7E 41      [16]   72 	ld	(_m_next_free_entity), hl
   40D4 C9            [10]   73 	ret
                             74 ;src/man/entity.c:12: Entity_t* man_entitiy_create() {
                             75 ;	---------------------------------
                             76 ; Function man_entitiy_create
                             77 ; ---------------------------------
   40D5                      78 _man_entitiy_create::
                             79 ;src/man/entity.c:13: Entity_t* e = m_next_free_entity;
   40D5 ED 4B 7E 41   [20]   80 	ld	bc, (_m_next_free_entity)
                             81 ;src/man/entity.c:14: m_next_free_entity = e +1;
   40D9 21 05 00      [10]   82 	ld	hl, #0x0005
   40DC 09            [11]   83 	add	hl,bc
   40DD 22 7E 41      [16]   84 	ld	(_m_next_free_entity), hl
                             85 ;src/man/entity.c:15: e -> type = e_type_default;
   40E0 3E 7F         [ 7]   86 	ld	a, #0x7f
   40E2 02            [ 7]   87 	ld	(bc), a
                             88 ;src/man/entity.c:16: return e;
   40E3 69            [ 4]   89 	ld	l, c
   40E4 60            [ 4]   90 	ld	h, b
   40E5 C9            [10]   91 	ret
                             92 ;src/man/entity.c:19: void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
                             93 ;	---------------------------------
                             94 ; Function man_entity_forall
                             95 ; ---------------------------------
   40E6                      96 _man_entity_forall::
                             97 ;src/man/entity.c:20: Entity_t* e = m_entities;
   40E6 01 65 41      [10]   98 	ld	bc, #_m_entities+0
                             99 ;src/man/entity.c:21: while(e -> type != e_type_invalid){
   40E9                     100 00101$:
   40E9 0A            [ 7]  101 	ld	a, (bc)
   40EA B7            [ 4]  102 	or	a, a
   40EB C8            [11]  103 	ret	Z
                            104 ;src/man/entity.c:22: ptrfunc(e);
   40EC C5            [11]  105 	push	bc
   40ED C5            [11]  106 	push	bc
   40EE 21 06 00      [10]  107 	ld	hl, #6
   40F1 39            [11]  108 	add	hl, sp
   40F2 7E            [ 7]  109 	ld	a, (hl)
   40F3 23            [ 6]  110 	inc	hl
   40F4 66            [ 7]  111 	ld	h, (hl)
   40F5 6F            [ 4]  112 	ld	l, a
   40F6 CD 0F 41      [17]  113 	call	___sdcc_call_hl
   40F9 F1            [10]  114 	pop	af
   40FA C1            [10]  115 	pop	bc
                            116 ;src/man/entity.c:23: ++e;
   40FB 03            [ 6]  117 	inc	bc
   40FC 03            [ 6]  118 	inc	bc
   40FD 03            [ 6]  119 	inc	bc
   40FE 03            [ 6]  120 	inc	bc
   40FF 03            [ 6]  121 	inc	bc
   4100 18 E7         [12]  122 	jr	00101$
                            123 ;src/man/entity.c:27: void man_entity_destroy(Entity_t* dead_e){
                            124 ;	---------------------------------
                            125 ; Function man_entity_destroy
                            126 ; ---------------------------------
   4102                     127 _man_entity_destroy::
                            128 ;src/man/entity.c:29: }
   4102 C9            [10]  129 	ret
                            130 	.area _CODE
                            131 	.area _INITIALIZER
                            132 	.area _CABS (ABS)
