                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module generator
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _generateNewStar
                             12 	.globl _man_entity_freeSpace
                             13 	.globl _man_entitiy_create
                             14 	.globl _cpct_getRandom_mxor_u8
                             15 	.globl _cpct_memcpy
                             16 	.globl _init_e
                             17 	.globl _sys_generator_update
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
                             49 ;src/sys/generator.c:12: void generateNewStar(){
                             50 ;	---------------------------------
                             51 ; Function generateNewStar
                             52 ; ---------------------------------
   402D                      53 _generateNewStar::
                             54 ;src/sys/generator.c:13: Entity_t* e = man_entitiy_create();
   402D CD 42 41      [17]   55 	call	_man_entitiy_create
   4030 4D            [ 4]   56 	ld	c, l
   4031 44            [ 4]   57 	ld	b, h
                             58 ;src/sys/generator.c:14: cpct_memcpy (e, &init_e, sizeof(Entity_t));
   4032 59            [ 4]   59 	ld	e, c
   4033 50            [ 4]   60 	ld	d, b
   4034 C5            [11]   61 	push	bc
   4035 21 07 00      [10]   62 	ld	hl, #0x0007
   4038 E5            [11]   63 	push	hl
   4039 21 6B 40      [10]   64 	ld	hl, #_init_e
   403C E5            [11]   65 	push	hl
   403D D5            [11]   66 	push	de
   403E CD 66 42      [17]   67 	call	_cpct_memcpy
   4041 C1            [10]   68 	pop	bc
                             69 ;src/sys/generator.c:16: e -> y   = cpct_rand() % 200;
   4042 59            [ 4]   70 	ld	e, c
   4043 50            [ 4]   71 	ld	d, b
   4044 13            [ 6]   72 	inc	de
   4045 13            [ 6]   73 	inc	de
   4046 C5            [11]   74 	push	bc
   4047 D5            [11]   75 	push	de
   4048 CD 7E 42      [17]   76 	call	_cpct_getRandom_mxor_u8
   404B 65            [ 4]   77 	ld	h, l
   404C 3E C8         [ 7]   78 	ld	a, #0xc8
   404E F5            [11]   79 	push	af
   404F 33            [ 6]   80 	inc	sp
   4050 E5            [11]   81 	push	hl
   4051 33            [ 6]   82 	inc	sp
   4052 CD E4 41      [17]   83 	call	__moduchar
   4055 F1            [10]   84 	pop	af
   4056 7D            [ 4]   85 	ld	a, l
   4057 D1            [10]   86 	pop	de
   4058 C1            [10]   87 	pop	bc
   4059 12            [ 7]   88 	ld	(de), a
                             89 ;src/sys/generator.c:18: e -> vx  = -1-(cpct_rand() & 0x03);
   405A 03            [ 6]   90 	inc	bc
   405B 03            [ 6]   91 	inc	bc
   405C 03            [ 6]   92 	inc	bc
   405D C5            [11]   93 	push	bc
   405E CD 7E 42      [17]   94 	call	_cpct_getRandom_mxor_u8
   4061 C1            [10]   95 	pop	bc
   4062 7D            [ 4]   96 	ld	a, l
   4063 E6 03         [ 7]   97 	and	a, #0x03
   4065 5F            [ 4]   98 	ld	e, a
   4066 3E FF         [ 7]   99 	ld	a, #0xff
   4068 93            [ 4]  100 	sub	a, e
   4069 02            [ 7]  101 	ld	(bc), a
   406A C9            [10]  102 	ret
   406B                     103 _init_e:
   406B 01                  104 	.db #0x01	; 1
   406C 4F                  105 	.db #0x4f	; 79	'O'
   406D 01                  106 	.db #0x01	; 1
   406E FF                  107 	.db #0xff	; -1
   406F FF                  108 	.db #0xff	; 255
   4070 00 00               109 	.dw #0x0000
                            110 ;src/sys/generator.c:21: void sys_generator_update(){
                            111 ;	---------------------------------
                            112 ; Function sys_generator_update
                            113 ; ---------------------------------
   4072                     114 _sys_generator_update::
                            115 ;src/sys/generator.c:22: u8 free = man_entity_freeSpace();
   4072 CD D0 41      [17]  116 	call	_man_entity_freeSpace
                            117 ;src/sys/generator.c:23: if(free){
   4075 7D            [ 4]  118 	ld	a, l
   4076 B7            [ 4]  119 	or	a, a
   4077 C8            [11]  120 	ret	Z
                            121 ;src/sys/generator.c:24: generateNewStar();
   4078 C3 2D 40      [10]  122 	jp  _generateNewStar
                            123 	.area _CODE
                            124 	.area _INITIALIZER
                            125 	.area _CABS (ABS)
