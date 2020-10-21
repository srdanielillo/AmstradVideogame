                              1 ;--------------------------------------------------------
                              2 ; File Created by SDCC : free open source ANSI-C Compiler
                              3 ; Version 3.6.8 #9946 (Linux)
                              4 ;--------------------------------------------------------
                              5 	.module physics
                              6 	.optsdcc -mz80
                              7 	
                              8 ;--------------------------------------------------------
                              9 ; Public variables in this module
                             10 ;--------------------------------------------------------
                             11 	.globl _sys_physics_update_one_entity
                             12 	.globl _man_entity_forall
                             13 	.globl _man_entity_destroy
                             14 	.globl _sys_phyisics_update
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
                             46 ;src/sys/physics.c:4: void sys_physics_update_one_entity(Entity_t *e){
                             47 ;	---------------------------------
                             48 ; Function sys_physics_update_one_entity
                             49 ; ---------------------------------
   4044                      50 _sys_physics_update_one_entity::
   4044 DD E5         [15]   51 	push	ix
   4046 DD 21 00 00   [14]   52 	ld	ix,#0
   404A DD 39         [15]   53 	add	ix,sp
   404C F5            [11]   54 	push	af
                             55 ;src/sys/physics.c:5: u8 newx = e->x + e->vx;
   404D DD 4E 04      [19]   56 	ld	c,4 (ix)
   4050 DD 46 05      [19]   57 	ld	b,5 (ix)
   4053 59            [ 4]   58 	ld	e, c
   4054 50            [ 4]   59 	ld	d, b
   4055 13            [ 6]   60 	inc	de
   4056 1A            [ 7]   61 	ld	a, (de)
   4057 DD 77 FF      [19]   62 	ld	-1 (ix), a
   405A 69            [ 4]   63 	ld	l, c
   405B 60            [ 4]   64 	ld	h, b
   405C 23            [ 6]   65 	inc	hl
   405D 23            [ 6]   66 	inc	hl
   405E 23            [ 6]   67 	inc	hl
   405F 6E            [ 7]   68 	ld	l, (hl)
   4060 DD 7E FF      [19]   69 	ld	a, -1 (ix)
   4063 85            [ 4]   70 	add	a, l
   4064 DD 77 FE      [19]   71 	ld	-2 (ix), a
                             72 ;src/sys/physics.c:7: if(newx > e -> x){
   4067 DD 7E FF      [19]   73 	ld	a, -1 (ix)
   406A DD 96 FE      [19]   74 	sub	a, -2 (ix)
   406D 30 07         [12]   75 	jr	NC,00102$
                             76 ;src/sys/physics.c:8: man_entity_destroy(e);
   406F C5            [11]   77 	push	bc
   4070 CD 01 41      [17]   78 	call	_man_entity_destroy
   4073 F1            [10]   79 	pop	af
   4074 18 04         [12]   80 	jr	00104$
   4076                      81 00102$:
                             82 ;src/sys/physics.c:11: e->x = newx;
   4076 DD 7E FE      [19]   83 	ld	a, -2 (ix)
   4079 12            [ 7]   84 	ld	(de), a
   407A                      85 00104$:
   407A DD F9         [10]   86 	ld	sp, ix
   407C DD E1         [14]   87 	pop	ix
   407E C9            [10]   88 	ret
                             89 ;src/sys/physics.c:15: void sys_phyisics_update(){
                             90 ;	---------------------------------
                             91 ; Function sys_phyisics_update
                             92 ; ---------------------------------
   407F                      93 _sys_phyisics_update::
                             94 ;src/sys/physics.c:16: man_entity_forall( sys_physics_update_one_entity );
   407F 21 44 40      [10]   95 	ld	hl, #_sys_physics_update_one_entity
   4082 E5            [11]   96 	push	hl
   4083 CD E5 40      [17]   97 	call	_man_entity_forall
   4086 F1            [10]   98 	pop	af
   4087 C9            [10]   99 	ret
                            100 	.area _CODE
                            101 	.area _INITIALIZER
                            102 	.area _CABS (ABS)
