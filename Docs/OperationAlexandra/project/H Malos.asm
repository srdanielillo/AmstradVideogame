C_DISPARO_PULPO	 EQU	18*6
C_INC_DISP_PULPO EQU    18*2

Update_Pulpo_Parar_Px
	LD      A,(IX+_VIDAS)
	OR      A
	JR      Z,Vuelve_a_mover_pulpo
	LD      A,(IX+_DISP)
	OR      A
	JR      Z,Vuelve_a_mover_pulpo
	CP      25
	CALL    Z,inicia_disparo_Malo
	DEC     (IX+_DISP)
	LD      A,(IX+_ICAD)
	LD      (IX+_CAD),A
	JR      Update_Pulpo_sin_disp_Px
	;JP      salir2_UMP
Vuelve_a_mover_pulpo
	SET     CHECK_DISPARA,(IX+_CHECKS)
	LD      b,100
	ld      c,150
	CALL    Random_B_C
	LD      (IX+_DISP),A
	LD      HL,Update_Pulpo_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	JR      Update_Pulpo_sin_disp_Px

;Update ini de la cabeza del pulpo
Update_Pulpo_Ini_Px
	;update la cabeza del pulpo
	LD      b,100
	ld      c,150
	CALL    Random_B_C
	LD      (IX+_DISP),A
	LD      HL,Update_Pulpo_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	;hay que ponerlo abierto y nivel facil para que le pueda matar el disparo
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	RES     CHECK_NIVEL,(IX+_CHECKS)
;Update normal del pulpo
Update_Pulpo_Px
	BIT		CHECK_DISPARA,(IX+_CHECKS)
	CALL    NZ,dispara_malo_pulpo
Update_Pulpo_sin_disp_Px
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_UM_Px

	LD      a,FX_imp_biologico
	CALL    Toca_FX_Pos

	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_UM_Px
	LD      a,FX_exp_pequena
	CALL    Toca_FX_Pos
	LD      A,PUNTOS_PULPO
	LD      HL,DSPR_EXPLOSION_MALO
	call    activa_explosion_comun
mas_Vidas_UM_Px
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_UM_Px
sigue_UM_Px
	RES	CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_UM_Px
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UMP
	DEC	(IX+_CAD)
	JP	salir_UMP
mueve_UMP
	CALL	Siguiente_Sprite
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,(IX+_MIRADA)
	CP	DERECHA
	JR	Z,mueve_derecha_UMP
	CP	IZQUIERDA
	JR	Z,mueve_izqda_UMP
	CP	ARRIBA
	JR	Z,mueve_arriba_UMP
	CP	ABAJO
	JR	Z,mueve_abajo_UMP
mueve_derecha_UMP
	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,cambio_dir_I_UMP
	LD	A,0
	EX      AF,AF'
	LD	A,1
	CALL	colision_SPRITE0
	JR	C,cambio_dir_I_UMP
	CALL	colision_Disparos
	JP	C,salir_UMP
	INC	(IX+_DESP)
	INC	(IX+_X)
	JR	salir_UMP
cambio_dir_I_UMP
	LD	A,IZQUIERDA
	JR	salir1_UMP
mueve_izqda_UMP
	LD	A,(IX+_DESP)
	OR	A
	JR	Z,cambio_dir_D_UMP
	LD	A,0
	EX      AF,AF'
	LD	A,-1
	CALL	colision_SPRITE0
	JR	C,cambio_dir_D_UMP
	CALL	colision_Disparos
	JR	C,salir_UMP
	DEC	(IX+_DESP)
	DEC	(IX+_X)
	JR	salir_UMP
cambio_dir_D_UMP
	LD	A,DERECHA
	JR	salir1_UMP
mueve_abajo_UMP
	LD	A,(IX+_IDESP)
	CP	(IX+_DESP)
	JR	Z,cambio_dir_Arr_UMP
	LD      A,(IX+_DESP)
	ADD     A,4
	LD      (IX+_DESP),A
	LD	A,(IX+_Y)
	ADD     A,4
	LD      (IX+_Y),A
	JR	salir_UMP
cambio_dir_Arr_UMP
	LD	A,ARRIBA
	JR	salir1_UMP
mueve_arriba_UMP
	LD	A,(IX+_DESP)
	OR	A
	JR	Z,cambio_dir_Aba_UMP
	LD      A,(IX+_DESP)
	SUB     A,4
	LD      (IX+_DESP),A
	LD	A,(IX+_Y)
	SUB     A,4
	LD      (IX+_Y),A
	JR	salir_UMP
cambio_dir_Aba_UMP
	LD	A,ABAJO
	;JR	salir1_UMP
salir1_UMP
	LD	(IX+_MIRADA),A
salir_UMP
salir2_UMP
	LD	A,(IX+_ID)
	JP	Actualiza_Tabla_INT_cfp_isp_ibp
  	;CALL	Actualiza_Tabla_INT_cfp
 	;CALL	Actualiza_Tabla_INT_isp
 	;JP	Actualiza_Tabla_INT_ibp

Update_Bombona
	LD   A,(TABLA_OBJETOS+8) ;si no esta abierta la abro
	OR   A
	JR   Z,no_saco_bombona_B
 	SET     CHECK_ABIERTO,(IX+_CHECKS)
 	RES     CHECK_NIVEL,(IX+_CHECKS)
	LD      A,(IX+_VIDAS)
	OR      A
	JR      Z,Explosion_malo_y_puerta
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_UM_b

	LD      a,FX_imp_art_abierto
	CALL    Toca_FX_Pos

	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_UM_b
	LD      a,FX_exp_pequena
	CALL    Toca_FX_Pos
	LD      HL,DSPR_EXPLOSION_MALO
	call    activa_explosion_comun
mas_Vidas_UM_b
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_UM_b
sigue_UM_b
	RES	CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_UM_b
	JP	salir_UMP
no_saco_bombona_B
	LD	 C,(IX+_ID)
	LD	 B,0
	LD	 HL,SPRITE0_INT
	ADD  HL,BC
	LD	 (HL),0
	RET
Explosion_malo_y_puerta
	CALL Explosion_malo
	LD   A,(IX+_SPR_A)
	CP   3
	RET  NZ
	LD   A,1
	LD   (CHECK_BOMBONA),A
	RET

colision_Disparos
	LD	IY,DISPARO0
	LD	A,(IY+_SESTADO)
	or  a;CP      255
	JR      Z,otro_disparo_cd
	LD	B,(IX+_X)	
	PUSH	BC
	ADD	A,B
	LD	(IX+_X),A
	CALL	rectangles_collide
	POP	BC
	LD	(IX+_X),B
	JR	C,colisiona_con_un_disparo_cd
otro_disparo_cd
	LD	IY,DISPARO1
	LD	A,(IY+_SESTADO)
	or  a;CP      255
	JR	Z,sal_sin_disparo_cd
	LD	B,(IX+_X)	
	PUSH	BC
	ADD	A,B
	LD	(IX+_X),A
	CALL	rectangles_collide
	POP	BC
	LD	(IX+_X),B
	RET     NC
colisiona_con_un_disparo_cd
	CP      255
	JR      NZ,no_check_muerte1_cd
	BIT     CHECK_MUERE,(IX+_CHECKS)  	;bit 5
	JR      NZ,si_muere_cd
	BIT     CHECK_NIVEL,(IX+_CHECKS)  	;bit 4
	JR      NZ,no_check_muerte_cd
si_muere_cd
	BIT     CHECK_ABIERTO,(IX+_CHECKS)	;bit 1
	JR      Z,no_check_muerte1_cd
	SET     CHECK_MUERTE_DESDE,(IX+_CHECKS)
no_check_muerte_cd
	;LD	A,(IX+_DISP)
	;ADD     C_INC_DISP_PULPO
	;LD	(IX+_DISP),A
no_check_muerte1_cd
	SCF
	RET
sal_sin_disparo_cd
	XOR     A
	RET

;En A, el inc X y en A' el inc Y
colision_SPRITE0
	LD	IY,SPRITE0
	BIT CHECK_CAMBIO,(IY+_CHECKS)
	scf
	ret nz
; con esto aqui, se paran los malos mientras eres invulnerable
; 	BIT	CHECK_INVULNERABLE,(IY+_CHECKS)
; 	ret	nz
	LD	B,(IX+_X)	
	LD      C,(IX+_Y)
	PUSH	BC
	ADD	A,B
	LD	(IX+_X),A
	EX      AF,AF'
	ADD	A,C
	LD	(IX+_Y),A
	CALL	rectangles_collide
	POP	BC
	LD	(IX+_X),B
	LD      (IX+_Y),C
	RET	NC
	BIT	CHECK_INVULNERABLE,(IY+_CHECKS)
	SCF
	ret	nz
	;JR	NZ,no_vuelvas_a_matar_CS
	SET	CHECK_MUERTE_DESDE,(IY+_CHECKS)
no_vuelvas_a_matar_CS
	;LD	(IY+_CHECKS),A
	LD	A,(IY+_MIRADA)
	OR	A
	JR	NZ,mira_izquierda_CS
	;si esta mirando a la derecha, el malo debe estar a la izquierda, si no roto prota
	LD	A,(IX+_X)
	CP	(IY+_X)
	JR	NC,retorna_cc_CS
	LD	A,1
	LD	(IY+_MIRADA),A
	RET
mira_izquierda_CS
	;si esta mirando a la izquierda, el malo debe estar a la derecha, si no roto prota
	LD	A,(IX+_X)
	CP	(IY+_X)
	RET	C
	LD	A,0
	LD	(IY+_MIRADA),A
retorna_cc_CS
	SCF
Update_Nulo
	RET

;Update de los pies del pulpo
Update_Pulpo_Px_ABA
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UMPA
	DEC	(IX+_CAD)
	JP	salir2_UMP
mueve_UMPA
	;CALL	Siguiente_Sprite
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	PUSH	IX
	POP	HL
	LD	BC,LONG_SPRITES
; 	SBC	HL,BC
; 	SBC	HL,BC
	SBC	HL,BC
	PUSH	HL
	POP	IY
	LD      A,(IY+_ID)
	OR      A
	JR      NZ,sigue_UMPXAba
	LD	C,A
	LD	B,0
	LD	HL,SPRITE0_INT
	ADD     HL,BC
	LD	(HL),0
sigue_UMPXAba
	LD	A,(IY+_X)
	LD	(IX+_X),A
	LD	A,(IY+_CHECKS)
	and     %00111111  ;respeto los checks simetria y mata o no
	LD      b,a
	LD	A,(IX+_CHECKS)
	and     %11000000
	or      b
	LD	(IX+_CHECKS),A
	LD	A,(IY+_DESP)
	LD	(IX+_DESP),A
	LD	A,(IY+_IDESP)
	LD	(IX+_IDESP),A
	;BIT     CHECK_MUERTE_DESDE,(IY+_CHECKS)
	LD      A,(IY+_VIDAS)
	OR      A
	JR      Z,coge_el_correcto_UMPXAba
	CALL    siguiente_sprite
	JP	salir2_UMP
coge_el_correcto_UMPXAba
	LD      A,3
	LD	(IX+_SPR_A),A
sigue1_UMPXAba
	JP	salir2_UMP


Inc_Puntos
	LD      HL,(SCORE)
	LD      B,0
	LD      C,A
	ADD     HL,BC
	LD      (SCORE),HL
	RET

Explosion_malo
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_EM
	DEC	(IX+_CAD)
	JP	salir2_UMP
mueve_EM
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	RES	 CHECK_MUERTE,(IX+_CHECKS)
	CALL Siguiente_Sprite
	LD   A,(IX+_SPR_A)
	CP   0
	JP   NZ,salir2_UMP;salir_UAP    ***OJO que elimina explosion***
	LD	 C,(IX+_ID)
	LD	 B,0
	LD	 HL,SPRITE0_INT
	ADD  HL,BC
	LD	 (HL),0
 	JP	 Actualiza_Tabla_INT_ibp

inicia_disparo_Malo_Parabola
	LD   B,0
	LD   A,(DISPARO2_ESTADO)
	OR   A
	JR   NZ,ocupado2_idmp
	INC  B
ocupado2_idmp
	LD   A,(DISPARO3_ESTADO)
	OR   A
	JR   NZ,ocupado3_idmp
	INC  B
ocupado3_idmp
	LD   A,(DISPARO4_ESTADO)
	OR   A
	JR   NZ,ocupado4_idmp
	INC  B
ocupado4_idmp
; 	LD   A,(DISPARO5_ESTADO)
; 	OR   A
; 	JR   NZ,ocupado5_idmp
; 	INC  B
ocupado5_idmp
	LD   A,B
	CP   1
	RET  C

	LD      a,FX_disp_biologico
	CALL    Toca_FX_Pos

	LD   C,1
	LD   D,0
	CALL ejecuta_parabola_principio
	LD   C,-1
	LD   D,2
ejecuta_parabola_principio
	CALL selecciona_disparo_libre
	;ejecutar parabola izquierda o derecha
	LD   (IY+_SID),B
	LD	 A,(IX+_X)
	ADD  A,D
	LD	 (IY+_SX),A
	LD	 (IY+_SANTX),A
	LD	 A,(IX+_Y)
	SUB  6
	LD	 (IY+_SY),A
	LD	 (IY+_SANTY),A
	LD   (IY+_SVEL_X),C		;direccion de la parabola izquierda
	LD   (IY+_SVEL_Y),0		;path 0
	LD   HL,control_disparo_parabola_ini
	LD   (IY+_SMOVIMIENTO),L
	LD   (IY+_SMOVIMIENTO+1),H
	LD	 (IY+_SESTADO),#FF

	LD   A,(IY+_SID)
; 	CALL Actualiza_Tabla_INT_cfp
;  	CALL Actualiza_Tabla_INT_isp
	CALL Actualiza_Tabla_INT_UPD
	LD	 HL,BALA_EXP
	LD	 (IY+_SDIRECCION),L
	LD	 (IY+_SDIRECCION+1),H
	SCF
	CCF
	RET

selecciona_disparo_libre
	LD   B,0
	LD	 A,(DISPARO2_ESTADO)
	OR	 A
	JR   NZ,disparo2_cero_idM
	LD   B,9
	LD	 IY,DISPARO2
	RET
disparo2_cero_idM
	LD  A,(DISPARO3_ESTADO)
	OR  A
	JR  NZ,disparo3_cero_idM
	LD	IY,DISPARO3
	LD  B,10
	RET
disparo3_cero_idM
	LD      A,(DISPARO4_ESTADO)
	OR      A
	JR      NZ,no_hay_disparo_idM;disparo4_cero_idM
	LD		IY,DISPARO4
	LD  	B,11
	RET
; disparo4_cero_idM
; 	LD      A,(DISPARO5_ESTADO)
; 	OR      A
; 	JR      NZ,no_hay_disparo_idM
; 	LD	IY,DISPARO5
; 	LD  B,12
; 	;hay disparos libres
; 	RET
no_hay_disparo_idM
	LD      IY,0
	RET

inicia_disparo_Malo
	CALL    selecciona_disparo_libre
	RET     NZ
inicia_disparo_Malo_IY
puedes_tirar_idM
	LD	A,(IX+_MIRADA)
	OR	A
	LD	A,(IX+_X)
	JR	NZ,izq_idM
	CP	#48
	RET	NC
	JR	sigue_idM
izq_idM
	CP  3
	RET C
sigue_idM
	push bc
	LD      a,FX_disp_artefacto
	CALL    Toca_FX_Pos
	pop  bc

	RES CHECK_DISPARA,(IX+_CHECKS)
; 	LD	(IY+_SESTADO),#fe

	LD	A,(IX+_X)
	ADD	(IX+_TAG+1)
	;add     d
	LD	(IY+_SX),A
	LD	(IY+_SANTX),A
	LD	A,(IX+_Y)
	ADD	(IX+_TAG)
	;ADD	E
	LD	(IY+_SY),A
	LD	(IY+_SANTY),A
	LD  (IY+_ID),B

; 	CALL rectangles_collide
; 	RET  C

	LD   A,(iy+_ID)
	CALL Actualiza_Tabla_INT_cfp
 	CALL Actualiza_Tabla_INT_isp
	CALL Actualiza_Tabla_INT_UPD
	LD	 HL,BALA_EXP
	LD	 (IY+_SDIRECCION),L
	LD	 (IY+_SDIRECCION+1),H

	;inicializa los valores para el evaristo
	;se pone el destino en el centro del prota
	LD      A,(SPRITE0_X)
	ADD     a,3
	LD      (IY+_SVEL_X),A
	LD      A,(SPRITE0_Y)
	add     a,12
	LD      (IY+_SVEL_Y),A
	LD      HL,control_disparo_malo_ini
	LD      (IY+_SMOVIMIENTO),L
	LD      (IY+_SMOVIMIENTO+1),H
	RET


Update_Disparador_Ini_Px
	LD      A,(IX+_ICAD)
	LD      (IX+_DISP),A
	LD      HL,Update_Disparador_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      A,(IX+_MIRADA)
	OR      A
	JR      Z,mira_derecha_Dispara_DPX
	LD      (IX+_TAG+1),-2
	JR      mira_izqda_Dispara_DPX
mira_derecha_Dispara_DPX
	LD      (IX+_TAG+1),5
mira_izqda_Dispara_DPX
	LD      (IX+_TAG),2
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	RES		CHECK_MUERTE,(IX+_CHECKS)
Update_Disparador_Px
	SET     CHECK_MUERE,(IX+_CHECKS)
	;BIT		CHECK_MUERE,(IX+_CHECKS)
	;JR      Z,no_muerte_DPX
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_DPX

	LD      a,FX_imp_art_abierto
	CALL    Toca_FX_Pos

	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_DPX
	LD      a,FX_exp_grande
	CALL    Toca_FX_Pos
	LD      HL,DSPR_EXPLOSION_MALO8
	LD      A,PUNTOS_DISPARA
	CALL    activa_explosion_comun
mas_Vidas_DPX
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_DPX
sigue_DPX
	RES		CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_DPX
no_muerte_DPX
	LD      A,(IX+_DISP)
	DEC     A
	LD      (IX+_DISP),A
	CALL    Z,dispara_DPX
	CALL    siguiente_sprite
	JP      salir_UTP

dispara_DPX
	CALL	inicia_disparo_Malo
	LD      A,IYH
	OR      A
	JR      NZ,hay_disparo_dDPX
	LD      A,IYL
	OR      A
	RET     Z
hay_disparo_dDPX
	LD      A,(IX+_Y)
	ADD     A,2
	LD      (IY+_SVEL_Y),A	;fuerza disparo horizontal en la Y

	LD      A,(IX+_MIRADA)
	OR      A
	JR      Z,mira_derecha_Disparah_DPX
	LD      (IY+_SVEL_X),0
	JR      mira_izqda_Disparah_DPX
mira_derecha_Disparah_DPX
	LD      (IY+_SVEL_X),80
mira_izqda_Disparah_DPX
	LD      A,(IX+_ICAD)
	LD      (IX+_DISP),A
	RET

activa_explosion_comun
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	CALL 	Inc_Puntos
    RES     CHECK_MUERTE,(IX+_CHECKS)
	LD	    (IX+_CAD),0
	LD      (IX+_ICAD),1
	LD      (IX+_SPR),6
	LD      (IX+_SPR_A),6
	JP  	Siguiente_Sprite


Update_Planta_Ini_Px
	LD      b,0
	ld      c,75
	CALL    Random_B_C
	ADD     (IX+_ICAD)		;inicializado al nivel de dificultad
	LD      (IX+_DISP),A
	LD      A,0
	LD      (IX+_SPR),A
	LD      HL,Update_Planta_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      (IX+_TAG+1),0		;posicion inicio de disparo
	LD      (IX+_TAG),-6
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	SET     CHECK_MUERE,(IX+_CHECKS)
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	RES		CHECK_MUERTE,(IX+_CHECKS)
Update_Planta_Px
	BIT		CHECK_MUERE,(IX+_CHECKS)
	JR      Z,no_muerte_UPP
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_UPP

	LD      a,FX_imp_biologico
	CALL    Toca_FX_Pos

	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_UPP
	LD      a,FX_exp_pequena
	CALL    Toca_FX_Pos
	LD      A,PUNTOS_PLANTA
	LD      HL,DSPR_EXPLOSION_MALO
	CALL    activa_explosion_comun
mas_Vidas_UPP
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_UPP
sigue_UPP
	RES		CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_UPP
no_muerte_UPP
	LD      A,(IX+_DISP)
	DEC     A
	LD      (IX+_DISP),A
	JR      Z,activa_disparo_UPP
salir_UPP
	LD	A,(IX+_ID)
	JP	Actualiza_Tabla_INT_cfp_isp_ibp
activa_disparo_UPP
	LD      A,29
	LD      (IX+_SPR),A
	LD      HL,DSPR_PLANTA_ABRE
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      HL,Update_Planta_Abre_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	;LD      (IX+_DISP),50
	JR      salir_UPP

Update_Planta_Abre_Px
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
; 	BIT		CHECK_MUERTE,(IX+_CHECKS)
; 	RET     NZ
	;LD      A,(IX+_DISP)
	;rra
	CALL	siguiente_sprite
	;LD      A,(IX+_DISP)
	;DEC     A
	;LD      (IX+_DISP),A
	;CP      25
	LD      A,(IX+_SPR_A)
	CP      14
	JR      NZ,no_dispara_UPAP
	CALL	inicia_disparo_Malo_Parabola
	JR      NC,salir_UPP
	LD      A,13
	LD      (IX+_SPR_A),A
no_dispara_UPAP
	LD      A,(IX+_SPR_A)
	OR      A
	JP      Z,Update_Planta_Ini_Px
	JR      salir_UTP

Update_Torreta_Ini_Px
	LD      b,0
	ld      c,50
	CALL    Random_B_C
	ADD     (IX+_ICAD)		;inicializado al nivel de dificultad
	LD      (IX+_DISP),A
	LD      A,0
	LD      (IX+_SPR),A
	LD      HL,Update_Torreta_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      (IX+_TAG+1),1		;posicion inicio de disparo
	LD      (IX+_TAG),16
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	SET     CHECK_MUERE,(IX+_CHECKS)
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	RES		CHECK_MUERTE,(IX+_CHECKS)
Update_Torreta_Px
	BIT		CHECK_MUERE,(IX+_CHECKS)
	JR      Z,no_muerte_UTP
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_UTP

	LD      a,FX_imp_art_abierto
	CALL    Toca_FX_Pos

	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_UTP
	LD      a,FX_exp_pequena
	CALL    Toca_FX_Pos
	LD      HL,DSPR_EXPLOSION_MALO
	LD      A,PUNTOS_TORRETA
	CALL    activa_explosion_comun
mas_Vidas_UTP
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_UTP
sigue_UTP
	RES		CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_UTP
no_muerte_UTP
	LD      A,(IX+_DISP)
	DEC     A
	LD      (IX+_DISP),A
	JR      Z,activa_disparo_UTP
salir_UTP
	LD	A,(IX+_ID)
	JP	Actualiza_Tabla_INT_cfp_isp_ibp
activa_disparo_UTP
	LD      A,52
	LD      (IX+_SPR),A
	LD      HL,DSPR_TORRETA_GIRA
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	RES		CHECK_MUERTE,(IX+_CHECKS)
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      HL,Update_Torreta_Gira_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	;LD      (IX+_DISP),50
	JR      salir_UTP

Update_Torreta_Gira_Px
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_UTG
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	LD      A,FX_imp_art_cerrado
	CALL    Toca_FX_Pos
; 	BIT		CHECK_MUERTE,(IX+_CHECKS)
; 	RET     NZ
	;LD      A,(IX+_DISP)
	;rra
sigue_UTG
	CALL	siguiente_sprite
	;LD      A,(IX+_DISP)
	;DEC     A
	;LD      (IX+_DISP),A
	;CP      25
	LD      A,(IX+_SPR_A)
	CP      25
	JR      NZ,no_dispara_UTGP
	CALL	inicia_disparo_Malo
	JR      salir_UTP
no_dispara_UTGP
	LD      A,(IX+_SPR_A)
	OR      A
	JP      Z,Update_Torreta_Ini_Px
	JR      salir_UTP


;muere indica si muere o no (es el mismo check que dispara pero se usa para otra cosa en estas)
Update_RanaS_ini_Px
	LD      HL,Update_RanaS_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      A,(IX+_IDESP)
	LD	    (IX+_DESP),A
	LD		(IX+_ADESP),A
Update_RanaS_Px
	LD		A,(Pas_Interrupcion)
	RRA
	RRA			;cadencia 12,5 fps
	JR		NC,mueve_URSP
	JR		salir_URSP
mueve_URSP
	CALL	Siguiente_Sprite
	LD	    A,(IX+_CAD)
	DEC     A
	LD      (IX+_CAD),A
	OR      A
	JR      NZ,salir_URSP
salta_ranita_RSP
	LD      A,(IX+_ICAD)
	LD      (IX+_CAD),A
	LD      A,(IX+_IDESP)
	LD      BC,0
	LD		HL,offset_rana_ARR
sigue_capturando_RSP
	CP      (HL)
	JR      Z,captura_punto_array_RSP
	INC     C
	INC     HL
	JR      sigue_capturando_RSP
captura_punto_array_RSP
	LD      (IX+_TAG),L
	LD      (IX+_TAG+1),H
	LD      HL,DSPR_RANA_SALTO
	RLC     C
	ADD     HL,BC			;se pone en el punto de inicio de salto
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      (IX+_SPR),255
	LD      (IX+_SPR_A),0
	LD      HL,Update_RanaS_salto_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
salir_URSP
	LD		A,(IX+_ID)
	JP		Actualiza_Tabla_INT_cfp_isp_ibp
	RET

Update_RanaS_salto_Px
	;LD	A,(Pas_Interrupcion)
	;RRA
	;RRA			;cadencia 12,5 fps
	;JR	NC,mueve_URSSP
	;JR	salir_URSP
mueve_URSSP
	LD      L,(IX+_TAG)
	LD      H,(IX+_TAG+1)
	LD      BC,29
	ADD     HL,BC
	LD      A,(IX+_Y)
	ADD     (HL)
	LD      (IX+_Y),A
	LD	A,(IX+_DESP)
	LD      (_ADESP),A
	ADD     (HL)
	LD      (IX+_DESP),A
	XOR     A
	SBC     HL,BC
	INC     HL
	LD      A,(HL)
	CP      (IX+_IDESP)
	JR      Z,verifica_colision_RSSP
	JR      C,verifica_colision_RSSP
	LD      HL,Update_RanaA_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      A,9
	LD      (IX+_SPR),A
	LD      (IX+_SPR_A),A
	LD      HL,DSPR_RANA_ATERRIZA
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      HL,offset_rana_ATE
	LD      (IX+_TAG),L
	LD      (IX+_TAG+1),H
	JR      continua_saltando_RSSP
verifica_colision_RSSP
	LD      IY,SPRITE0
	CALL	rectangles_collide
	JR	C,no_muevo_RSSP_s0
	CALL	colision_Disparos
	JR	C,no_muevo_RSSP_s0
	JR      continua_saltando1_RSSP

no_muevo_RSSP_s0
	LD	A,(IY+_CHECKS)
	BIT	CHECK_INVULNERABLE,A
	JR   	nz,no_muevo_RSSP
	SET	CHECK_MUERTE_DESDE,(IY+_CHECKS)
no_muevo_RSSP
	LD      A,(IX+_ADESP)
	LD      (IX+_DESP),A
	LD      A,(IX+_ANTY)
	LD      (IX+_Y),A
	JP      salir_URSP
continua_saltando1_RSSP
	LD      (IX+_TAG),L
	LD      (IX+_TAG+1),H
continua_saltando_RSSP
	CALL    siguiente_sprite
	JP      salir_URSP

Update_RanaA_Px
	LD	A,(Pas_Interrupcion)
	RRA
	RRA			;cadencia 12,5 fps
	JP	NC,mueve_URAP
	JP	salir_URSP
mueve_URAP
	CALL	siguiente_sprite
	LD      A,(IX+_SPR_A)
	OR      A
	JR      NZ,continua_ate_URAP
	LD      HL,Update_RanaS_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      A,3
	LD      (IX+_SPR),A
	XOR     A
	LD      (IX+_SPR_A),A
	LD      HL,DSPR_RANA_STANDBY
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
continua_ate_URAP
	LD      L,(IX+_TAG)
	LD      H,(IX+_TAG+1)
	LD      A,(IX+_Y)
	ADD     (HL)
	LD      (IX+_Y),A
	LD		A,(IX+_DESP)
	ADD     (HL)
	LD      (IX+_DESP),A
	INC     HL
	LD      (IX+_TAG),L
	LD      (IX+_TAG+1),H
	JP      salir_URSP


;nivel marca si hay cambios de direccion o no
;muere indica si muere o no (es el mismo check que dispara pero se usa para otra cosa en estas)
;este malo es común con la babosa
Update_RanaC_ini_Px
	LD      b,25
	ld      c,125
	CALL    Random_B_C
	LD      (IX+_DISP),A
	LD      HL,Update_RanaC_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	;BIT     CHECK_MUERE,(IX+_CHECKS)
	;JR      NZ,Update_RanaC_Px
	SET     CHECK_ABIERTO,(IX+_CHECKS)
Update_RanaC_Px
	BIT		CHECK_MUERE,(IX+_CHECKS)
	JR      Z,no_muerte_URCP
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_URCP

	LD      a,FX_imp_biologico
	CALL    Toca_FX_Pos

	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_URCP
	LD      a,FX_exp_grande
	CALL    Toca_FX_Pos
	LD      HL,DSPR_EXPLOSION_MALO8
	LD      A,PUNTOS_BABOSA
	CALL    activa_explosion_comun
mas_Vidas_URCP
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_URCP
sigue_URCP
	RES		CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_URCP

no_muerte_URCP
	LD		A,(IX+_CAD)
	OR		A
	JR		Z,mueve_URCP
	DEC		(IX+_CAD)
	JP		salir_URCP
mueve_URCP
	CALL	Siguiente_Sprite
	LD		A,(IX+_ICAD)
	LD		(IX+_CAD),A
	LD		A,(IX+_MIRADA)
	CP		DERECHA
	JR		NZ,mueve_izqda_URCP
mueve_derecha_URCP
	LD		A,(IX+_IDESP)
	CP		(IX+_DESP)
	JR		Z,cambio_dir_I_URCP
	BIT     CHECK_NIVEL,(IX+_CHECKS)
	JR      Z,no_hay_cambios_d_URCP
	LD      A,(IX+_DISP)
	DEC     A
	LD      (IX+_DISP),A
	JR      Z,cambio_dir_alea_I_URCP
no_hay_cambios_d_URCP
	LD		A,0
	EX      AF,AF'
	LD      A,1
	CALL	colision_SPRITE0
	JP		C,cambio_dir_I_URCP
	CALL	colision_Disparos
	JR		C,cambio_dir_I_URCP
	INC		(IX+_DESP)
	INC		(IX+_X)
	JR		salir_URCP
cambio_dir_alea_I_URCP
	LD      b,25
	ld      c,125
	CALL    Random_B_C
	LD      (IX+_DISP),A
cambio_dir_I_URCP
	LD		A,IZQUIERDA
	JR		salir1_URCP
mueve_izqda_URCP
	LD		A,(IX+_DESP)
	OR		A
	JR		Z,cambio_dir_D_URCP
	BIT     CHECK_NIVEL,(IX+_CHECKS)
	JR      Z,no_hay_cambios_i_URCP
	LD      A,(IX+_DISP)
	DEC     A
	LD      (IX+_DISP),A
	JR      Z,cambio_dir_alea_D_URCP
no_hay_cambios_i_URCP
	LD		A,0
	EX      AF,AF'
	LD		A,-1
	CALL	colision_SPRITE0
	JR		C,cambio_dir_D_URCP
	CALL	colision_Disparos
	JR		C,cambio_dir_D_URCP
	DEC		(IX+_DESP)
	DEC		(IX+_X)
	JR		salir_URCP
cambio_dir_alea_D_URCP
	LD      b,0
	ld      c,100
	CALL    Random_B_C
	LD      (IX+_DISP),A
cambio_dir_D_URCP
	LD		A,DERECHA
salir1_URCP
	LD		(IX+_MIRADA),A
salir_URCP
;	BIT	CHECK_DISPARA,(IX+_CHECKS)
;	CALL    NZ,dispara_malo_almeja
	LD	A,(IX+_ID)
	JP	Actualiza_Tabla_INT_cfp_isp_ibp

Update_Almeja_Cambia_Cerrar_Px
	;preparo la almeja para que se cierre
	LD      (IX+_SPR),20
	LD      (IX+_SPR_A),0
	LD      HL,DSPR_ALMEJA_CERRAR
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      HL,Update_Almeja_Cerrar_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	RET

termina_disparo_Almeja
	LD      (IX+_SPR),0
	LD      (IX+_SPR_A),0
	LD      HL,DSPR_ALMEJA_CERRADA
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      HL,Update_Almeja_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	SET     CHECK_DISPARA,(IX+_CHECKS)
	JP      salir_sin_disparo_UAP

Update_Almeja_Cerrar_Px
	LD      A,(IX+_SPR_A)
	CP      (IX+_SPR)
	JR      Z,termina_disparo_Almeja
	BIT     CHECK_DISPARA,(IX+_CHECKS)
	JR      Z,Update_Almeja_Secun_Px
	CALL	inicia_disparo_Malo
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	JR      Update_Almeja_Secun_Px

Update_Almeja_Abrir_Px
	LD      A,(IX+_VIDAS)
	OR      A
	JR      Z,Update_Almeja_Secun_Px
	LD      A,(IX+_SPR_A)
	CP      (IX+_SPR)
	CALL    Z,Update_Almeja_Cambia_Cerrar_Px
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	JR      Update_Almeja_Secun_Px

;inicializacion de la almeja
Update_Almeja_ini_Px
	LD      b,125
	ld      c,200
	CALL    Random_B_C
	LD      (IX+_DISP),A
	LD      HL,Update_Almeja_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
Update_Almeja_Px
;update de la almeja
	RES     CHECK_ABIERTO,(IX+_CHECKS)
Update_Almeja_Secun_Px
;update de la almeja viniendo de otra fase
	LD      A,(IX+_VIDAS)
	OR      A
	JP      Z,Explosion_malo
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR      Z,sigue_UA_Px
	LD      a,FX_imp_art_abierto
	CALL    Toca_FX_Pos
	LD      A,(IX+_VIDAS)
	DEC     A
	JR      NZ,mas_Vidas_UA_Px
	LD      a,FX_exp_pequena
	CALL    Toca_FX_Pos
	LD      A,PUNTOS_ALMEJA
	LD      HL,DSPR_EXPLOSION_MALO
	call    activa_explosion_comun
;	XOR     A
;	LD      (IX+_SPR),0
;	LD      (IX+_SPR_A),0
;	LD      HL,DSPR_ALMEJA_CERRADA
;	LD      (IX+_DSPR),L
;	LD      (IX+_DSPR+1),H
	LD      HL,Update_Almeja_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
;	SET     CHECK_DISPARA,(IX+_CHECKS)
mas_Vidas_UA_Px
	LD      (IX+_VIDAS),A
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	SET		CHECK_MUERTE,(IX+_CHECKS)
	JR      sigue_muerto_UA_Px
sigue_UA_Px
	RES	CHECK_MUERTE,(IX+_CHECKS)
sigue_muerto_UA_Px

	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_UAP
	DEC	(IX+_CAD)
	JP	salir_UAP
mueve_UAP
	CALL	Siguiente_Sprite
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	LD	A,(IX+_MIRADA)
	CP	DERECHA
	JR	Z,mueve_derecha_UAP
	CP	IZQUIERDA
	JR	Z,mueve_izqda_UAP
	CP	ARRIBA
	JR	Z,mueve_arriba_UAP
	CP	ABAJO
	JR	Z,mueve_abajo_UAP
mueve_derecha_UAP
	LD		A,(IX+_IDESP)
	CP		(IX+_DESP)
	JR		Z,cambio_dir_I_UAP
	LD		A,0
	EX      AF,AF'
	LD      A,1
	CALL	colision_SPRITE0
	JP		C,cambio_dir_I_UAP
	CALL	colision_Disparos
	JR		C,cambio_dir_I_UAP
	INC		(IX+_DESP)
	INC		(IX+_X)
	JR		salir_UAP
cambio_dir_I_UAP
	LD		A,IZQUIERDA
	JR		salir1_UAP
mueve_izqda_UAP
	LD		A,(IX+_DESP)
	OR		A
	JR		Z,cambio_dir_D_UAP
	LD		A,0
	EX      AF,AF'
	LD		A,-1
	CALL	colision_SPRITE0
	JR		C,cambio_dir_D_UAP
	CALL	colision_Disparos
	JR		C,cambio_dir_D_UAP
	DEC		(IX+_DESP)
	DEC		(IX+_X)
	JR		salir_UAP
cambio_dir_D_UAP
	LD	A,DERECHA
	JR	salir1_UAP
mueve_abajo_UAP
	LD		A,(IX+_IDESP)
	CP		(IX+_DESP)
	JR		Z,cambio_dir_Arr_UAP
	LD      A,4
	EX      AF,AF'
	LD      A,0
	CALL    colision_SPRITE0
	JR      C,salir_UAP
	LD      A,(IX+_DESP)
	ADD     A,4
	LD      (IX+_DESP),A
	LD 		A,(IX+_Y)
	ADD     A,4
	LD 		(IX+_Y),A
	JR		salir_UAP
cambio_dir_Arr_UAP
	LD		A,ARRIBA
	JR		salir1_UAP
mueve_arriba_UAP
	LD		A,(IX+_DESP)
	OR		A
	JR		Z,cambio_dir_Aba_UAP
	LD      A,(IX+_DESP)
	LD      A,-4
	EX      AF,AF'
	LD      A,0
	CALL    colision_SPRITE0
	JR      C,salir_UAP
	LD		A,(IX+_DESP)
	SUB     A,4
	LD      (IX+_DESP),A
	LD 		A,(IX+_Y)
	SUB     A,4
	LD 		(IX+_Y),A
	JR		salir_UAP
cambio_dir_Aba_UAP
	LD		A,ABAJO
	;JR	salir1_UMP
salir1_UAP
	LD		(IX+_MIRADA),A
salir_UAP
	BIT		CHECK_DISPARA,(IX+_CHECKS)
	CALL    NZ,dispara_malo_almeja
salir_sin_disparo_UAP
	LD		A,(IX+_ID)
	JP		Actualiza_Tabla_INT_cfp_isp_ibp


dispara_malo_pulpo
	LD      A,(IX+_DISP)
	OR      A
	JR      Z,tengo_que_dispara_dmp
	DEC     (IX+_DISP)
	RET
tengo_que_dispara_dmp
	LD      A,50
	LD      (IX+_DISP),A
	CALL	calcula_posicion_disparo
	LD      (IX+_TAG),8
	LD      (IX+_TAG+1),D
	LD      HL,Update_Pulpo_Parar_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	RET

;en la anterior al 4/6 estará la que controla la direccion a la que va el bicho
dispara_malo_almeja
	LD      A,(IX+_DISP)
	OR      A
	JR      Z,tengo_que_dispara_dma
	DEC     (IX+_DISP)
	RET
tengo_que_dispara_dma
	LD      b,125
	ld      c,200
	CALL    Random_B_C
	LD      (IX+_DISP),A
	CALL	calcula_posicion_disparo
	LD      (IX+_TAG),8
	LD      (IX+_TAG+1),D
; 	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
; 	RES		CHECK_MUERTE,(IX+_CHECKS)
	LD      HL,Update_Almeja_Abrir_Px
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD      (IX+_SPR),20
	LD      (IX+_SPR_A),0
	LD      HL,DSPR_ALMEJA_ABRIR
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	RET

calcula_posicion_disparo
	;calcula posicion de salida del disparo
	LD      A,(IX+_MIRADA)
	CP      ARRIBA
	JR      NC,mov_vertical_cpd
	LD      A,(SPRITE0_X)
	CP      (IX+_X)
	JR  	C,disp_por_la_derecha_dmh
	LD      D,5
	RET
disp_por_la_derecha_dmh
	LD      D,-2		;X
	RET
mov_vertical_cpd
	LD      A,(SPRITE0_X)
	CP      (IX+_X)
	JR  	C,disp_por_la_derechav_dmh
	LD      D,5
	RET
disp_por_la_derechav_dmh
	LD      D,-3		;X
	RET
