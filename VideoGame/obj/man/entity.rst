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
   416A                      26 _m_entities::
   416A                      27 	.ds 50
   419C                      28 _m_next_free_entity::
   419C                      29 	.ds 2
   419E                      30 _m_reserved_entities::
   419E                      31 	.ds 1
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
   40BF                      60 _man_entitiy_init::
                             61 ;src/man/entity.c:10: cpct_memset(m_entities, 0, sizeof(m_entities));
   40BF 21 32 00      [10]   62 	ld	hl, #0x0032
   40C2 E5            [11]   63 	push	hl
   40C3 AF            [ 4]   64 	xor	a, a
   40C4 F5            [11]   65 	push	af
   40C5 33            [ 6]   66 	inc	sp
   40C6 21 6A 41      [10]   67 	ld	hl, #_m_entities
   40C9 E5            [11]   68 	push	hl
   40CA CD 23 41      [17]   69 	call	_cpct_memset
                             70 ;src/man/entity.c:11: m_next_free_entity = m_entities;
   40CD 21 6A 41      [10]   71 	ld	hl, #_m_entities
   40D0 22 9C 41      [16]   72 	ld	(_m_next_free_entity), hl
   40D3 C9            [10]   73 	ret
                             74 ;src/man/entity.c:14: Entity_t* man_entitiy_create() {
                             75 ;	---------------------------------
                             76 ; Function man_entitiy_create
                             77 ; ---------------------------------
   40D4                      78 _man_entitiy_create::
                             79 ;src/man/entity.c:15: Entity_t* e = m_next_free_entity;
   40D4 ED 4B 9C 41   [20]   80 	ld	bc, (_m_next_free_entity)
                             81 ;src/man/entity.c:16: m_next_free_entity = e +1;
   40D8 21 05 00      [10]   82 	ld	hl, #0x0005
   40DB 09            [11]   83 	add	hl,bc
   40DC 22 9C 41      [16]   84 	ld	(_m_next_free_entity), hl
                             85 ;src/man/entity.c:17: e -> type = e_type_default;
   40DF 3E 7F         [ 7]   86 	ld	a, #0x7f
   40E1 02            [ 7]   87 	ld	(bc), a
                             88 ;src/man/entity.c:18: return e;
   40E2 69            [ 4]   89 	ld	l, c
   40E3 60            [ 4]   90 	ld	h, b
   40E4 C9            [10]   91 	ret
                             92 ;src/man/entity.c:21: void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
                             93 ;	---------------------------------
                             94 ; Function man_entity_forall
                             95 ; ---------------------------------
   40E5                      96 _man_entity_forall::
                             97 ;src/man/entity.c:22: Entity_t* e = m_entities;
   40E5 01 6A 41      [10]   98 	ld	bc, #_m_entities+0
                             99 ;src/man/entity.c:23: while(e -> type != e_type_invalid){
   40E8                     100 00101$:
   40E8 0A            [ 7]  101 	ld	a, (bc)
   40E9 B7            [ 4]  102 	or	a, a
   40EA C8            [11]  103 	ret	Z
                            104 ;src/man/entity.c:24: ptrfunc(e);
   40EB C5            [11]  105 	push	bc
   40EC C5            [11]  106 	push	bc
   40ED 21 06 00      [10]  107 	ld	hl, #6
   40F0 39            [11]  108 	add	hl, sp
   40F1 7E            [ 7]  109 	ld	a, (hl)
   40F2 23            [ 6]  110 	inc	hl
   40F3 66            [ 7]  111 	ld	h, (hl)
   40F4 6F            [ 4]  112 	ld	l, a
   40F5 CD 14 41      [17]  113 	call	___sdcc_call_hl
   40F8 F1            [10]  114 	pop	af
   40F9 C1            [10]  115 	pop	bc
                            116 ;src/man/entity.c:25: ++e;
   40FA 03            [ 6]  117 	inc	bc
   40FB 03            [ 6]  118 	inc	bc
   40FC 03            [ 6]  119 	inc	bc
   40FD 03            [ 6]  120 	inc	bc
   40FE 03            [ 6]  121 	inc	bc
   40FF 18 E7         [12]  122 	jr	00101$
                            123 ;src/man/entity.c:29: void man_entity_destroy(Entity_t* dead_e){
                            124 ;	---------------------------------
                            125 ; Function man_entity_destroy
                            126 ; ---------------------------------
   4101                     127 _man_entity_destroy::
                            128 ;src/man/entity.c:30: dead_e -> type = e_type_invalid;
   4101 D1            [10]  129 	pop	de
   4102 C1            [10]  130 	pop	bc
   4103 C5            [11]  131 	push	bc
   4104 D5            [11]  132 	push	de
   4105 AF            [ 4]  133 	xor	a, a
   4106 02            [ 7]  134 	ld	(bc), a
   4107 C9            [10]  135 	ret
                            136 	.area _CODE
                            137 	.area _INITIALIZER
                            138 	.area _CABS (ABS)
