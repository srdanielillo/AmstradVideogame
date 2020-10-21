                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module main
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _main
                             12 	.globl _createEntity
                             13 	.globl _sys_render_update
                             14 	.globl _sys_phyisics_update
                             15 	.globl _man_entitiy_create
                             16 	.globl _man_entitiy_init
                             17 	.globl _cpct_setPALColour
                             18 	.globl _cpct_setVideoMode
                             19 	.globl _cpct_memcpy
                             20 	.globl _cpct_disableFirmware
                             21 	.globl _init_e
                             22 ;--------------------------------------------------------
                             23 ; special function registers
                             24 ;--------------------------------------------------------
                             25 ;--------------------------------------------------------
                             26 ; ram data
                             27 ;--------------------------------------------------------
                             28 	.area _DATA
                             29 ;--------------------------------------------------------
                             30 ; ram data
                             31 ;--------------------------------------------------------
                             32 	.area _INITIALIZED
                             33 ;--------------------------------------------------------
                             34 ; absolute external ram data
                             35 ;--------------------------------------------------------
                             36 	.area _DABS (ABS)
                             37 ;--------------------------------------------------------
                             38 ; global & static initialisations
                             39 ;--------------------------------------------------------
                             40 	.area _HOME
                             41 	.area _GSINIT
                             42 	.area _GSFINAL
                             43 	.area _GSINIT
                             44 ;--------------------------------------------------------
                             45 ; Home
                             46 ;--------------------------------------------------------
                             47 	.area _HOME
                             48 	.area _HOME
                             49 ;--------------------------------------------------------
                             50 ; code
                             51 ;--------------------------------------------------------
                             52 	.area _CODE
                             53 ;src/main.c:31: void createEntity(){
                             54 ;	---------------------------------
                             55 ; Function createEntity
                             56 ; ---------------------------------
   4000                      57 _createEntity::
                             58 ;src/main.c:32: Entity_t* e = man_entitiy_create();
   4000 CD D4 40      [17]   59 	call	_man_entitiy_create
                             60 ;src/main.c:33: cpct_memcpy (e, &init_e, sizeof(Entity_t));
   4003 01 10 40      [10]   61 	ld	bc, #_init_e+0
   4006 11 05 00      [10]   62 	ld	de, #0x0005
   4009 D5            [11]   63 	push	de
   400A C5            [11]   64 	push	bc
   400B E5            [11]   65 	push	hl
   400C CD 31 41      [17]   66 	call	_cpct_memcpy
   400F C9            [10]   67 	ret
   4010                      68 _init_e:
   4010 01                   69 	.db #0x01	; 1
   4011 4F                   70 	.db #0x4f	; 79	'O'
   4012 01                   71 	.db #0x01	; 1
   4013 FF                   72 	.db #0xff	; -1
   4014 FF                   73 	.db #0xff	; 255
                             74 ;src/main.c:36: void main(void) {
                             75 ;	---------------------------------
                             76 ; Function main
                             77 ; ---------------------------------
   4015                      78 _main::
                             79 ;src/main.c:37: cpct_disableFirmware();
   4015 CD 39 41      [17]   80 	call	_cpct_disableFirmware
                             81 ;src/main.c:38: cpct_setVideoMode(0);
   4018 2E 00         [ 7]   82 	ld	l, #0x00
   401A CD 15 41      [17]   83 	call	_cpct_setVideoMode
                             84 ;src/main.c:39: cpct_setBorder(HW_BLACK);
   401D 21 10 14      [10]   85 	ld	hl, #0x1410
   4020 E5            [11]   86 	push	hl
   4021 CD 08 41      [17]   87 	call	_cpct_setPALColour
                             88 ;src/main.c:40: cpct_setPALColour(0, HW_BLACK);
   4024 21 00 14      [10]   89 	ld	hl, #0x1400
   4027 E5            [11]   90 	push	hl
   4028 CD 08 41      [17]   91 	call	_cpct_setPALColour
                             92 ;src/main.c:42: man_entitiy_init();
   402B CD BF 40      [17]   93 	call	_man_entitiy_init
                             94 ;src/main.c:43: for(u8 i = 5; i > 0 ; --i){
   402E 0E 05         [ 7]   95 	ld	c, #0x05
   4030                      96 00106$:
   4030 79            [ 4]   97 	ld	a, c
   4031 B7            [ 4]   98 	or	a, a
   4032 28 08         [12]   99 	jr	Z,00101$
                            100 ;src/main.c:44: createEntity();
   4034 C5            [11]  101 	push	bc
   4035 CD 00 40      [17]  102 	call	_createEntity
   4038 C1            [10]  103 	pop	bc
                            104 ;src/main.c:43: for(u8 i = 5; i > 0 ; --i){
   4039 0D            [ 4]  105 	dec	c
   403A 18 F4         [12]  106 	jr	00106$
   403C                     107 00101$:
                            108 ;src/main.c:46: sys_phyisics_update();
   403C CD 7F 40      [17]  109 	call	_sys_phyisics_update
                            110 ;src/main.c:47: sys_render_update();
   403F CD B6 40      [17]  111 	call	_sys_render_update
                            112 ;src/main.c:49: while(1);
   4042                     113 00103$:
   4042 18 FE         [12]  114 	jr	00103$
                            115 	.area _CODE
                            116 	.area _INITIALIZER
                            117 	.area _CABS (ABS)
