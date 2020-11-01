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
                             11 	.globl _cpct_memcpy
                             12 	.globl _cpct_memset
                             13 	.globl _m_num_entities
                             14 	.globl _m_next_free_entity
                             15 	.globl _m_zero_type_at_the_end
                             16 	.globl _m_entities
                             17 	.globl _man_entitiy_init
                             18 	.globl _man_entitiy_create
                             19 	.globl _man_entity_forall
                             20 	.globl _man_entity_destroy
                             21 	.globl _man_entity_set4destruction
                             22 	.globl _man_entity_update
                             23 	.globl _man_entity_freeSpace
                             24 ;--------------------------------------------------------
                             25 ; special function registers
                             26 ;--------------------------------------------------------
                             27 ;--------------------------------------------------------
                             28 ; ram data
                             29 ;--------------------------------------------------------
                             30 	.area _DATA
   42EB                      31 _m_entities::
   42EB                      32 	.ds 280
   4403                      33 _m_zero_type_at_the_end::
   4403                      34 	.ds 1
   4404                      35 _m_next_free_entity::
   4404                      36 	.ds 2
   4406                      37 _m_num_entities::
   4406                      38 	.ds 1
                             39 ;--------------------------------------------------------
                             40 ; ram data
                             41 ;--------------------------------------------------------
                             42 	.area _INITIALIZED
                             43 ;--------------------------------------------------------
                             44 ; absolute external ram data
                             45 ;--------------------------------------------------------
                             46 	.area _DABS (ABS)
                             47 ;--------------------------------------------------------
                             48 ; global & static initialisations
                             49 ;--------------------------------------------------------
                             50 	.area _HOME
                             51 	.area _GSINIT
                             52 	.area _GSFINAL
                             53 	.area _GSINIT
                             54 ;--------------------------------------------------------
                             55 ; Home
                             56 ;--------------------------------------------------------
                             57 	.area _HOME
                             58 	.area _HOME
                             59 ;--------------------------------------------------------
                             60 ; code
                             61 ;--------------------------------------------------------
                             62 	.area _CODE
                             63 ;src/man/entity.c:8: void man_entitiy_init(){
                             64 ;	---------------------------------
                             65 ; Function man_entitiy_init
                             66 ; ---------------------------------
   4123                      67 _man_entitiy_init::
                             68 ;src/man/entity.c:11: cpct_memset(m_entities, 0, sizeof(m_entities));
   4123 21 18 01      [10]   69 	ld	hl, #0x0118
   4126 E5            [11]   70 	push	hl
   4127 AF            [ 4]   71 	xor	a, a
   4128 F5            [11]   72 	push	af
   4129 33            [ 6]   73 	inc	sp
   412A 21 EB 42      [10]   74 	ld	hl, #_m_entities
   412D E5            [11]   75 	push	hl
   412E CD 58 42      [17]   76 	call	_cpct_memset
                             77 ;src/man/entity.c:12: m_next_free_entity = m_entities;
   4131 21 EB 42      [10]   78 	ld	hl, #_m_entities
   4134 22 04 44      [16]   79 	ld	(_m_next_free_entity), hl
                             80 ;src/man/entity.c:13: m_num_entities = 0;
   4137 21 06 44      [10]   81 	ld	hl,#_m_num_entities + 0
   413A 36 00         [10]   82 	ld	(hl), #0x00
                             83 ;src/man/entity.c:14: m_zero_type_at_the_end = e_type_invalid;
   413C 21 03 44      [10]   84 	ld	hl,#_m_zero_type_at_the_end + 0
   413F 36 00         [10]   85 	ld	(hl), #0x00
   4141 C9            [10]   86 	ret
                             87 ;src/man/entity.c:17: Entity_t* man_entitiy_create() {
                             88 ;	---------------------------------
                             89 ; Function man_entitiy_create
                             90 ; ---------------------------------
   4142                      91 _man_entitiy_create::
                             92 ;src/man/entity.c:18: Entity_t* e = m_next_free_entity;
   4142 ED 4B 04 44   [20]   93 	ld	bc, (_m_next_free_entity)
                             94 ;src/man/entity.c:19: m_next_free_entity = e +1;
   4146 21 07 00      [10]   95 	ld	hl, #0x0007
   4149 09            [11]   96 	add	hl,bc
   414A 22 04 44      [16]   97 	ld	(_m_next_free_entity), hl
                             98 ;src/man/entity.c:20: e -> type = e_type_default;
   414D 3E 7F         [ 7]   99 	ld	a, #0x7f
   414F 02            [ 7]  100 	ld	(bc), a
                            101 ;src/man/entity.c:21: ++m_num_entities;
   4150 21 06 44      [10]  102 	ld	hl, #_m_num_entities+0
   4153 34            [11]  103 	inc	(hl)
                            104 ;src/man/entity.c:22: return e;
   4154 69            [ 4]  105 	ld	l, c
   4155 60            [ 4]  106 	ld	h, b
   4156 C9            [10]  107 	ret
                            108 ;src/man/entity.c:25: void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
                            109 ;	---------------------------------
                            110 ; Function man_entity_forall
                            111 ; ---------------------------------
   4157                     112 _man_entity_forall::
                            113 ;src/man/entity.c:26: Entity_t* e = m_entities;
   4157 01 EB 42      [10]  114 	ld	bc, #_m_entities+0
                            115 ;src/man/entity.c:27: while(e -> type != e_type_invalid){
   415A                     116 00101$:
   415A 0A            [ 7]  117 	ld	a, (bc)
   415B B7            [ 4]  118 	or	a, a
   415C C8            [11]  119 	ret	Z
                            120 ;src/man/entity.c:28: ptrfunc(e);
   415D C5            [11]  121 	push	bc
   415E C5            [11]  122 	push	bc
   415F 21 06 00      [10]  123 	ld	hl, #6
   4162 39            [11]  124 	add	hl, sp
   4163 7E            [ 7]  125 	ld	a, (hl)
   4164 23            [ 6]  126 	inc	hl
   4165 66            [ 7]  127 	ld	h, (hl)
   4166 6F            [ 4]  128 	ld	l, a
   4167 CD 41 42      [17]  129 	call	___sdcc_call_hl
   416A F1            [10]  130 	pop	af
   416B C1            [10]  131 	pop	bc
                            132 ;src/man/entity.c:29: ++e;
   416C 21 07 00      [10]  133 	ld	hl, #0x0007
   416F 09            [11]  134 	add	hl,bc
   4170 4D            [ 4]  135 	ld	c, l
   4171 44            [ 4]  136 	ld	b, h
   4172 18 E6         [12]  137 	jr	00101$
                            138 ;src/man/entity.c:33: void man_entity_destroy(Entity_t* dead_e){
                            139 ;	---------------------------------
                            140 ; Function man_entity_destroy
                            141 ; ---------------------------------
   4174                     142 _man_entity_destroy::
   4174 DD E5         [15]  143 	push	ix
   4176 DD 21 00 00   [14]  144 	ld	ix,#0
   417A DD 39         [15]  145 	add	ix,sp
                            146 ;src/man/entity.c:34: Entity_t* de = dead_e;
   417C DD 5E 04      [19]  147 	ld	e,4 (ix)
   417F DD 56 05      [19]  148 	ld	d,5 (ix)
                            149 ;src/man/entity.c:35: Entity_t* last = m_next_free_entity;
   4182 2A 04 44      [16]  150 	ld	hl, (_m_next_free_entity)
                            151 ;src/man/entity.c:36: --last;
   4185 01 F9 FF      [10]  152 	ld	bc, #0xfff9
   4188 09            [11]  153 	add	hl,bc
   4189 4D            [ 4]  154 	ld	c, l
   418A 44            [ 4]  155 	ld	b, h
                            156 ;src/man/entity.c:37: if(de != last){
   418B 7B            [ 4]  157 	ld	a, e
   418C 91            [ 4]  158 	sub	a, c
   418D 20 04         [12]  159 	jr	NZ,00109$
   418F 7A            [ 4]  160 	ld	a, d
   4190 90            [ 4]  161 	sub	a, b
   4191 28 0F         [12]  162 	jr	Z,00102$
   4193                     163 00109$:
                            164 ;src/man/entity.c:38: cpct_memcpy(de, last, sizeof(Entity_t));
   4193 C5            [11]  165 	push	bc
   4194 FD E1         [14]  166 	pop	iy
   4196 C5            [11]  167 	push	bc
   4197 21 07 00      [10]  168 	ld	hl, #0x0007
   419A E5            [11]  169 	push	hl
   419B FD E5         [15]  170 	push	iy
   419D D5            [11]  171 	push	de
   419E CD 66 42      [17]  172 	call	_cpct_memcpy
   41A1 C1            [10]  173 	pop	bc
   41A2                     174 00102$:
                            175 ;src/man/entity.c:40: last -> type = e_type_invalid;
   41A2 AF            [ 4]  176 	xor	a, a
   41A3 02            [ 7]  177 	ld	(bc), a
                            178 ;src/man/entity.c:41: m_next_free_entity = last;
   41A4 ED 43 04 44   [20]  179 	ld	(_m_next_free_entity), bc
                            180 ;src/man/entity.c:42: --m_num_entities;
   41A8 21 06 44      [10]  181 	ld	hl, #_m_num_entities+0
   41AB 35            [11]  182 	dec	(hl)
   41AC DD E1         [14]  183 	pop	ix
   41AE C9            [10]  184 	ret
                            185 ;src/man/entity.c:45: void man_entity_set4destruction(Entity_t* dead_e){
                            186 ;	---------------------------------
                            187 ; Function man_entity_set4destruction
                            188 ; ---------------------------------
   41AF                     189 _man_entity_set4destruction::
                            190 ;src/man/entity.c:46: dead_e -> type |=  e_type_dead;
   41AF D1            [10]  191 	pop	de
   41B0 C1            [10]  192 	pop	bc
   41B1 C5            [11]  193 	push	bc
   41B2 D5            [11]  194 	push	de
   41B3 0A            [ 7]  195 	ld	a, (bc)
   41B4 CB FF         [ 8]  196 	set	7, a
   41B6 02            [ 7]  197 	ld	(bc), a
   41B7 C9            [10]  198 	ret
                            199 ;src/man/entity.c:49: void man_entity_update() {
                            200 ;	---------------------------------
                            201 ; Function man_entity_update
                            202 ; ---------------------------------
   41B8                     203 _man_entity_update::
                            204 ;src/man/entity.c:50: Entity_t* e = m_entities;
   41B8 21 EB 42      [10]  205 	ld	hl, #_m_entities+0
                            206 ;src/man/entity.c:51: while(e -> type != e_type_invalid){
   41BB                     207 00104$:
   41BB 7E            [ 7]  208 	ld	a, (hl)
   41BC B7            [ 4]  209 	or	a, a
   41BD C8            [11]  210 	ret	Z
                            211 ;src/man/entity.c:52: if(e -> type & e_type_dead ){
   41BE 07            [ 4]  212 	rlca
   41BF 30 09         [12]  213 	jr	NC,00102$
                            214 ;src/man/entity.c:53: man_entity_destroy(e);
   41C1 E5            [11]  215 	push	hl
   41C2 E5            [11]  216 	push	hl
   41C3 CD 74 41      [17]  217 	call	_man_entity_destroy
   41C6 F1            [10]  218 	pop	af
   41C7 E1            [10]  219 	pop	hl
   41C8 18 F1         [12]  220 	jr	00104$
   41CA                     221 00102$:
                            222 ;src/man/entity.c:56: ++e;
   41CA 01 07 00      [10]  223 	ld	bc, #0x0007
   41CD 09            [11]  224 	add	hl, bc
   41CE 18 EB         [12]  225 	jr	00104$
                            226 ;src/man/entity.c:61: u8 man_entity_freeSpace(){
                            227 ;	---------------------------------
                            228 ; Function man_entity_freeSpace
                            229 ; ---------------------------------
   41D0                     230 _man_entity_freeSpace::
                            231 ;src/man/entity.c:62: return MAX_ENTITIES - m_num_entities;
   41D0 21 06 44      [10]  232 	ld	hl, #_m_num_entities
   41D3 3E 28         [ 7]  233 	ld	a, #0x28
   41D5 96            [ 7]  234 	sub	a, (hl)
   41D6 6F            [ 4]  235 	ld	l, a
   41D7 C9            [10]  236 	ret
                            237 	.area _CODE
                            238 	.area _INITIALIZER
                            239 	.area _CABS (ABS)
