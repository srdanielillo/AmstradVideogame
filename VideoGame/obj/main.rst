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
                             12 	.globl _wait
                             13 	.globl _sys_generator_update
                             14 	.globl _sys_render_update
                             15 	.globl _sys_render_init
                             16 	.globl _sys_phyisics_update
                             17 	.globl _man_entity_update
                             18 	.globl _man_entitiy_init
                             19 	.globl _cpct_waitVSYNC
                             20 	.globl _cpct_waitHalts
                             21 	.globl _cpct_disableFirmware
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
                             53 ;src/main.c:27: void wait(u8 n){
                             54 ;	---------------------------------
                             55 ; Function wait
                             56 ; ---------------------------------
   4000                      57 _wait::
                             58 ;src/main.c:28: do{
   4000 21 02 00      [10]   59 	ld	hl, #2+0
   4003 39            [11]   60 	add	hl, sp
   4004 4E            [ 7]   61 	ld	c, (hl)
   4005                      62 00101$:
                             63 ;src/main.c:29: cpct_waitHalts(2);
   4005 C5            [11]   64 	push	bc
   4006 2E 02         [ 7]   65 	ld	l, #0x02
   4008 CD FB 41      [17]   66 	call	_cpct_waitHalts
   400B CD 50 42      [17]   67 	call	_cpct_waitVSYNC
   400E C1            [10]   68 	pop	bc
                             69 ;src/main.c:31: } while(--n);
   400F 0D            [ 4]   70 	dec c
   4010 20 F3         [12]   71 	jr	NZ,00101$
   4012 C9            [10]   72 	ret
                             73 ;src/main.c:34: void main(void) {
                             74 ;	---------------------------------
                             75 ; Function main
                             76 ; ---------------------------------
   4013                      77 _main::
                             78 ;src/main.c:35: cpct_disableFirmware();
   4013 CD 6E 42      [17]   79 	call	_cpct_disableFirmware
                             80 ;src/main.c:37: man_entitiy_init();
   4016 CD 23 41      [17]   81 	call	_man_entitiy_init
                             82 ;src/main.c:38: sys_render_init();
   4019 CD BF 40      [17]   83 	call	_sys_render_init
                             84 ;src/main.c:39: while(1){
   401C                      85 00102$:
                             86 ;src/main.c:40: sys_phyisics_update();
   401C CD B6 40      [17]   87 	call	_sys_phyisics_update
                             88 ;src/main.c:41: sys_generator_update();
   401F CD 72 40      [17]   89 	call	_sys_generator_update
                             90 ;src/main.c:42: sys_render_update();
   4022 CD 1A 41      [17]   91 	call	_sys_render_update
                             92 ;src/main.c:44: man_entity_update();
   4025 CD B8 41      [17]   93 	call	_man_entity_update
                             94 ;src/main.c:45: cpct_waitVSYNC();
   4028 CD 50 42      [17]   95 	call	_cpct_waitVSYNC
   402B 18 EF         [12]   96 	jr	00102$
                             97 	.area _CODE
                             98 	.area _INITIALIZER
                             99 	.area _CABS (ABS)
