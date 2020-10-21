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
                             13 	.globl _sys_render_one_entity
                             14 	.globl _sys_render_update
                             15 ;--------------------------------------------------------
                             16 ; special function registers
                             17 ;--------------------------------------------------------
                             18 ;--------------------------------------------------------
                             19 ; ram data
                             20 ;--------------------------------------------------------
                             21 	.area _DATA
                             22 ;--------------------------------------------------------
                             23 ; ram data
                             24 ;--------------------------------------------------------
                             25 	.area _INITIALIZED
                             26 ;--------------------------------------------------------
                             27 ; absolute external ram data
                             28 ;--------------------------------------------------------
                             29 	.area _DABS (ABS)
                             30 ;--------------------------------------------------------
                             31 ; global & static initialisations
                             32 ;--------------------------------------------------------
                             33 	.area _HOME
                             34 	.area _GSINIT
                             35 	.area _GSFINAL
                             36 	.area _GSINIT
                             37 ;--------------------------------------------------------
                             38 ; Home
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _HOME
                             42 ;--------------------------------------------------------
                             43 ; code
                             44 ;--------------------------------------------------------
                             45 	.area _CODE
                             46 ;src/sys/render.c:4: void sys_render_one_entity(Entity_t* e) {
                             47 ;	---------------------------------
                             48 ; Function sys_render_one_entity
                             49 ; ---------------------------------
   4088                      50 _sys_render_one_entity::
   4088 DD E5         [15]   51 	push	ix
   408A DD 21 00 00   [14]   52 	ld	ix,#0
   408E DD 39         [15]   53 	add	ix,sp
                             54 ;src/sys/render.c:5: u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
   4090 DD 5E 04      [19]   55 	ld	e,4 (ix)
   4093 DD 56 05      [19]   56 	ld	d,5 (ix)
   4096 6B            [ 4]   57 	ld	l, e
   4097 62            [ 4]   58 	ld	h, d
   4098 23            [ 6]   59 	inc	hl
   4099 23            [ 6]   60 	inc	hl
   409A 46            [ 7]   61 	ld	b, (hl)
   409B 6B            [ 4]   62 	ld	l, e
   409C 62            [ 4]   63 	ld	h, d
   409D 23            [ 6]   64 	inc	hl
   409E 7E            [ 7]   65 	ld	a, (hl)
   409F D5            [11]   66 	push	de
   40A0 C5            [11]   67 	push	bc
   40A1 33            [ 6]   68 	inc	sp
   40A2 F5            [11]   69 	push	af
   40A3 33            [ 6]   70 	inc	sp
   40A4 21 00 C0      [10]   71 	ld	hl, #0xc000
   40A7 E5            [11]   72 	push	hl
   40A8 CD 4A 41      [17]   73 	call	_cpct_getScreenPtr
   40AB 4D            [ 4]   74 	ld	c, l
   40AC 44            [ 4]   75 	ld	b, h
   40AD FD E1         [14]   76 	pop	iy
   40AF FD 7E 04      [19]   77 	ld	a, 4 (iy)
   40B2 02            [ 7]   78 	ld	(bc), a
   40B3 DD E1         [14]   79 	pop	ix
   40B5 C9            [10]   80 	ret
                             81 ;src/sys/render.c:9: void sys_render_update() {
                             82 ;	---------------------------------
                             83 ; Function sys_render_update
                             84 ; ---------------------------------
   40B6                      85 _sys_render_update::
                             86 ;src/sys/render.c:10: man_entity_forall ( sys_render_one_entity );
   40B6 21 88 40      [10]   87 	ld	hl, #_sys_render_one_entity
   40B9 E5            [11]   88 	push	hl
   40BA CD E5 40      [17]   89 	call	_man_entity_forall
   40BD F1            [10]   90 	pop	af
   40BE C9            [10]   91 	ret
                             92 	.area _CODE
                             93 	.area _INITIALIZER
                             94 	.area _CABS (ABS)
