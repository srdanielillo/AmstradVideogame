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
                             12 	.globl _cpct_getScreenPtr
                             13 	.globl _cpct_drawStringM1
                             14 	.globl _cpct_setDrawCharM1
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
                             46 ;src/main.c:21: void main(void) {
                             47 ;	---------------------------------
                             48 ; Function main
                             49 ; ---------------------------------
   4000                      50 _main::
                             51 ;src/main.c:27: pvmem = cpct_getScreenPtr(CPCT_VMEM_START, 20, 96);
   4000 21 14 60      [10]   52 	ld	hl, #0x6014
   4003 E5            [11]   53 	push	hl
   4004 21 00 C0      [10]   54 	ld	hl, #0xc000
   4007 E5            [11]   55 	push	hl
   4008 CD B5 40      [17]   56 	call	_cpct_getScreenPtr
                             57 ;src/main.c:30: cpct_setDrawCharM1(1, 0);
   400B E5            [11]   58 	push	hl
   400C 01 01 00      [10]   59 	ld	bc, #0x0001
   400F C5            [11]   60 	push	bc
   4010 CD D5 40      [17]   61 	call	_cpct_setDrawCharM1
   4013 E1            [10]   62 	pop	hl
                             63 ;src/main.c:32: cpct_drawStringM1("Welcome to CPCtelera!", pvmem);
   4014 01 1E 40      [10]   64 	ld	bc, #___str_0+0
   4017 E5            [11]   65 	push	hl
   4018 C5            [11]   66 	push	bc
   4019 CD 34 40      [17]   67 	call	_cpct_drawStringM1
                             68 ;src/main.c:35: while (1);
   401C                      69 00102$:
   401C 18 FE         [12]   70 	jr	00102$
   401E                      71 ___str_0:
   401E 57 65 6C 63 6F 6D    72 	.ascii "Welcome to CPCtelera!"
        65 20 74 6F 20 43
        50 43 74 65 6C 65
        72 61 21
   4033 00                   73 	.db 0x00
                             74 	.area _CODE
                             75 	.area _INITIALIZER
                             76 	.area _CABS (ABS)
