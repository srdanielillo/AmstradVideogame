Ejecuta_Constructores_Statics
	LD	 A,(IX+S_ID)
	CP	 #FF
	RET	 Z
	LD	 l,(IX+S_CONS)
	LD	 h,(IX+S_CONS+1)
sm_ECS
	JP	 (hl)

Ejecuta_Triggers_Statics
	LD	A,(IY+S_ID)
	CP	#FF
	RET	Z
	LD	l,(IY+S_TRIGGER)
	LD	h,(IY+S_TRIGGER+1)
sm_ETS
	JP	(hl)

Objeto_Texto_Cons
Objeto_Coger_Cons
;;BC:Coordenadas (Y,X)
;;A':tile
;;E:tile u objeto?
    LD   B,(IX+S_y)
    LD   C,(IX+S_X)
	CALL asigna_durezas_objeto
	LD  A,(IX+S_TIPO)
	CP  STA_TEXTO
	RET Z
	CP  STA_LLAVEINV
	RET Z
	;Captura_fondo_de_pantalla
	CALL Captura_fondo_stile
	XOR A
	LD  (CHECK_ASIGNA_DUREZAS),a
    LD  B,(IX+S_Y)
    LD  C,(IX+S_X)
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	JP	Pinta_Supertile_HL

Objeto_Nulo_Trigger
Objeto_Nulo_Cons
	RET

Objeto_Puerta_Cons
	CALL Captura_fondo_stile
	LD  A,1
	LD  (CHECK_ASIGNA_DUREZAS),a
    LD  B,(IX+S_Y)
    LD  C,(IX+S_X)
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	JP	Pinta_Supertile_HL

Objeto_Puerta_Trigger
	LD   A,(IY+S_ID)
	cp   2 ;
	JR   NZ,mira_otro_OPT
	;si ya tengo llenos los depositos abro la puerta
	LD   A,(TABLA_OBJETOS+5)
	OR   A
	JR   Z,abro_puerta6

	LD   HL,TEXTO_2
	JP   pinta_texto_OTT_sin_desactivar
abro_puerta6
	ld   a,6
	ld   (sm_puerta+1),a
abro_puertann
	push iy
	pop  IX 		;;hay que pasar IX a la rutina :(
	CALL Imprime_fondo_stile

sm_puerta
	LD   A,6
	CALL scroll_puerta

	LD   A,(IY+S_ID)
	CALL Desactiva_Objeto_A

    LD  B,(IY+S_Y)
    LD  C,(IY+S_X)
	LD	L,(Iy+S_STILE)
	LD	H,(Iy+S_STILE+1)
	JP  borra_durezas_objeto
mira_otro_OPT1
	CP   17
	JR   nz,mira_otro_OPT2
	LD   a,8
	ld   (sm_puerta+1),a
	LD   A,(TABLA_OBJETOS+8) ;si no esta abierta la abro
	OR   A
	jr   NZ,sm_puerta
mira_otro_OPT2
	RET

mira_otro_OPT
	cp   15 		;valvulaR
	jr   nz,mira_otro_OPT1
	LD   A,(TABLA_OBJETOS+14)		;si tengo la valvulaB cogida y dejada en valvulaR
	OR   A
	JR   Z,abro_puerta13
	LD   HL,TEXTO_3
	JP   pinta_texto_OTT_sin_desactivar
abro_puerta13
	ld   a,13
	ld   (sm_puerta+1),a
	jr   abro_puertann

Objeto_Vida_Trigger
	PUSH IX
	PUSH IY
	POP  IX
	LD   A,(IX+S_ID)
	CALL Desactiva_Objeto_A
	;borro durezas
    LD  B,(IX+S_Y)
    LD  C,(IX+S_X)
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL borra_durezas_objeto

; 	LD  A,(IX+S_TIPO)
; 	CP  STA_LLAVEINV
; 	JR  Z,salir_oct
	;ahora borrar con el fondo
	CALL Imprime_fondo_stile
	POP  IX
truco_vida
	LD   A,FX_coger_objeto
	CALL Toca_FX_Pos
	LD   HL,SPRITE0_VIDAS
	LD   (HL),10
	LD   B,10
	JP   Pinta_HUD_vida

Objeto_CogerPV_Trigger
	PUSH IX
	PUSH IY
	POP  IX
	LD   A,(IX+S_ID)
	CALL Desactiva_Objeto_A
	;borro durezas
    LD  B,(IX+S_Y)
    LD  C,(IX+S_X)
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL borra_durezas_objeto

; 	LD  A,(IX+S_TIPO)
; 	CP  STA_LLAVEINV
; 	JR  Z,salir_oct
	;ahora borrar con el fondo
	CALL Imprime_fondo_stile
	POP  IX
	LD   A,FX_coger_objeto
	JP   Toca_FX_Pos

Objeto_Coger_Trigger
	;desactivo el objeto
	PUSH IX
	PUSH IY
	POP  IX

	LD   A,(IX+S_ID)
	CP   5 	;depositos de gasolina
	JR   z,mira_la_gasolina
	CP   14 ;valvula rota
	JR   NZ,sigue_oct
	LD   A,(TABLA_OBJETOS+11)
	OR   A
	JR   NZ,salir_oct
	JR   sigue_oct_rea
mira_la_gasolina
	LD   A,(TABLA_OBJETOS+3)
	OR   A
	JR   NZ,salir_oct
	;continua solo si tenemos la lata de gasolina cogida
	;ejecuta recuperación de energía
	LD   A,EFECTO_RECUPERA
	LD   (EFECTO_TINTAS),A
	LD   A,2	;Para que empiece inmediatamente
	LD   (SEMAFORO_PARPADEO),A
    LD   HL,50
    ld   (siguiente_parpadeo),HL
sigue_oct_rea
	;borra HUD
	XOR  A
	LD   (CHECK_ASIGNA_DUREZAS),a
	LD   (OFFSET_PANTALLA),A
    LD   BC,#0024
   	LD   (TEMP_OBJETO),A
   	LD   (TEMP_OBJETO+1),A
    CALL Pinta_HUD_Centro_Der
sigue_oct
	LD   A,FX_usar_objeto
	CALL Toca_FX_Pos
	LD   A,(IX+S_ID)
	CALL Desactiva_Objeto_A
	;borro durezas
	LD   A,5
	LD   (OFFSET_PANTALLA),A
    LD  B,(IX+S_Y)
    LD  C,(IX+S_X)
	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	CALL borra_durezas_objeto

	LD  A,(IX+S_TIPO)
	CP  STA_LLAVEINV
	JR  Z,salir_oct
	;ahora borrar con el fondo
	CALL Imprime_fondo_stile
	LD  A,(IX+S_TIPO)
	CP  STA_LLAVE
	JR  Z,salir_oct
	;imprime llave en HUD
	XOR  A
	LD   (CHECK_ASIGNA_DUREZAS),a
	LD   (OFFSET_PANTALLA),A
    LD   B,1
    LD   C,36
	LD	 L,(IX+S_STILE)
	LD	 H,(IX+S_STILE+1)
	LD   (TEMP_OBJETO),HL
	CALL Pinta_Supertile_HL
salir_oct
	LD   A,5
	LD   (OFFSET_PANTALLA),A
	POP  IX
	RET

Objeto_Texto_Trigger
	LD   A,(IY+S_TAG)
	CP   1
	JR   NZ,mira_otro2_OTT
	LD   HL,TEXTO_1
	JR   pinta_texto_OTT
mira_otro2_OTT
	CP   16
	JR   NZ,mira_otro3_OTT
	LD   A,(TABLA_OBJETOS+8)
	OR   A
	;si la puerta ya esta abierta, solo dejo pasar
	JR   Z,desactiva_durezas_texto_solo
	LD   HL,TEXTO_4
	JR   pinta_texto_OTT
mira_otro3_OTT
	CP   18
	RET  NZ
	LD   HL,TEXTO_5
	JR   pinta_texto_OTT_doble
	
desactiva_durezas_texto_solo
    LD  B,(IY+S_Y)
    LD  C,(IY+S_X)
    push hl
	LD	L,(Iy+S_STILE)
	LD	H,(Iy+S_STILE+1)
	CALL borra_durezas_objeto
	pop  hl
	RET

pinta_texto_OTT_doble
	LD   A,(IY+S_ID)
	CALL Desactiva_Objeto_A

    LD      A,#FE
    LD      (SEMAFORO_SPR_INT),A

; 	LD  A,5
; 	LD  (OFFSET_PANTALLA),A
	CALL desactiva_durezas_texto_solo

	LD   (IY+S_ID),#FF

	CALL Pinta_HUD_Texto

	PUSH HL

	CALL Espera_HUD_Tecla

	POP  HL
	inc  hl

	CALL Pinta_HUD_Texto

	CALL Espera_HUD_Tecla

	CALL Pinta_HUD_Juego

	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#ff	;activo int de cfp

	JP  activa_enemigos_boss

pinta_texto_OTT
	LD   A,(IY+S_ID)
	CALL Desactiva_Objeto_A

pinta_texto_OTT_sin_desactivar
;     LD      A,#FE
;     LD      (SEMAFORO_SPR_INT),A

; 	LD  A,5
; 	LD  (OFFSET_PANTALLA),A
	CALL desactiva_durezas_texto_solo

	LD   (IY+S_ID),#FF

pinta_texto_OTT_sin_interactuar
    LD      A,#FE
    LD      (SEMAFORO_SPR_INT),A

	CALL Pinta_HUD_Texto

	CALL Espera_HUD_Tecla

	CALL Pinta_HUD_Juego


	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#00	;activo int de cfp
	RET

Lee_Estado_Objeto_A
	PUSH	HL
	PUSH	BC
    LD	C,A
    LD	B,0
    LD	HL,TABLA_OBJETOS
	ADD	HL,BC
	LD	A,(HL)
	POP	BC
	POP	HL
	RET

Desactiva_Objeto_A
	PUSH HL
    LD	 C,A
    LD	 B,0
    LD	 HL,TABLA_OBJETOS
	ADD	 HL,BC
	LD	 (HL),0
	POP  HL
	RET

Scroll_Puerta
	push ix
	push af
	LD      a,FX_abre_puerta
	CALL    Toca_FX_Pos
	pop  af

	LD   IX,STATIC0
	ld   b,(IX+S_ID)
    CP   b
    JR   Z,era_STATIC0_SP
	LD   IX,STATIC1
	ld   b,(IX+S_ID)
    CP   b
    JR   Z,era_STATIC1_SP
	LD   IX,STATIC2
	ld   b,(IX+S_ID)
    CP   b
    JR   Z,era_STATIC2_SP
	LD   IX,STATIC3
era_STATIC0_SP
era_STATIC1_SP
era_STATIC2_SP
	CALL Desactiva_Objeto_A

    LD  B,(Ix+S_Y)
    LD  C,(Ix+S_X)
	LD	L,(Ix+S_STILE)
	LD	H,(Ix+S_STILE+1)
	CALL borra_durezas_objeto

    LD      A,#FE
    LD      (SEMAFORO_SPR_INT),A

	LD	L,(IX+S_STILE)
	LD	H,(IX+S_STILE+1)
	;ancho
	LD	A,(IX+S_TAG)
	LD	E,A
	SLA	E
	;alto
	LD      A,(HL)
	AND	%00001111
	LD      D,A
	SLA	D
	SLA	D
	SLA	D
	DEC	D

;entro con HL'-Buffer D'-Alto E'-Ancho
otro_mas_SP
	PUSH	DE
	;capturo el inicio del buffer
	LD      L,(IX+S_BUFFER)
	LD      H,(IX+S_BUFFER+1)
	EXX	;cambio a ppal

	call wVb

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+S_Y)
    sla l
    sla l
    sla l
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+S_X)
    sla     c
    ADD     HL,BC
    EX      HL,DE

otro_alto_SP
	LD	L,E
	LD	H,D
	LD	BC,#800
	ADD	HL,BC
	JR      NC,siguiente_scanline_SP
	LD      BC,#C050
	ADD     HL,BC
siguiente_scanline_SP
	EXX	;cambio a alternativo
	LD	A,E		;ancho
	EXX ;cambio a ppal
	LD	C,A
	LD	B,0
	PUSH	HL
	LDIR
	POP		DE
	EXX	;cambio a alternativo
	LD  C,E
	LD  B,0
	ADD HL,BC  ;incremento el buffer
	DEC	D
	EXX	;cambio a ppal
	JR	NZ,otro_alto_SP
	
	;ahora elimino la ultima linea con el buffer
	EXX ;cambio a alternativo
	LD  A,L
	EX  AF,AF'
	LD  A,H
	EXX ;cambio a ppal
	LD	H,A
	EX  AF,AF'
	LD	L,A
	EXX	;cambio a alternativo
	LD	A,E
	EXX ;cambio a ppal
	LD	C,A
	LD	B,0
	LDIR

	EXX	;cambio a Alternativo
	POP	DE

	DEC	D
	JP	NZ,otro_mas_SP

; 	PUSH IX
; 	POP	 IY 

	;CALL Quitar_Durezas_Static

	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#00	;activo int de cfp
	pop ix
	RET
