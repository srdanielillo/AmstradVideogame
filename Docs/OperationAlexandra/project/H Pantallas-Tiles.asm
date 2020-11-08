;;----------------------------------------------
;;Pinta_Pantalla
;;Pinta la pantalla dada en A
;;----------------------------------------------
;;Coge_Supertiles
;;Coge los STiles de la pantalla y manda dibujarlos en la posición
;;----------------------------------------------
;;Borra_Pantalla
;;Rellena la pantalla con BYTE_FONDO_PANTALLA
;;----------------------------------------------
;;Borra_Mapa_Durezas
;;Borra la zona del Mapa de Durezas
;;----------------------------------------------
;;Pinta_Supertile
;;Pinta en pantalla el STile E en BC (Y,X)
;;----------------------------------------------
;;Pinta_Supertile_Rotado
;;Pinta en pantalla el STile E en BC (Y,X) ROTADO
;;----------------------------------------------
;;write_tile_screen_YX
;;escribe un tile en pantalla
;;----------------------------------------------
;;write_tile_screen_rotado_YX
;;escribe un tile en pantalla ROTADO
;;----------------------------------------------
;;Asigna_Durezas
;;Asigna las durezas del mapa en BC
;;----------------------------------------------
;;Lee_Durezas
;;Lee las durezas del mapa en BC y las devuelve en A
;;----------------------------------------------

;;
;;lees las durezas del mapa en BC
;;
;;ENTRADA
;;BC:Coordenadas (Y,X) y/8 x/2
;;SALIDA
;;A:dureza según las constantes BIT_
;;destruye BC,DE,HL,A
;;
Lee_Durezas
	XOR	A
	SRL	C	;X/2
	SRL	B
	SRL	B
	SRL	B	;Y/8
Lee_Durezas_Div									;optimizado
	LD      A,(OFFSET_PANTALLA)
	LD      E,A
	LD      A,B
	SUB     E
	LD      E,A
	RLA
	RLA
	RLA
	REPEAT  2
		ADD     E
	REND
	;he multiplicado A*10 (primero por 8 y luego he sumado 2 veces)
	LD      E,A
	LD      D,0
	;LD      B,10
	LD      HL,MAPA_DUREZAS
mul10_LD
	ADD     HL,DE
	;DJNZ    mul10_LD
	XOR	A
	LD      E,C
	SRL     E
	RLA
	SRL     E
	RLA
	ADD     HL,DE           ;me posiciono en el byte a tocar
				;ahora toca cambiar los bits correspondientes
				;en A queda el resto para elegir la pareja de bits

	OR	A
	JR	Z,pareja_0_ld
	CP	1
	JR	Z,pareja_1_ld
	CP	2
	JR	Z,pareja_2_ld
pareja_3_ld
	LD	A,(HL)
	AND	%00000011
	RET
pareja_2_ld
	LD	A,(HL)
	AND	%00001100
	SRL	A
	SRL	A
	RET
pareja_1_ld
	LD	A,(HL)
	AND	%00110000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	RET
pareja_0_ld
	LD	A,(HL)
	AND	%11000000
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	SRL	A
	RET

;;
;;Pinta la pantalla dada en A
;;
;;ENTRADA
;;A: pantalla a pintar
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
;;comparativa		antes
;;PANTALLA_00	 	 422986
;;PANTALLA_03		 666000
;;PANTALLA_02		 806600
;;PANTALLA_01		1030000
Pinta_Pantalla
	CP	#FF
	RET	Z
	PUSH	AF
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	LD	HL,SPRITE0_CHECKS
    XOR  A
    LD   (EFECTO_TINTAS),A
	;BIT    CHECK_MUERTE,(HL)
	;CALL	Z,fadeout
	pop  af
	push af
    CP PANTALLA_FIN
    jr nz,pantalla_normal_pp
    CALL fadeout
    jr sigue_pp
pantalla_normal_pp
	LD     HL,TINTAS_Negro
	CALL   Cambia_Tintas_Juego
sigue_pp
	;CALL	imprime_vidas
	LD	HL,SPRITE0_CHECKS
	RES 	CHECK_MUERTE,(HL)
	LD	A,1
	LD	(CHECK_ASIGNA_DUREZAS),A
	;POP	AF
	LD	HL,SPRITE0_INT
	LD	(HL),0
	LD	DE,SPRITE1_INT
	LD  BC,11
	LDIR
	LD	HL,DISPARO0_ESTADO
	LD	(HL),0
	LD	HL,DISPARO1_ESTADO
	LD	(HL),0
	LD	HL,DISPARO2_ESTADO
	LD	(HL),0
	LD	HL,DISPARO3_ESTADO
	LD	(HL),0
	LD	HL,DISPARO4_ESTADO
	LD	(HL),0
; 	LD	HL,DISPARO5_ESTADO
;  	LD	(HL),0
	LD 	HL,STATIC0_ID
	LD	(HL),#FF
	LD 	HL,STATIC1_ID
	LD	(HL),#FF
	LD 	HL,STATIC2_ID
	LD	(HL),#FF
	LD 	HL,STATIC3_ID
	LD	(HL),#FF
; 	LD 	HL,STATIC4_ID
; 	LD	(HL),#FF

	LD	HL,BUFFER
	LD	(Buffer_actual),HL
; 	LD  DE,BUFFER+1
; 	LD  BC,ALTO_MAPA_TILES*ANCHO_MAPA_TILES-1
; 	LD  (HL),0
; 	LDIR

	;PUSH	AF
	CALL	Borra_Mapa_Durezas		;no haría falta, pero es más limpio así
	POP	AF

	LD	HL,PANTALLA_ACTUAL
	LD	(HL),A
	push af
	CP  PANTALLA_MENU
	JR  NZ,offset5
offset5_1
	CALL 	Borra_Pantalla_Completa
	XOR A
	JR  asignaOffset
offset5
	CP  PANTALLA_FIN
	JR  Z,offset5_1

	CALL 	Borra_Pantalla
	LD  A,5
asignaOffset
	LD  (OFFSET_PANTALLA),A
	pop af
	LD	HL,MAPA_PANTALLAS
	RLCA
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD   	A,(HL)
	LD	E,A
	INC  	HL
	LD	A,(HL)
	LD   	D,A
	EX	DE,HL			;dejo en HL la posición de la pantalla (PANTALLA_XX)

;  	LD      A,5
;  	LD      (OFFSET_PANTALLA),A

	;LD	DE,DATOS_PANTALLA_ACTUAL
	;LD	BC,4
	;LDIR				;vuelco los datos iniciales de la pantalla
datos_pantallas_PP
	LD  A,(HL)
	AND %00001111
	OR  A
	JR  Z,pon_ff0
	LD  B,A
	LD  A,(PANTALLA_ACTUAL)
	ADD B
	JR  pon_pa0
pon_ff0
	LD  A,&ff
pon_pa0
	LD  (DATOS_PANTALLA_ACTUAL+1),A
	LD  A,(HL)
	AND %11110000
	RRA
	RRA
	RRA
	RRA
	OR  A
	JR  Z,pon_ff1
	LD  B,A
	LD  A,(PANTALLA_ACTUAL)
	SUB B
	JR  pon_pa1
pon_ff1
	LD  A,&ff
pon_pa1
	LD  (DATOS_PANTALLA_ACTUAL),A
	INC HL
	LD  A,(HL)
	AND %11110000
	RRA
	RRA
	RRA
	RRA
	OR  A
	JR  Z,pon_ff2
	LD  B,A
	LD  A,(PANTALLA_ACTUAL)
	SUB B
	JR  pon_pa2
pon_ff2
	LD  A,&ff
pon_pa2
	LD  (DATOS_PANTALLA_ACTUAL+2),A
	LD  A,(HL)
	AND %00001111
	OR  A
	JR  Z,pon_ff3
	LD  B,A
	LD  A,(PANTALLA_ACTUAL)
	ADD B
	JR  pon_pa3
pon_ff3
	LD  A,&ff
pon_pa3
	LD  (DATOS_PANTALLA_ACTUAL+3),A
	INC HL

	;IZQ,DER,ARR,ABA,PUERTA,PosXPuerta,PosYPuerta
	;pinto la zona de repetitivos hasta que encuentro un 255
otro_stile_repetitivo
	;INC     HL
 	LD	A,(HL)
 	CP	255
 	INC     HL
 	JR	Z,inicio_verifica_stiles_pp
 	;A tiene el stile
 	EX      AF,AF'    ;'
 	LD      A,(HL)	;repeticiones horizontales/verticales
 	RR 	A
 	RR 	A
 	RR 	A
 	RR 	A
 	AND     %00001111
 	LD      E,A
 	LD      A,(HL)
 	AND     %00001111
 	LD      D,A  ;repeticiones verticales
 	EX      AF,AF'   ;'
 	INC     HL
 	LD      C,(HL)	;X
 	INC     HL
 	LD      B,(HL)  ;Y
 	INC     HL
 	PUSH    HL
 repitey_st_r
 	PUSH    AF
 	PUSH    DE
 	push    BC
 repitex_st_r
 	PUSH    AF
 	PUSH    DE
 	PUSH    BC
 	LD      E,A
 	CALL	Pinta_Supertile
 	;;A:ancho
	;;D:alto
	POP     BC
	EX      AF,AF'	;A'
	LD      A,D
	EX      AF,AF'	;A'
	POP     DE
	ADD     A,C
	LD      C,A
	POP     AF
	DEC     E
	JR      NZ,repitex_st_r
	EX      AF,AF'   ;'
	POP     BC
	POP     DE
	ADD     A,B
	LD      B,A
	POP     AF
	DEC     D
	JR      NZ,repitey_st_r

 	POP 	HL
 	JR      otro_stile_repetitivo

	;A partir de aquí leo los STiles y los voy pintando y apuntando su dureza
inicio_verifica_stiles_pp
	LD	A,(HL)
	CP	255
	JR	NZ,inicio_stiles_pp
	INC	HL
	LD	A,(HL)
	INC	HL
	PUSH	HL
	LD	H,(HL)
	LD	L,A
inicio_stiles_bucle_pp
	LD	A,(HL)
	INC     HL
	CP	255
	JR	Z,fin_stiles_bucle_pp
	LD	E,A			;en E dejoel STile
	CALL	Coge_Supertiles
	JR	inicio_stiles_bucle_pp
fin_stiles_bucle_pp
	POP     HL
	INC	HL
	JR	fin_stiles_pp
inicio_stiles_pp
	LD	A,(HL)
	INC     HL
	CP	255
	JR	Z,fin_stiles_pp
	LD	E,A			;en E dejoel STile
	CALL	Coge_Supertiles
	JR	inicio_stiles_pp

	;a partir de aqui los individuales
fin_stiles_pp
	LD      A,(HL)
	INC     HL
	CP      255
	JR      Z,fin_stiles_individuales_pp
	LD      E,JUEGO_TILES_1		;de moemnto en el juego de tiles 0***
	LD      C,A
	LD      B,(HL)
	INC     HL
	LD      A,(HL)
	INC     HL
	EX      AF,AF'     ;'
	push  	HL
	push  	bc
	push  	de
	CALL  	Asigna_Durezas
	pop   	de
	pop   	bc
	pop   	hl
	PUSH    HL
	CALL	write_tile_screen_YX
	POP     HL
	JR      fin_stiles_pp

fin_stiles_individuales_pp
	;A partir de aquí leo los SSprites para los enemigos
	LD	IX,SPRITE1
	LD	B,1
otro_enemigo_pp
	PUSH	HL
	POP	IY
	LD	A,(HL)
	CP	255
	JR	Z,fin_ssprites_pp
	PUSH	BC
	CALL	Coge_Supersprites	;en B va el sprite_ID
	LD	BC,LONG_SPRITES
	ADD	IX,BC			;siguiente sprite
	PUSH	IY
	POP	HL
	LD	BC,6
	ADD	HL,BC
	POP	BC
	INC	B
	JR	otro_enemigo_pp
fin_ssprites_pp
; 	LD	A,B
; 	DEC	A
; 	LD	(SPRITES_PANTALLA),A
	INC	HL
	;a partir de aqui cojo el objeto de la pantalla, si lo hay
	LD	IX,STATIC0
otro_statics_pp
	LD	A,(HL)
	INC     HL
	CP	255
	JR	Z,espera_CFP_pp
 	CALL comun_otro_statics

 	LD	BC,LONG_STATICS
 	ADD	IX,BC
 	JR	otro_statics_pp

espera_CFP_pp
	LD	A,(Sig_Interrupcion)
	CP	0
	JR	NZ,espera_CFP_pp

	;esto sirve para desactivar los sprites en el menu
	;LD	A,(PANTALLA_ACTUAL)
	;CP	PANTALLA_MENU
	;JR	Z,salir_pp

	LD	A,%00001101
	LD	(SPRITE0_INT),A

	LD	 HL,(Buffer_actual)
	LD	 (SPRITE0_BUFF),HL
	LD       BC,6*24
	ADD      HL,BC
	LD	 (Buffer_actual),HL		;inicializo el buffer añadiendo el sprite0

; 	;calculo buffer mayor
; 	LD   HL,(Buffer_Mayor)
; 	LD   BC,(Buffer_actual)
; 	XOR  A
; 	SBC  HL,BC
; 	JP   P,es_buffer_menor
; 	LD   (Buffer_Mayor),BC
; es_buffer_menor

	LD	 HL,SPRITE0_CHECKS
	RES	 CHECK_CAMBIO,(HL)
salir_pp
	LD   A,(PANTALLA_ACTUAL)
	CP   PANTALLA_MENU
	CALL Z,Pinta_texto_Menu
	CP   PANTALLA_FIN
	CALL Z,Pinta_texto_Fin
	LD       HL,TINTAS_JUEGO
	CALL     Cambia_Tintas_Juego

	XOR	A
	LD	(Pas_Interrupcion),A
	LD  HL,PANTALLA_ACTUAL
	LD  A,(HL)
	CP  PANTALLA_MENU
	RET Z
	CP  PANTALLA_FIN
	jr  Z,musica_y_fadein

	CP   PANTALLA_BOSS
	CALL Z,pinta_boss
	;cuando salga de la pantalla del boss, cmabiar musica
	LD  HL,PANTALLA_ACTUAL
	LD  A,(HL)
	LD  HL,pantallas_efecto_parpadeo
	LD  b,0
	ld  c,(hl)
	inc hl
	cpir
	JR  Z,devuelve_efecto_parpadeo_pp
	;LD  HL,pantallas_efecto_penumbra
	LD  b,0
	ld  c,(hl)
	inc hl
	cpir
	JR  Z,devuelve_efecto_penumbra_pp
	;LD  HL,pantallas_efecto_nieve1
	LD  b,0
	ld  c,(hl)
	inc hl
	cpir
	JR  Z,devuelve_efecto_nieve1
	;LD  HL,pantallas_efecto_nieve2
	LD  b,0
	ld  c,(hl)
	inc hl
	cpir
	JR  Z,devuelve_efecto_nieve2
puede_ser_nieve_pp
	LD  A,EFECTO_SIN
aplico_efecto_pp
	LD  (EFECTO_TINTAS),A
	CALL aplica_efectos_tintas

	ld    hl,SEMAFORO_IA_PROTA
	LD    (HL),0
	inc   hl   ;semaforo_IA_DISPAROS
	LD    (HL),0
; 	inc   hl   ;semaforo_pausa
; 	LD    (HL),0

	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FF	;activo int de cfp por primera vez
				;luego de capturar buffers se pondrá a #00
	;una vez que disparo la captura de los bufferes,
	;en la Int5 activo el resto de interrupciones
	;así se produce en el orden correcto
	RET

musica_y_fadein
	LD	DE,SNG_MENU
	CALL	PLY_Init
	JP fadein

devuelve_efecto_penumbra_pp
	LD  A,(TABLA_OBJETOS+5)
	OR  A
	JR  Z,devuelve_sin_efecto_pp
	LD  A,EFECTO_PENUMBRA
	JR  aplico_efecto_pp
devuelve_efecto_parpadeo_pp
	LD  A,(TABLA_OBJETOS+5)
	OR  A
	JR  Z,devuelve_sin_efecto_pp
	LD  A,EFECTO_PARPADEO
	JR  aplico_efecto_pp
devuelve_efecto_nieve2
	LD   HL,PALETA0
	LD   DE,sm_border3
    CALL Cambia_Tintas_Zona
	LD   DE,sm_border2
    CALL    Cambia_Tintas_Zona
    XOR  A
    LD   (nieve_actual),A
    LD   A,EFECTO_NIEVE2
    JR   aplico_efecto_pp
devuelve_efecto_nieve1
	LD   HL,PALETA0
	LD   DE,sm_border2
    CALL    Cambia_Tintas_Zona
    XOR  A
    LD   (nieve_actual),A
    LD   A,EFECTO_NIEVE1
    JR   aplico_efecto_pp
devuelve_sin_efecto_pp
	LD  A,EFECTO_SIN
	JR  aplico_efecto_pp

comun_otro_statics
	LD	(IX+S_ID),A	;ID
	;LD	E,A
	LD	A,(HL)
	INC     HL
	LD	(IX+S_TIPO),A	;tipo
	LD	A,(HL)
	INC     HL
	LD	(IX+S_X),A	;X
	LD	C,A
	LD	A,(HL)
	INC     HL
	LD	(IX+S_Y),A	;Y
	LD	B,A
	LD	A,(HL)
	INC     HL
	LD	(IX+S_STILE),A
	LD	A,(HL)
	LD	E,A
	LD	(IX+S_STILE+1),A
	INC	HL
	LD	A,(HL)
	LD	(IX+S_CONS),A
	INC	HL
	LD	A,(HL)
	LD	(IX+S_CONS+1),A
	INC	HL
	LD	A,(HL)
	LD	(IX+S_TRIGGER),A
	INC	HL
	LD	A,(HL)
	LD	(IX+S_TRIGGER+1),A
	INC	HL
	LD	A,(HL)
	LD	(IX+S_TAG),A
	INC	HL
	push hl
	LD  A,(IX+S_ID)
	CALL Lee_Estado_Objeto_A
	OR   A
	CALL NZ,Ejecuta_Constructores_Statics
	pop  hl
	RET

Coge_Supersprites
	LD	(IX+_ID),B		;ID del sprite
	LD	A,(IY+0)
		LD	(IX+_Y),A
		LD	(IX+_ANTY),A
	LD	A,(IY+1)
		LD	(IX+_X),A
		LD	(IX+_ANTX),A
	LD	A,(IY+2)
		LD	(IX+_IDESP),A
		LD	(IX+_DESP),0
		LD	(IX+_ADESP),0
	LD	A,(IY+3)
		LD	(IX+_ICAD),A
		LD	(IX+_CAD),A
	LD	L,(IY+4)
	LD	H,(IY+5)
Coge_Supersprites_HL
	LD	A,(HL)
		AND	%11100000
		SRL     A
		SRL     A
		SRL     A
		SRL     A
		SRL     A
		LD	(IX+_ANCHO),A
	LD	A,(HL)
		AND	%00011111
		LD	(IX+_ALTO),A
	INC	HL
	LD	A,(HL)
		AND	%11110000
		SRL     A
		SRL     A
		SRL     A
		SRL     A
		LD	(IX+_SPR),A
		LD	(IX+_SPR_A),0

	LD	A,(HL)
		AND	%00001100
		SRL     A
		SRL     A
		LD	(IX+_MIRADA),A
		CP	IZQUIERDA
		JR	NZ,normal_CS
		LD	C,(IX+_IDESP)
		LD	(IX+_DESP),C
		LD	(IX+_ADESP),C
		LD	A,(IX+_X)
		ADD	A,C
		LD	(IX+_X),A
normal_CS
	INC     HL
	LD	A,(HL)
		AND	%11110000
		LD	(IX+_CHECKS),A
	LD	A,(HL)
		AND	%00001111
		LD	(IX+_VIDAS),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_DSPR),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_DSPR+1),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_UPD),A
	INC	HL
	LD	A,(HL)
		LD	(IX+_UPD+1),A
	LD      (IX+_DISP),0
	LD	A,(IX+_ANCHO)
	OR	A
	RET	Z			;si es un enemigo NULO no lo añado a la lista
	LD	A,B
	CALL	Actualiza_Tabla_INT_cfp
	CALL	Actualiza_Tabla_INT_UPD
	CALL	Actualiza_Tabla_INT_isp
	LD	A,(IX+_IDESP)
	LD	DE,(Buffer_actual)
	LD	(IX+_BUFF),E
	LD	(IX+_BUFF+1),D
	JP	Incrementa_Buffer

;;
;;Coge el STile A en las posiciones hasta encontrar 255
;;y manda pintarlo
;;
;;ENTRADA
;;E: STILE
;;SALIDA
;;Nada
;;destruye A,HL,BC
;;
Coge_Supertiles
	LD      C,(HL)		;en C las X del STile E
	INC	HL
	LD	A,(HL)		;en B las Y del STile E
	INC     HL
	PUSH	AF
	AND	%01111111
	LD	B,A
	PUSH    DE
	CALL	Pinta_Supertile		;pinto el STile E en BC
	POP     DE
	POP	AF
	AND	#80
	JR	Z,Coge_Supertiles
	RET

;; NZ-habia 
;; Z -no Habia
asigna_tile
	LD      A,B
	LD      HL,OFFSET_PANTALLA
	sub 	(HL)
	LD      HL,BUFFER
	LD      DE,ANCHO_MAPA_TILES
	LD      B,A
	OR      A
	JR      Z,fila_0_AD
posi_y_AD
	ADD     HL,DE
	DJNZ    posi_y_AD
fila_0_AD
	LD      B,0
    ADD     HL,BC
	LD      A,(HL)
	OR      A
	RET     NZ
	LD      (HL),255
	RET
;;BC:Coordenadas (Y,X)
asigna_durezas_objeto
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
; 	LD  D,A
; 	LD	A,(HL)
	;ancho
	LD  A,(HL)
	AND	%01110000
	RRA
	RRA
	RRA
	RRA
; 	INC A ;en vez de 3 inc a, pongo un add 3
	;amplio ancho para boundingbox ampliado de onjetos
	add 3	;uno más por cada lado
	dec c   ;empiezo antes
	EX	AF,AF'		;'
	;alto
	LD  A,(HL)
	AND	%00001111
	LD  D,A
	INC HL
	EX	AF,AF'   ;'
	;;A:ancho
	;;D:alto

alto_ado
	PUSH    DE
	push    bc
	push    af
ancho_ado
	PUSH	AF
	PUSH	BC
	LD    	A,(OFFSET_PANTALLA)
	LD    	D,A
	LD    	A,B
	CP    	ALTO_MAPA_TILES
	JR    	NC,no_tilees_ado
	CP    	D
	JR    	C,no_tilees_ado
	push  	bc
	push  	de
	LD      A,0
	EX      AF,AF'
	LD      E,#80
	CALL  	Asigna_Durezas
	pop   	de
	pop   	bc
no_tilees_ado
	POP   	BC
	inc   	C
	POP   	AF
	DEC   	A
	JR    	NZ,ancho_ado
	pop     af
	pop     bc
	inc   	B
	POP   	DE
	DEC   	D
	JR    	NZ,alto_ado
	RET


;;IX:statico
Imprime_fondo_stile
	CALL    Coge_Ancho_Alto_Stile
	EX      HL,DE
    LD      L,(IX+S_BUFFER)
    LD      H,(IX+S_BUFFER+1)
;     SRL     A
;     SRL     A
;     SRL     A
    LD      B,A
	;;DE: Dirpan
	;;HL: Buffer
	;;B : Alto
	;;A': Ancho
	JP   	imprime_zona_de_pantalla

;;ENTRADA
;;IX:statico
;;SALIDA
;;E:Ancho*2
;;D:Alto*8
Coge_Ancho_Alto_Stile
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
; 	LD  D,A
;	LD	A,(HL)
	;ancho
	LD  A,(HL)
	AND	%01110000
	RRA
	RRA
	RRA
	RRA
	INC A
	EX	AF,AF'		;'
	;alto
	LD  A,(HL)
	AND	%00001111
	INC HL
	;;A :ancho
	;;A':alto
    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+S_Y)
    SLA     L
    SLA     L
    SLA     L
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+S_X)
    SLA     C
    ADD     HL,BC
    SLA     A
    SLA     A
    SLA     A
    LD      D,A 			;alto
    EX      AF,AF'
    SLA     A
    LD      E,A 			;ancho
    EX      AF,AF'
    RET

;;IX:statico
Captura_fondo_stile
	CALL    Coge_Ancho_Alto_Stile
	;;E y A :Ancho*2  A'
	;;D y A':Alto*8   A
    PUSH    HL
    LD      HL,(Buffer_actual)
    LD      (IX+S_BUFFER),L
    LD      (IX+S_BUFFER+1),H
    PUSH    HL
    LD      B,E 			;ancho*2
    LD      E,D
    LD      D,0				;alto
suma_ancho_cfs
    ADD     HL,DE
    DJNZ    suma_ancho_cfs
    LD      (Buffer_actual),HL
    POP     DE 				;Buffer
    POP 	HL 				;DirPan
;     SRL     A
;     SRL     A
;     SRL     A
    LD      B,A
	;;DE: Buffer
	;;HL: Dirpan
	;;B : Alto
	;;A': Ancho
	JP   	captura_zona_stile

;;BC:Coordenadas (Y,X)
;;HL:objeto stile
borra_durezas_objeto
	LD  D,A
	LD	A,(HL)
	;ancho
	LD  A,(HL)
	AND	%01110000
	RRA
	RRA
	RRA
	RRA
; 	INC A ;en vez de 3 inc a, pongo un add 3
	;amplio ancho para boundingbox ampliado de onjetos
	add 3	;uno más por cada lado
	dec c   ;empiezo antes
	EX	AF,AF'		;'
	;alto
	LD  A,(HL)
	AND	%00001111
	LD  D,A
	INC HL
	EX	AF,AF'   ;'
	;;A:ancho
	;;D:alto

alto_bdo
	PUSH    DE
	push    bc
	push    af
ancho_bdo
	PUSH	AF
	PUSH	BC
	LD    	A,(OFFSET_PANTALLA)
	LD    	D,A
	LD    	A,B
	CP    	ALTO_MAPA_TILES
	JR    	NC,no_tilees_bdo
	CP    	D
	JR    	C,no_tilees_bdo
	push  	bc
	push  	de
	LD      A,0
	EX      AF,AF'
	LD      E,0
	CALL  	Asigna_Durezas
	pop   	de
	pop   	bc
no_tilees_bdo
	POP   	BC
	inc   	C
	POP   	AF
	DEC   	A
	JR    	NZ,ancho_bdo
	pop     af
	pop     bc
	inc   	B
	POP   	DE
	DEC   	D
	JR    	NZ,alto_bdo
	RET


;;
;;Asigna las durezas del mapa en BC
;;
;;ENTRADA
;;BC:Coordenadas (Y,X)
;;A':tile
;;E:tile u objeto?
;;SALIDA
;;Nada
;;destruye BC,HL,A
;;
Asigna_Durezas
	PUSH	DE
	LD      A,(OFFSET_PANTALLA)
	LD      E,A
	LD      A,B
	SUB     E
	LD      E,A
	LD      D,0
	;LD      B,10
	LD      HL,MAPA_DUREZAS
mul10_AD
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	ADD     HL,DE
	;DJNZ    mul10_AD
	XOR	A
	LD      E,C
	SRL     E
	RLA
	SRL     E
	RLA
	ADD     HL,DE           ;me posiciono en el byte a tocar
				;ahora toca cambiar los bits correspondientes
				;en A queda el resto para elegir la pareja de bits
	POP	DE
	EX	AF,AF'     ;'
	CP	DUREZAS_TOTAL
	JR	NC,durezas_total_ad
	CP	DUREZAS_MATAN
	JR	NC,durezas_matan_ad
	LD	B,BIT_VACIO
	JR	asigna_durezas_ad
durezas_total_ad
	LD	B,BIT_TOTAL
	JR	asigna_durezas_ad
durezas_matan_ad
	LD	B,BIT_MATAN
asigna_durezas_ad
	PUSH	AF
	LD	A,E
	AND	%10000000	;si en el juego de tiles del STILE lleva #80, es un objeto
	CP	#80
	JR	NZ,normal_AD
	LD	B,BIT_OBJETO
normal_AD
	POP	AF
	EX	AF,AF'    ;'
	LD	C,%11111100
;si el resto es 3 no muevo B
	CP	3
	JR	Z,fin_ad
	LD	C,%11110011
	SLA	B
	SLA	B
;si el resto es 2 muevo B dos veces
	CP	2
	JR	Z,fin_ad
	LD	C,%11001111
	SLA	B
	SLA	B
;si el resto es 1 muevo B cuatro veces
	CP	1
	JR	Z,fin_ad
	LD	C,%00111111
	SLA	B
	SLA	B
;si el resto es 0 muevo B seis veces
fin_ad
	LD	A,C		;si hay alguna dureza anterior la borro
	AND	(HL)		;por si hay dos stiles en el mismo sitio con distintas durezas
	OR	B		;añado la dureza actual
	LD	(HL),A		;lo guardo en el mapa
	RET


;;
;;Pinta en pantalla el STile E en BC (Y,X)
;;
;;ENTRADA
;;(OFFSET_PANTALLA)=offeset de inicio. A partir de esa posicion se imprimirán los tiles
;;E:STile
;;BC:Coordenadas (Y,X)
;;SALIDA
;;Nada
;;destruye A,A',DE
;;
Pinta_Supertile_HL
	push    hl
	jr      Pinta_Supertile1_HL
Pinta_Supertile
	PUSH	HL
	LD	HL,MAPA_STILES
	AND  	A
	LD	D,0
	;DEC	E		;resto 1 al stile para empezar desde 0
	RL	E
	RL  D
	ADD	HL,DE
	LD	E,(HL)
	INC  	HL
	LD   	D,(HL)
	EX   	HL,DE		;en HL tengo la direccion del STile
Pinta_Supertile1_HL
	;LD	 E,0
	LD      D,A
	LD	A,(HL)
	AND	%10000000	;cojo juego de tiles
	RLA
	RLA
	ADD	A,JUEGO_TILES_1
	;OR	 E		;si tiene el #80 es objeto
	LD	E,A		;juego de Tiles
	;ancho
	LD      A,(HL)
	AND	%01110000
	RRA
	RRA
	RRA
	RRA
	INC     A
	EX	AF,AF'		;'
	;alto
	LD      A,(HL)
	AND	%00001111
	LD      D,A
	INC     HL
	EX	AF,AF'   ;'
	;;A:ancho
	;;D:alto
	PUSH    AF
	PUSH    DE
alto_ps
	PUSH	AF
	PUSH	BC
ancho_ps
	PUSH  	AF
	LD    	A,(HL)		;tile
	EX    	AF,AF'      ;'
	PUSH  	HL
	PUSH  	BC
	PUSH  	DE
	LD    	A,(OFFSET_PANTALLA)
	LD    	D,A
	LD    	A,B
	CP    	ALTO_MAPA_TILES
	JR    	NC,no_tilees_ps
	CP    	D
	JR    	C,no_tilees_ps
	LD    	A,C
	CP    	ANCHO_MAPA_TILES
	JR    	NC,no_tilees_ps
	LD    	A,(CHECK_ASIGNA_DUREZAS)
	CP    	1
	JR      NZ,es_el_HUD
; 	PUSH    BC
; 	PUSH    DE
; 	PUSH    HL
; 	call    asigna_tile
; 	POP     HL
; 	POP     DE
; 	POP     BC
; 	jr      nz,no_tilees_ps
	push  	HL
	push  	bc
	push  	de
	CALL  	Asigna_Durezas
	pop   	de
	pop   	bc
	pop   	hl
es_el_HUD
	CALL  	write_tile_screen_YX
; 	jr      no_tilees_ps
; es_el_HUD
; 	CALL  	write_tile_screen_YX
no_tilees_ps
	POP   	DE
	POP   	BC
	POP   	HL
	inc   	c
	INC   	HL
	POP   	AF
	DEC   	A
	JR    	NZ,ancho_ps

	POP   	BC
	inc   	b
	POP   	AF
	DEC   	D
	JR    	NZ,alto_ps
	POP   	DE
	POP   	AF
	POP   	HL
	RET


;;Borra la zona del Mapa de Durezas
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye HL,BC,DE
;;
Borra_Mapa_Durezas
	LD	HL,MAPA_DUREZAS
	LD	DE,MAPA_DUREZAS+1
	LD	BC,ALTO_MAPA_TILES*ANCHO_MAPA_TILES/DIVBITS_DUREZAS-1
	LD	(HL),0
	LDIR
	RET


;;Borra la pantalla con el fondo
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye A,HL,DE,BC
;;
Borra_Pantalla_Completa
	LD		A,8
	LD      HL,sm_longpant+1
	LD      BC,1599+400
	LD      (HL),C
	inc     hl
	LD      (HL),B
	LD		HL,DIRECCION_JUEGO
	JR      bucle_bp
Borra_Pantalla
	LD		A,8
	LD      HL,sm_longpant+1
	LD      BC,1599
	LD      (HL),C
	inc     hl
	LD      (HL),B
	LD		HL,DIRECCION_JUEGO
	LD      BC,5*ANCHO_MAPA_BYTES
	ADD     HL,BC
bucle_bp
	LD   	D,H
	LD   	E,L
	INC  	DE
	LD   	(HL),BYTE_FONDO_PANTALLA
sm_longpant
	LD   	BC,1599
	PUSH 	HL
	LDIR                                    ; Vuelca la primera linea
	POP  	HL
	LD   	BC,#800
	ADD  	HL,BC
	DEC  	A					; Así hasta 8
	JR   	NZ,bucle_bp
	RET

;;
;;escribe un tile en pantalla
;;
;;ENTRADA
;;A' Tile
;;BC  Tile Coords (Y,X)
;;E  Juego de Tiles
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
write_tile_screen_YX
	PUSH	DE

    AND     A
	LD   	D,0
	LD      E,B		;cojo la Y en DE
	RL      E
	RL      D		;multiplico por 2 y luego por 8
	RL      E
	RL	D
	RL      E
	RL	D

    LD      H,TABLA_SCANLINES_H
    LD      L,E
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
	LD      D,0
	LD      E,C
	RL      E
	RL      D
    ADD     HL,DE

	POP	BC
	;LD	A,C
	;AND	%01111111
	LD	D,C
	; Get the tile address ($4000 + tile_number << 4)
	EX   	AF,AF'								; A' TILE
	SLA  	A
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	LD   	E,A                  ; HL Tile address
	;EX   	DE,HL                ; HL screen address
						 ; DE TILE address
	; 1º Scanline
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 2º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 4º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	RES  	3,H

	; 3º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	5,H

	; 7º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	RES  	4,H

	; 5º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 6º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 8º Scanline
	DEC  	L
	LD   	A,(DE)
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD   	(HL),A

	RET


fadeout
	LD	A,(sm_tinta0m+1)
	CP	#54
	RET	Z
	LD	HL,TINTAS_JUEGO
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO1
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO2
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO3
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO4
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_NEGRO
	JP		Cambia_Tintas_Todas
fadein
	LD	A,(sm_tinta0m+1)
	CP	#56
	RET	Z
	LD	HL,TINTAS_NEGRO
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO4
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO3
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO2
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO1
	CALL	Cambia_Tintas_Todas
	CALL	espera_mucho
	LD	HL,TINTAS_JUEGO
	JP		Cambia_Tintas_Todas

espera_mucho
	LD	BC,3825;7650
	JR	espera_mucho_SP
espera_mucho_80
	LD	BC,12750;25500
espera_mucho_SP
wait_emSP
	DEC	BC
	LD	A,B
	OR	C
	JR	NZ,wait_emSP
	RET

espera_mucho_TEC
	LD	B,30
espera_mucho_SP_TEC
	PUSH	BC
	LD	B,255
wait_TEC
	LD	A,(TECLADO0)
; 	LD	L,A
; 	LD  A,(TECLADO1)
	OR	A
	JR	NZ,salir1_TEC
	DJNZ	wait_TEC
	POP	BC
	DJNZ	espera_mucho_SP_TEC
salir_TEC
	LD	A,0
	LD	(Pulsa_Escape),A
	RET
salir1_TEC
	LD	A,(TECLADO0)
	BIT	KEY_ESCAPE,A
	JR	NZ,escape_act
	LD	A,0
	JR	seguir_act
escape_act
	LD	A,1
seguir_act
	LD	(Pulsa_Escape),A
	POP	BC
	RET

Activa_Color
	LD      A,E
	EX      AF,AF'
	LD      A,D
	LD	D,5
	SLA  	A
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	LD   	E,A                  ; HL Tile address
	PUSH    DE
	POP     IX
	EX      AF,AF'
	LD      E,A
	RET

;;BC: Y,X
;;HL: puntero a texto (acaba con 255)
Imprime_Texto
	CALL Activa_Color
bucle_IT
	LD	A,(HL)
	CP	#FF
	RET	Z
	cp  32
	jr  nz,no_cambio_espacio_IT
	ld  a,0
no_cambio_espacio_IT
	PUSH	HL
	EX	AF,AF'               ;A'
	PUSH	BC
	PUSH    DE
	CALL	write_tile_screen_YX_trans
	POP     DE
	POP	BC
	POP	HL
	INC 	C
	INC	HL
	JR	bucle_IT

; ;;BC- Y,X
; ;;HL- Puntero al texto
; ;;A-  Ancho Scroll
; Scroll_Texto_STEC
; 	PUSH	HL
; 	PUSH	AF
; 	LD	HL,espera_mucho_80
; 	LD	A,0
; 	JR	sigue_STST
; Scroll_texto
; 	PUSH	HL
; 	PUSH	AF
; 	LD	HL,espera_mucho_TEC
; 	LD	A,%11000000
; sigue_STST
; 	LD	(comprueba_teclado),A
; 	LD	(comprueba_teclado1),A
; 	LD	(comprueba_teclado3+1),HL
; 	LD	(comprueba_teclado4+1),HL
; 	POP	AF
; 	PUSH	BC
; 	LD	HL,Buffer_Scroll
; 	LD	(HL),T_ESPACIO
; 	LD	DE,Buffer_Scroll+1
; 	LD	BC,31
; 	LDIR
; 	POP	BC
; 	POP	HL
; scrolea_1_ST
; 	PUSH	HL
; 	PUSH    BC
; 	LD	HL,Buffer_Scroll+1
; 	LD	DE,Buffer_Scroll
; 	LD	BC,31
; 	LDIR
; 	POP	BC
; 	POP	HL
; 	EX	AF,AF'			;salvo el ancho en A'
; 	LD	A,(TECLADO0)
; 	LD	E,A
; 	LD      A,(TECLADO1)
; 	OR	E
; comprueba_teclado
; 	RET	NZ
; 	LD	A,(HL)
; 	CP	#FF
; 	JR	Z,fin_scroll0_ST
; 	LD	(Buffer_Scroll+31),A
; 	PUSH	HL
; 	PUSH    BC
; 	LD	HL,Buffer_Scroll
; 	EX	AF,AF'			;recupero el ancho de A'
; 	LD	B,A
; 	LD	C,A
; 	LD	A,31
; 	SUB	C
; 	LD	C,A
; 	LD	A,B
; 	LD	B,0
; 	ADD	HL,BC
; 	POP	BC
; 	PUSH	BC
; 	PUSH	AF
; 	CALL 	Imprime_Texto
; comprueba_teclado3
; 	CALL	espera_mucho_TEC
; 	CALL	wVb1
; 	POP	AF
; 	POP	BC
; 	POP	HL
; 	INC	HL
; 	JR      scrolea_1_ST
; fin_scroll0_ST
; 	EX	AF,AF'			;A'
; 	LD	D,A
; 	INC	D
; 	EX	AF,AF'			;A'
; fin_scroll_ST
; 	PUSH	DE
; 	LD	A,T_ESPACIO
; 	LD	(Buffer_Scroll+31),A
; 	PUSH    BC
; 	LD	HL,Buffer_Scroll
; 	EX	AF,AF'			;salvo el ancho en A'
; 	LD	B,A
; 	LD	C,A
; 	LD	A,31
; 	SUB	C
; 	LD	C,A
; 	LD	A,B
; 	LD	B,0
; 	ADD	HL,BC
; 	POP	BC
; 	PUSH	BC
; 	PUSH	AF
; 	CALL 	Imprime_Texto
; comprueba_teclado4
; 	CALL	espera_mucho_TEC
; 	CALL	wVb1
; 	POP	AF
; 	EX	AF,AF'            ;A'
; 	POP	BC
; 	PUSH    BC
; 	LD	HL,Buffer_Scroll+1
; 	LD	DE,Buffer_Scroll
; 	LD	BC,31
; 	LDIR
; 	POP	BC

; 	POP	DE

; 	LD	A,(TECLADO0)
; 	LD	L,A
; 	LD      A,(TECLADO1)
; 	OR	L
; comprueba_teclado1
; 	RET	NZ

; 	DEC	D

; 	RET	Z
; 	JR	fin_scroll_ST


Pinta_HUD_Input_Fin
	XOR     A
	LD    	(CHECK_ASIGNA_DUREZAS),A
 	LD      A,0
 	LD      (OFFSET_PANTALLA),A
	CALL    Pinta_HUD_Izqda
 	LD      A,18
 	LD      B,0
 	LD      C,2
 	CALL    Pinta_Relleno_HUD
 	LD      HL,TEXTO_PAUSA
 	LD		D,COLOR_MORADO ;MORADO
	LD		E,JUEGO_TILES_2
 	LD      BC,#010B
 	CALL    Imprime_Texto
 	LD      HL,TEXTO_CONTINUA
 	LD      (INPUT12),HL
 	LD      A,64
 	LD      (INPUT11),A
 	LD      HL,TEXTO_SALIR
 	LD      (INPUT22),HL
 	LD      A,0
 	LD      (INPUT21),A
imprime_texto_PHUDIF
	LD      BC,#0212
	LD      HL,INPUT11
	CALL    imprime_en_color_PHUDIF
	LD      BC,#0312
	LD      HL,INPUT21
	CALL    imprime_en_color_PHUDIF
espera_soltar_ESC
 	LD      A,(TECLADO0)
 	BIT     KEY_ESCAPE,A
 	JR      NZ,espera_soltar_ESC

espera_teclado_PHUDIF
 	LD      A,(TECLADO0)
 	BIT     JOY_UP,A
 	JR      NZ,sube_PHUDIF
 	BIT     JOY_DOWN,A
 	JR      NZ,baja_PHUDIF
 	BIT     JOY_FIRE1,A
 	JR      NZ,pulsa_PHUDIF
 	BIT     KEY_ESCAPE,A
 	JR      Z,espera_teclado_PHUDIF
 	LD      A,64
 	LD      (INPUT11),A
 	JR      pulsa_PHUDIF

sube_PHUDIF
baja_PHUDIF
	PUSH    AF

	push    hl
	push    de
	LD      A,FX_menu_opcion
	CALL    Toca_FX_Pos
	pop     de
	pop     hl

	LD      A,(INPUT11)
	LD      B,A
	LD      A,(INPUT21)
	LD      (INPUT11),A
	LD      A,B
	LD      (INPUT21),A
	POP     AF
	LD      B,A
suelta_tecla_PHUDIF
	LD      A,(TECLADO0)
	CP      B
	JR      Z,suelta_tecla_PHUDIF

	JR      imprime_texto_PHUDIF

pulsa_PHUDIF
	LD      A,FX_menu_esc
	CALL    Toca_FX_Pos
 	LD      A,5
 	LD      (OFFSET_PANTALLA),A
	RET

imprime_en_color_PHUDIF
	LD		A,(HL)
	CP      0
	JR      Z,color_rojo2_PHUDIF
	LD      D,COLOR_ROJO2
	LD      A,64
	JR      sigue_color_PHUDIF
color_rojo2_PHUDIF
	LD      D,COLOR_ROJO1
sigue_color_PHUDIF
	DEC     C
	EX      AF,AF'
	PUSH    BC
	PUSH    HL
	PUSH    DE
	CALL    write_tile_screen_YX
	POP     DE
	POP     HL
	POP     BC
	INC     C
	INC     HL
	LD      A,(HL)
	INC     HL
	LD      H,(HL)
	LD      L,A
	JP      Imprime_Texto


Espera_HUD_Tecla
	LD      HL,INPUT11
	LD      (HL),64
	INC     HL
	LD      (HL),0
bucle_EHT
	;parpadeo del triangulo
	LD      BC,#0326
	LD      A,(INPUT11)
	EX      AF,AF'
	LD		E,JUEGO_TILES_2
 	CALL    write_tile_screen_YX

 	LD      B,0
	LD      A,(Pas_Interrupcion)
	LD      HL,INPUT11+1
	CP      (HL)
	JR      Z,no_cambia_eht
	LD      (HL),A
	RRA
	RL      B
	RRA     
	RL      B
	RRA     
	RL      B
	LD      A,B
	OR      A
	JR      NZ,no_cambia_eht
	LD      HL,INPUT11
	LD      A,(HL)
	CP      64
	JR      Z,pon_32_eht
	LD      A,64
	JR      sigue_cambia_eht
pon_32_eht
	LD      A,0
sigue_cambia_eht
	LD      HL,INPUT11
	LD      (HL),A
no_cambia_eht

    LD      A,(TECLADO0)
    BIT     JOY_FIRE1,A
    JR      Z,bucle_EHT
suelta_eht
    LD      A,(TECLADO0)
    BIT     JOY_FIRE1,A
    JR      NZ,suelta_eht

    RET


Pinta_HUD_Texto
	XOR     A
	LD    	(CHECK_ASIGNA_DUREZAS),A
 	LD      A,0
 	LD      (OFFSET_PANTALLA),A
 	LD      A,17
 	LD      B,0
 	LD      C,5
 	PUSH    HL
 	CALL    Pinta_Relleno_HUD
 	POP     HL
 	LD		D,COLOR_ROJO2 ;rojo 1
 	CALL    Pinta_texto_en_HUD
 	LD      A,5
 	LD      (OFFSET_PANTALLA),A
 	RET

Pinta_texto_en_HUD
	LD      A,D
	LD	D,5
	SLA  	A
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	LD   	E,A                  ; HL Tile address
	PUSH    DE
	POP     IX

	LD      B,1
	LD      C,5
bucle_PTH
	LD      A,(HL)
	CP      255
	RET     Z
	CP      0
	JR      Z,salta_linea_PTH
	cp      32
	jr      nz,no_es_espacio_PTH
	ld      a,0
no_es_espacio_PTH
	LD		E,JUEGO_TILES_2
	PUSH    BC
	PUSH    HL
	push    af
	EX      AF,AF'
	CALL    write_tile_screen_YX_trans
	pop     af
	or      a
	jr      z,no_sound_PTH
	;push    de
	ld      b,55
	ld      c,58
	CALL    random_b_c
	LD      E,A
	ld      A,0
	ld      L,11
	CALL    Toca_FX_Alea
	;pop     de
no_sound_PTH
	POP     HL

	ld      a,(hl)
	cp      "."
	JR      Z,no_es_texto_PTH
	cp      ":"
	JR      Z,no_es_texto_PTH
	cp      ","
	JR      Z,no_es_texto_PTH
	cp      "!"
	JR      Z,no_es_texto_PTH
	cp      "?"
	JR      NZ,es_texto_PTH
no_es_texto_PTH
	ld      b,25
	Jr 		pinta_texto_PTH
es_texto_PTH
	ld      b,2
pinta_texto_PTH
	push    bc
	CALL    wVb
	pop     bc
	djnz    pinta_texto_PTH

	POP     BC
	INC     HL
	INC     C
	JR      bucle_PTH
salta_linea_PTH
	INC     B
	LD      C,5

	INC     HL
	JR      bucle_PTH

Pinta_HUD_Juego
	XOR     A
	LD    	(CHECK_ASIGNA_DUREZAS),A
;  	LD      A,0
 	LD      (OFFSET_PANTALLA),A
	CALL    Pinta_HUD_Izqda
	CALL    Pinta_HUD_Centro
	CALL    Pinta_HUD_Der
	CALL    Pinta_HUD_Textos
	CALL    Pinta_HUD_Sprite
	LD      A,(SPRITE0_VIDAS)
	LD      B,A
	CALL    Pinta_HUD_vida
    LD   B,1
    LD   C,36
	LD	 HL,(TEMP_OBJETO)
	LD   A,H
	OR   L
	CALL NZ,Pinta_Supertile_HL

	;pinta el Hscore
	LD   	IY,#011E
	CALL    pinta_high_score_sin_verificar
 	LD      IY,#011f
 	LD      D,COLOR_MORADO
 	CALL    Activa_Color
 	CALL    pinta_ceros_derecha_sin_color

 	LD      A,5
 	LD      (OFFSET_PANTALLA),A
 	RET

Pinta_Relleno_HUD
	LD      HL,dstile_hud_relleno
	PUSH    AF
	PUSH    BC
	CALL    Pinta_Supertile_HL
	POP     BC
	POP     AF
	INC     C
	INC     C
	DEC     A
	JR      NZ,Pinta_Relleno_HUD
	RET

Pinta_HUD_Izqda
	LD      HL,dstile_hud_izq
	LD      B,0
	LD      C,0
	JP      Pinta_Supertile_HL

Pinta_HUD_Centro
	LD      A,7
	LD      C,2
	LD      B,0
	CALL    Pinta_Relleno_HUD
	LD      HL,dstile_hud_centro
	PUSH    BC
	CALL    Pinta_Supertile_HL
	POP     BC
	INC     C
	INC     C
	LD      A,8
	LD      B,0
	CALL    Pinta_Relleno_HUD
	LD      HL,dstile_hud_centro
	PUSH    BC
	CALL    Pinta_Supertile_HL
	POP     BC
	INC     C
	INC     C 			;#0024
Pinta_HUD_Centro_Der
	LD      HL,dstile_hud_relleno
	JP      Pinta_Supertile_HL

Pinta_HUD_Der
	LD      B,0
	LD      C,38
	LD      HL,dstile_hud_derecha
	JP      Pinta_Supertile_HL

Pinta_HUD_Textos
 	LD      HL,TEXTO_SALUD
 	LD		D,COLOR_MORADO ;MORADO 
	LD		E,JUEGO_TILES_2
 	LD      BC,#0105
 	CALL    Imprime_Texto
 	LD      HL,TEXTO_HSCORE
 	LD		D,COLOR_MORADO ;MORADO 
	LD		E,JUEGO_TILES_2
 	LD      BC,#0112
 	CALL    Imprime_Texto
 	LD      HL,TEXTO_SCORE
 	LD		D,COLOR_ROJO1 ;rojo 1
	LD		E,JUEGO_TILES_2
 	LD      BC,#0215
 	CALL    Imprime_Texto
	LD   	IY,#021F
	CALL    pinta_ceros_derecha
 	LD      HL,(SCORE)
; 	INC     HL
; 	LD      (SCORE_A),HL
	LD   	IY,#021E
	JP 		pinta_puntos_sin_verificar

Pinta_texto_Menu
	LD   HL,TEXTO_BESTSCORE
	LD   D,COLOR_VERDE
	LD   E,JUEGO_TILES_2
	LD   BC,#060B
	CALL Imprime_Texto
	LD   IY,#061a
	LD   D,COLOR_VERDE
	CALL Pinta_High_Score_sin_verificar_y_sin_color
	LD   IY,#061b
	LD   D,COLOR_VERDE
	CALL Activa_Color
	CALL pinta_ceros_derecha_sin_color
	LD   BC,#070B
	LD   HL,TEXTO_LASTSCORE
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	CALL Imprime_Texto
	LD   HL,(SCORE)
	INC  HL
	LD   (SCORE_A),HL
	LD   IY,#071a
	CALL pinta_puntos
	LD   IY,#071b
	CALL pinta_ceros_derecha
	LD   HL,TEXTO_PRESSPLAY
	LD   D,COLOR_ROJO2
	LD   E,JUEGO_TILES_2
	LD   BC,#0a0B
	CALL Imprime_Texto
	LD   HL,TEXTO_COPYR
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#140a			;copyright
	CALL Imprime_Texto
	LD   HL,TEXTO_CODE
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#0c05
	CALL Imprime_Texto
	LD   HL,TEXTO_JGNAVARRO
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	LD   BC,#0d04
	CALL Imprime_Texto
	LD   HL,TEXTO_GFX
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#0c10
	CALL Imprime_Texto
	LD   HL,TEXTO_AZICUETAN
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	LD   BC,#0d10
	CALL Imprime_Texto
	LD   HL,TEXTO_MUSICA
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#0c1e
	CALL Imprime_Texto
	LD   HL,TEXTO_MCKLAIN
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	LD   BC,#0d1d
	CALL Imprime_Texto
	LD   HL,TEXTO_TESTING
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#0f11
	CALL Imprime_Texto
	LD   HL,TEXTO_TESTING1
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#1003
	CALL Imprime_Texto
	LD   HL,dstile_estrella
	LD   BC,#001d
	JP   Pinta_Supertile_HL

Pinta_HUD_Sprite
	LD  HL,SPRITE0
	LD  DE,SPRITE_BCK
	LD  BC,30
	LDIR

	LD	IX,SPRITE0
	LD	BC,#0803		;posición (y,x)=(0,8)
	LD	HL,DSPR_PROTA_DISPARO_V	;posición del sprite
	LD	DE,#0618		;ancho y alto
	LD	A,0			;número de sprites
	EX	AF,AF'  ;'
	LD	A,0			;ID del sprite
	EXX
	LD	HL,Update_Prota		;rutina de UPDATE del prota
	LD	D,IZQUIERDA
	LD	E,#FF			;no captura buffer de fondo
	LD	B,#FF
	LD      (IX+_VIDAS),10
	CALL	Inicializa_Sprite

    LD      A,#FD
    LD      (SEMAFORO_SPR_INT),A
espera_FE
    LD      A,(SEMAFORO_SPR_INT)
    CP      #FD
    JR      Z,espera_FE

	LD  HL,SPRITE_BCK
	LD  DE,SPRITE0
	LD  BC,30
	LDIR

 	RET

Pinta_High_Score
	LD      HL,(SCORE)
	PUSH    HL
	POP     BC
	LD      HL,(HIGH_SCORE)
	XOR     A
	SBC     HL,BC
	RET     NC
	LD      HL,(SCORE)
	LD      (HIGH_SCORE),HL
Pinta_High_Score_sin_verificar
	LD      D,COLOR_MORADO
Pinta_High_Score_sin_verificar_y_sin_color
	LD      HL,(HIGH_SCORE)
	CALL    Activa_Color
	JR      sin_color_PPuntos
;en IY paso las coordenadas
Pinta_Puntos
	LD      HL,(SCORE_A)
	PUSH    HL
	POP     BC
	LD      HL,(SCORE)
	XOR     A
	SBC     HL,BC
	RET     Z
ha_cambiado_PPu
  	LD   HL,(SCORE)
  	LD   (SCORE_A),HL
pinta_puntos_sin_verificar
	LD      D,COLOR_ROJO1
	CALL Activa_Color
sin_color_PPuntos
	LD   C,L
	LD   B,H
	LD   D,0
	LD   E,10
	CALL div_bc_de

	PUSH BC
	
	LD   A,L
	ADD  A,CORRECTOR_NUMEROS
	EX   AF,AF'
	;LD   BC,#021E
	LD   B,IYH
	LD   C,IYL
	DEC  IYL
	LD   E,JUEGO_TILES_2
	CALL write_tile_screen_YX_trans  ;unidades
	
	POP  BC
	LD   D,0
	LD   E,10
	CALL div_bc_de
	
  	PUSH BC
  
	LD   A,L
	ADD  A,CORRECTOR_NUMEROS
	EX   AF,AF'
	;LD   BC,#021D
	LD   B,IYH
	LD   C,IYL
	DEC  IYL
	LD   E,JUEGO_TILES_2
	CALL write_tile_screen_YX_trans  ;decenas
  
	POP  BC
	LD   D,0
	LD   E,10
	CALL div_bc_de
	
	PUSH BC
  
	LD   A,L
	ADD  A,CORRECTOR_NUMEROS
	EX   AF,AF'
	;LD   BC,#021C
	LD   B,IYH
	LD   C,IYL
	DEC  IYL
	LD   E,JUEGO_TILES_2
	CALL write_tile_screen_YX_trans  ;centenas
	POP  BC
	LD   D,0
	LD   E,10
	CALL div_bc_de
	
 
	LD   A,L
	ADD  A,CORRECTOR_NUMEROS
	EX   AF,AF'
	;LD   BC,#021B
	LD   B,IYH
	LD   C,IYL
	LD   E,JUEGO_TILES_2
	JP   write_tile_screen_YX_trans  ;millares

;en IY paso las coordenadas
pinta_ceros_derecha
	LD   D,COLOR_ROJO1
	CALL Activa_Color
pinta_ceros_derecha_sin_color
	XOR  A
	ADD  A,CORRECTOR_NUMEROS
	EX   AF,AF'
	;LD   BC,#021F
	LD   B,IYH
	LD   C,IYL
	INC  IYL
	LD   E,JUEGO_TILES_2
	CALL write_tile_screen_YX_trans  ;0

	XOR  A
	ADD  A,CORRECTOR_NUMEROS
	EX   AF,AF'
	;LD   BC,#0220
	LD   B,IYH
	LD   C,IYL
	LD   E,JUEGO_TILES_2
	JP 	 write_tile_screen_YX_trans  ;0

;Entrada
;B- numero de vidas de la barra
Pinta_HUD_vida
	LD      HL,Barra_vida
	LD      E,B
	LD      D,0
	DEC     E
	ADD     HL,DE
	push    bc
otra_barra_pv
	PUSH    BC
	LD      A,(HL)
	EX      AF,AF'
	LD      A,4
	ADD     B
	LD      C,A
	LD      B,2
	LD      E,JUEGO_TILES_2
	PUSH    HL
	PUSH    BC
	CALL    write_tile_screen_YX
	POP     BC
	POP     HL
	LD      A,(HL)
	ADD     INC_BARRA
	EX      AF,AF'
	LD      B,3
	LD      E,JUEGO_TILES_2
	PUSH    HL
	CALL    write_tile_screen_YX
	POP     HL
	DEC     HL
	POP     BC
	DJNZ    otra_barra_pv
	pop     bc
	ld      a,10
	sub     b
	ret     z
	ld      b,a
barra_azul_phv
	push    bc
	ld      a,15
	sub     b
	ld      c,a
	ld      b,2
	call    pinta_barra_azul_vida_dv
	pop     bc
	djnz    barra_azul_phv
	RET

Decrementa_vida
	DEC     (IX+_VIDAS)
	LD      HL,Barra_vida
	LD      B,0
	LD      C,(IX+_VIDAS)
	ADD     HL,BC
	LD      A,5
	ADD     C
	LD      C,A
	LD      B,2
pinta_barra_azul_vida_dv
	LD      a,15
	EX      AF,AF'
	LD      E,JUEGO_TILES_2
	PUSH    BC
	CALL    write_tile_screen_YX
	POP     BC
	INC     B
	LD      a,15+INC_BARRA
	EX      AF,AF'
	LD      E,JUEGO_TILES_2
	JP      write_tile_screen_YX
;;
;;escribe un tile en pantalla
;;
;;ENTRADA
;;A' Tile
;;BC  Tile Coords (Y,X)
;;E  Juego de Tiles
;;SALIDA
;;Nada
;;destruye A,A',HL,BC,DE
;;
write_tile_screen_YX_trans
	PUSH	DE
    ;LD      B,(IX+_ANTY)
    ;LD      C,(IX+_ANTX)

	LD   	D,0
	LD      E,B		;cojo la Y en DE
	RL      E
	RL      D		;multiplico por 2 y luego por 8
	RL      E
	RL	D
	RL      E
	RL	D
; 	RL      E
; 	RL	D

    LD      H,TABLA_SCANLINES_H
    LD      L,E
    ;LD      D,0
    ;AND     A
    ;RL      B
    ;RL      D
    ;LD      E,B
    ;ADD     HL,DE   ;posiciona en y
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    ;LD      C,(IX+_ANTX)
	LD      D,0
	LD      E,C
	RL      E
	RL      D
    ADD     HL,DE

; 	LD	HL,TABLA_SCANLINES
; 	AND  	A
; 	LD   	D,0
; 	LD      E,B		;cojo la Y en DE
; 	RL      E
; 	RL      D		;multiplico por 2 y luego por 8
; 	RL      E
; 	RL	D
; 	RL      E
; 	RL	D
; 	RL      E
; 	RL	D
; 	ADD  	HL,DE
; 	LD   	A,(HL)
; 	LD      D,0
; 	LD      E,C
; 	RL      E
; 	RL      D
; 	INC  	HL
; 	LD   	H,(HL)
; 	LD   	L,A
; 	ADD     HL,DE
;	EX      DE,HL
	POP	BC
	;LD	A,C
	;AND	%01111111
	LD	D,C
	; Get the tile address ($4000 + tile_number << 4)
	EX   	AF,AF'								; A' TILE
	SLA  	A
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	RLA
	RL   	D
	LD   	E,A             ; HL Tile address
	;EX   	DE,HL           ; HL screen address
				; DE TILE address


	LD      B,TABLA_MASCARASH
	; 1º Scanline
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+0)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+1)
	OR      C
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 2º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+2)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+3)
	OR      C
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 4º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+4)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+5)
	OR      C
	INC  	DE
	LD   	(HL),A
	RES  	3,H

	; 3º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+6)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+7)
	OR      C
	INC  	DE
	LD   	(HL),A
	SET  	5,H

	; 7º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+8)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+9)
	OR      C
	INC  	DE
	LD   	(HL),A
	RES  	4,H

	; 5º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+10)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+11)
	OR      C
	INC  	DE
	LD   	(HL),A
	SET  	3,H

	; 6º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+12)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+13)
	OR      C
	INC  	DE
	LD   	(HL),A
	SET  	4,H

	; 8º Scanline
	DEC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+14)
	OR      C
	INC  	DE
	LD   	(HL),A
	INC  	L
	LD   	A,(DE)
	LD      C,A
	LD      A,(BC)
	AND     (IX+15)
	OR      C
	INC  	DE
	LD   	(HL),A

	RET

aplica_efectos_tintas
	LD     A,(EFECTO_TINTAS)
	CP     EFECTO_PENUMBRA
	JR     NZ,no_es_penumbra_aet
	;aplica tintas penumbra
	LD     HL,TINTAS_PENUMBRA
	JP     Cambia_Tintas_Juego
no_es_penumbra_aet
	CP     EFECTO_PARPADEO
	JR     NZ,no_es_parpadeo_aet
	;se inicializan los valores del parpadeo
	jp     inicializa_parpadeo
no_es_parpadeo_aet
	RET

inicializa_parpadeo
	LD     HL,TINTAS_JUEGO
	CALL   Cambia_Tintas_Juego
	LD     A,1
	LD     (SEMAFORO_PARPADEO),A
	call   random
	ld     b,0
	ld     c,a
	call   random
	ld     h,0
	ld     l,a
	add    hl,bc
	ld     bc,250
	add    hl,bc
	ld     (siguiente_parpadeo),hl
	ret