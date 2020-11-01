                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module render
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _man_entity_forall
                             12 	.globl _cpct_getScreenPtr
                             13 	.globl _cpct_setPALColour
                             14 	.globl _cpct_setVideoMode
                             15 	.globl _sys_render_init
                             16 	.globl _sys_render_one_entity
                             17 	.globl _sys_render_update
                             18 ;--------------------------------------------------------
                             19 ; special function registers
                             20 ;--------------------------------------------------------
                             21 ;--------------------------------------------------------
                             22 ; ram data
                             23 ;--------------------------------------------------------
                             24 	.area _DATA
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _INITIALIZED
                             29 ;--------------------------------------------------------
                             30 ; absolute external ram data
                             31 ;--------------------------------------------------------
                             32 	.area _DABS (ABS)
                             33 ;--------------------------------------------------------
                             34 ; global & static initialisations
                             35 ;--------------------------------------------------------
                             36 	.area _HOME
                             37 	.area _GSINIT
                             38 	.area _GSFINAL
                             39 	.area _GSINIT
                             40 ;--------------------------------------------------------
                             41 ; Home
                             42 ;--------------------------------------------------------
                             43 	.area _HOME
                             44 	.area _HOME
                             45 ;--------------------------------------------------------
                             46 ; code
                             47 ;--------------------------------------------------------
                             48 	.area _CODE
                             49 ;src/sys/render.c:4: void sys_render_init(){
                             50 ;	---------------------------------
                             51 ; Function sys_render_init
                             52 ; ---------------------------------
   40BF                      53 _sys_render_init::
                             54 ;src/sys/render.c:5: cpct_setVideoMode(0);
   40BF 2E 00         [ 7]   55 	ld	l, #0x00
   40C1 CD 42 42      [17]   56 	call	_cpct_setVideoMode
                             57 ;src/sys/render.c:6: cpct_setBorder(HW_BLACK);
   40C4 21 10 14      [10]   58 	ld	hl, #0x1410
   40C7 E5            [11]   59 	push	hl
   40C8 CD D8 41      [17]   60 	call	_cpct_setPALColour
                             61 ;src/sys/render.c:7: cpct_setPALColour(0, HW_BLACK);
   40CB 21 00 14      [10]   62 	ld	hl, #0x1400
   40CE E5            [11]   63 	push	hl
   40CF CD D8 41      [17]   64 	call	_cpct_setPALColour
   40D2 C9            [10]   65 	ret
                             66 ;src/sys/render.c:10: void sys_render_one_entity(Entity_t* e) {
                             67 ;	---------------------------------
                             68 ; Function sys_render_one_entity
                             69 ; ---------------------------------
   40D3                      70 _sys_render_one_entity::
   40D3 DD E5         [15]   71 	push	ix
   40D5 DD 21 00 00   [14]   72 	ld	ix,#0
   40D9 DD 39         [15]   73 	add	ix,sp
   40DB F5            [11]   74 	push	af
                             75 ;src/sys/render.c:11: if(e->prevptr != 0) *(e->prevptr) = 0;
   40DC DD 4E 04      [19]   76 	ld	c,4 (ix)
   40DF DD 46 05      [19]   77 	ld	b,5 (ix)
   40E2 21 05 00      [10]   78 	ld	hl, #0x0005
   40E5 09            [11]   79 	add	hl,bc
   40E6 E3            [19]   80 	ex	(sp), hl
   40E7 E1            [10]   81 	pop	hl
   40E8 E5            [11]   82 	push	hl
   40E9 5E            [ 7]   83 	ld	e, (hl)
   40EA 23            [ 6]   84 	inc	hl
   40EB 56            [ 7]   85 	ld	d, (hl)
   40EC 7A            [ 4]   86 	ld	a, d
   40ED B3            [ 4]   87 	or	a,e
   40EE 28 02         [12]   88 	jr	Z,00102$
   40F0 AF            [ 4]   89 	xor	a, a
   40F1 12            [ 7]   90 	ld	(de), a
   40F2                      91 00102$:
                             92 ;src/sys/render.c:12: if(!(e->type & e_type_dead)){
   40F2 0A            [ 7]   93 	ld	a, (bc)
   40F3 07            [ 4]   94 	rlca
   40F4 38 1F         [12]   95 	jr	C,00105$
                             96 ;src/sys/render.c:13: u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
   40F6 69            [ 4]   97 	ld	l, c
   40F7 60            [ 4]   98 	ld	h, b
   40F8 23            [ 6]   99 	inc	hl
   40F9 23            [ 6]  100 	inc	hl
   40FA 56            [ 7]  101 	ld	d, (hl)
   40FB 69            [ 4]  102 	ld	l, c
   40FC 60            [ 4]  103 	ld	h, b
   40FD 23            [ 6]  104 	inc	hl
   40FE 7E            [ 7]  105 	ld	a, (hl)
   40FF C5            [11]  106 	push	bc
   4100 5F            [ 4]  107 	ld	e, a
   4101 D5            [11]  108 	push	de
   4102 21 00 C0      [10]  109 	ld	hl, #0xc000
   4105 E5            [11]  110 	push	hl
   4106 CD A4 42      [17]  111 	call	_cpct_getScreenPtr
   4109 EB            [ 4]  112 	ex	de,hl
   410A FD E1         [14]  113 	pop	iy
   410C FD 7E 04      [19]  114 	ld	a, 4 (iy)
   410F 12            [ 7]  115 	ld	(de), a
                            116 ;src/sys/render.c:15: e->prevptr = pvmem;
   4110 E1            [10]  117 	pop	hl
   4111 E5            [11]  118 	push	hl
   4112 73            [ 7]  119 	ld	(hl), e
   4113 23            [ 6]  120 	inc	hl
   4114 72            [ 7]  121 	ld	(hl), d
   4115                     122 00105$:
   4115 DD F9         [10]  123 	ld	sp, ix
   4117 DD E1         [14]  124 	pop	ix
   4119 C9            [10]  125 	ret
                            126 ;src/sys/render.c:19: void sys_render_update() {
                            127 ;	---------------------------------
                            128 ; Function sys_render_update
                            129 ; ---------------------------------
   411A                     130 _sys_render_update::
                            131 ;src/sys/render.c:20: man_entity_forall ( sys_render_one_entity );
   411A 21 D3 40      [10]  132 	ld	hl, #_sys_render_one_entity
   411D E5            [11]  133 	push	hl
   411E CD 57 41      [17]  134 	call	_man_entity_forall
   4121 F1            [10]  135 	pop	af
   4122 C9            [10]  136 	ret
                            137 	.area _CODE
                            138 	.area _INITIALIZER
                            139 	.area _CABS (ABS)
