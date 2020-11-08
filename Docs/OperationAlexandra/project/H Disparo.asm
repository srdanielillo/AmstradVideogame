control_disparo
	;imprimo_buffer pantalla
	;CALL 	Imprime_Buffer_Bala
	LD	A,(IX+_SESTADO)
	or  a
	ret z

;	LD	A,(IX+_SESTADO)
	cp  #fe
	jP  z,elimina_definitivamente_cd

;	LD	A,(IX+_SESTADO)
	cp  #ff
	JP  nz,Explosion_disparo_CD

	LD  A,(IX+_SLONGITUD)
	DEC A
	LD  (IX+_SLONGITUD),A
	JP  Z,inicia_desvanecimiento_disparo_CD

	LD	HL,BALA
	LD	(IX+_SDIRECCION),L
	LD	(IX+_SDIRECCION+1),H

	LD	A,(IX+_SX)
	LD	B,(IX+_SVEL_X)
	ADD A,B
	LD	(IX+_SX),A
	;verifico si se sale por los lados
	CP  79;ANCHO_MAPA_PX/2
	JR	NC,elimina_disparo_CD
	;verifico si se sale por arriba (siempre explota)
	LD	A,(IX+_SY)
	LD	B,(IX+_SVEL_Y)
	SUB B
	LD	(IX+_SY),A
	CP	40
	JR	C,inicia_explosion_disparo_CD
	;ya tengo la posición nueva en x e y
	;ahora debo verificar colisiones
	CALL	choque_malos_desde_disp
	JR      C,colision_malo_cd
	;no ha habido colision con malos, ni se sale de pantalla
	;detecto colisiones con durezas
	LD      a,(IX+_SVEL_Y)
	or      a
	jr      z,no_chequeo_y_doble_cd
	ld      a,(ix+_Y)
	add     3
	ld      b,a
	ld      c,(ix+_X)
	CALL	es_obstaculo_disp_BC_prota
	jr      nz,inicia_explosion_disparo_CD
no_chequeo_y_doble_cd
	CALL	es_obstaculo_disp_prota
	JR	    NZ,inicia_explosion_disparo_CD

	LD   A,(IX+_SID)
	JP   Actualiza_Tabla_INT_cfp_isp_ibp


colision_malo_cd
	;aqui tengo que ajustar la explosion a lo mas cerca del malo
	;primero las X
	;pero pongo las Y en la posicion anterior para ajustar maximo
	LD      A,(IX+_ANTX)
	LD      (IX+_X),A
	LD      A,(IX+_ANTY)
	LD      (IX+_Y),A

	LD      A,(Choq_MALOS_desde_DISP)
	LD      IY,SPRITE0
	LD      DE,LONG_SPRITES
choque_malo_cd
	ADD     IY,DE
	RRA
	JR      NC,choque_malo_cd

	;aqui tengo que poner la explosión en lugar de la eliminacion
	BIT     CHECK_NIVEL,(IY+_CHECKS)
	JR      NZ,inicia_explosion_disparo_CD
	BIT     CHECK_ABIERTO,(IY+_CHECKS)
	JR      Z,inicia_explosion_disparo_CD_con_sonido
	SET     CHECK_MUERTE_DESDE,(IY+_CHECKS)
	JR      inicia_explosion_disparo_CD

inicia_explosion_disparo_CD_con_sonido
	LD      A,FX_imp_art_cerrado
	CALL    Toca_FX_Pos
	JR      inicia_explosion_disparo_CD

elimina_definitivamente_cd
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,(IX+_ID)
	ADD	HL,BC
	XOR A
	LD	(HL),A
	LD  (IX+_SESTADO),A
	ret

elimina_disparo_CD
	LD  (IX+_SESTADO),#FE
	LD   A,(IX+_SID)
	JP   Actualiza_Tabla_INT_ibp

inicia_desvanecimiento_disparo_CD
	LD	HL,BALA
	LD	(IX+_SESTADO),4 or &80
	JR  comun_explosion_CD

inicia_explosion_disparo_CD
	LD	HL,BALA_EXP
	LD	(IX+_SESTADO),4
comun_explosion_CD
	LD	(IX+_SDIRECCION),L
	LD	(IX+_SDIRECCION+1),H
	LD   A,(IX+_SID)
	JP   Actualiza_Tabla_INT_cfp_isp_ibp

Explosion_disparo_CD
	BIT 7,A 		;si es uno es desvanecimiento, si no explosion
	JR  Z,es_explosion_edCD
	LD  HL,DSPR_DISPARO_DES
	JR  sigue_desv_edCD
es_explosion_edCD
	LD  HL,DSPR_DISPARO_EXP
sigue_desv_edCD
	LD	C,A
	RES 7,C
	DEC C
	LD	B,0
	SLA C
	ADD	HL,BC
	DEC A
	LD	(IX+_SESTADO),A
	RES 7,A
	or  a
	JR  Z,elimina_disparo_CD
continua_explosion_edCD
	LD	A,(HL)
	LD	C,A
	INC HL
	LD	A,(HL)
	LD	B,A
 	LD	(IX+_SDIRECCION),C
 	LD	(IX+_SDIRECCION+1),B
 	LD   A,(IX+_SID)
	JP   Actualiza_Tabla_INT_cfp_isp_ibp

;Proceso para elegir donde empieza el disparo amigo
inicia_disparo_Prota
	LD	A,(DISPARO0_ESTADO)
	OR	A
	JR  NZ,disparo0_cero_idP
	LD	IY,DISPARO0
	LD  B,7	;id del disparo 0
	JR	actualiza_idP
disparo0_cero_idP
	LD  A,(DISPARO1_ESTADO)
	OR  A
	RET NZ
	LD	IY,DISPARO1
	LD  B,8	;id del disparo 1
actualiza_idP
	LD  (IY+_SID),b
	LD   A,B
	CALL Actualiza_Tabla_INT_UPD
	LD   HL,control_disparo_ini
	LD   (IY+_SMOVIMIENTO),L
	LD   (IY+_SMOVIMIENTO+1),H
	RET
	;hay disparos libres
control_disparo_ini
puedes_tirar_idP
	LD  A,(SPRITE0_ESTADOS)
	BIT ESTADO_SALTAR,A
	JR  NZ,mirar_limites_idP
	LD  A,(TECLADO0)
	BIT	JOY_UP,A 						;OJO
	JR  Z,mirar_limites_idP
	BIT	JOY_RIGHT,A 						;OJO
	JR  NZ,mirar_limites_idP
	BIT	JOY_LEFT,A 						;OJO
	JR  Z,no_mirar_limites_idP

mirar_limites_idP
	LD	A,(SPRITE0_MIRADA)
	OR	A
	LD	A,(SPRITE0_X)
	JR	NZ,izq_ptidP
	CP	#48
	;RET NC
	JP  NC,no_actives_disparo_cd
	JR	sigue_ptidP
izq_ptidP
	CP  3
	;RET C
	JP  C,no_actives_disparo_cd
no_mirar_limites_idP
sigue_ptidP
	;LD	A,(SPRITE0_X)
	;CP	#47
; 	LD  A,B
	LD	A,#ff
	LD	(IX+_SESTADO),A
	LD	A,(TECLADO0)
	BIT	JOY_DOWN,A 						;OJO
;     LD  A,(SPRITE0_ESTADOS)
;     BIT ESTADO_AGACHAR,A
 	JP	NZ,mirada_IX_agachado_idp

	LD	B,0
	LD	A,(SPRITE0_ESTADOS)
	BIT	ESTADO_SALTAR,A
	JR	NZ,no_hacia_arriba_idP
	BIT	ESTADO_CAER,A
	JR	NZ,no_hacia_arriba_idP
	LD	A,(TECLADO0)
	BIT	JOY_UP,A 							;OJO
	JP  Z,mirada_IX_idp
	LD	B,10
no_hacia_arriba_idP
	LD	A,(TECLADO0)
	BIT	JOY_LEFT,A 							;OJO
	JR  Z,mira_a_derecha_idP
	LD	C,-3;%10000011ddddd
	LD	D,-2
	LD	E,0
	LD	A,(SPRITE0_ESTADOS)
	BIT	ESTADO_SALTAR,A
	JR	NZ,saltai_idP
	BIT	ESTADO_CAER,A
	JR	Z,sigue_idP
saltai_idP
	LD	E,8
	LD	D,-3
	JR	sigue_idP
mira_a_derecha_idP
	BIT	JOY_RIGHT,A 						;OJO
	JR  Z,solo_arriba
	LD	C,3
	LD	D,6
	LD	E,0
	LD	A,(SPRITE0_ESTADOS)
	BIT	ESTADO_SALTAR,A
	JR	NZ,saltad_idP
	BIT	ESTADO_CAER,A
	JR	Z,sigue_idP
saltad_idP
	LD	D,7
	LD	E,8
	JR	sigue_idP
solo_arriba
	LD	A,(SPRITE0_ESTADOS)
	BIT	ESTADO_SALTAR,A
	JR	NZ,saltaa_idP
	BIT	ESTADO_CAER,A
	JR	Z,sa_idP
saltaa_idP
	LD	E,8
	LD	A,(SPRITE0_MIRADA)
	CP	IZQUIERDA
	JR	Z,sai_idp
	LD	C,3
	LD	D,7
	JR	sigue_idP
sai_idp
	LD	C,-3;%10000011
	LD	D,-3
	JR	sigue_idP
	;a partir de aqui es con el arriba pulsado y sin salto o caida
sa_idP
	LD	C,0
	LD	D,0
	LD	E,-10
	LD	A,(SPRITE0_MIRADA)
	CP	IZQUIERDA
	JR	NZ,sigue_idP
	LD	D,4
sigue_idP
	LD	(IX+_SVEL_Y),B
	LD	(IX+_SVEL_X),C
	LD	A,(SPRITE0_X)
	ADD	D
	LD	(IX+_SX),A
	LD	(IX+_SANTX),A
	LD	A,(SPRITE0_Y)
	ADD	E
	LD	(IX+_SY),A
	LD	(IX+_SANTY),A
	JR  exp_ini_midP

;pongo el disparo en el lado de la mirada
;mirada_IX_salto_idp
;	RET

mirada_IX_agachado_idp
	LD	A,(SPRITE0_MIRADA)
	CP	IZQUIERDA
	JR  NZ,mira_a_derechaa_midP
	LD	B,-2
	LD	C,-3;%10000011
	JR	siguea_midP
mira_a_derechaa_midP
	LD	B,6
	LD	C,3
siguea_midP
	LD	A,(SPRITE0_Y)
	ADD	A,12
	LD	(IX+_SY),A
	JR	sigue1_midP

mirada_IX_idp
	LD	A,(SPRITE0_MIRADA)
	CP	IZQUIERDA
	JR  NZ,mira_a_derecha_midP
	LD	B,-2
	LD	C,-3;%10000011
	JR	sigue_midP
mira_a_derecha_midP
	LD	B,6;10
	LD	C,3
sigue_midP
	LD	A,(SPRITE0_Y)
	ADD	A,8
	LD	(IX+_SY),A
sigue1_midP
	LD	(IX+_SANTY),A
	LD	(IX+_SVEL_Y),0
	LD	(IX+_SVEL_X),C
	LD	A,(SPRITE0_X)
	ADD	A,B
	LD	(IX+_SX),A
	LD	(IX+_SANTX),A
exp_ini_midP
	;comprueba si donde se crea hay un malo y matarlo
	CALL choque_malos_desde_disp
	JR   C,mata_al_malo_pero_nada_mas

	LD   HL,control_disparo
	LD   (IX+_SMOVIMIENTO),L
	LD   (IX+_SMOVIMIENTO+1),H

	CALL	es_obstaculo_disp
	CALL    NZ,no_actives_disparo_y_explota_cd

	LD   A,(IX+_SID)
	CALL   Actualiza_Tabla_INT_cfp_isp_ibp
; 	CALL Actualiza_Tabla_INT_cfp
; 	CALL Actualiza_Tabla_INT_isp
	CALL Actualiza_Tabla_INT_UPD

	LD  A,(TABLA_OBJETOS+10)
	OR  A
	JR  Z,long_maxima_midP
	LD  (IX+_SLONGITUD),LONG_DISPARO
	LD  a,FX_disparo_prota
	JR  sigue_longitud_midP
long_maxima_midP
	LD  a,FX_disparo_prota_l
	LD  (IX+_SLONGITUD),255
sigue_longitud_midP
	CALL    Toca_FX_Pos
	LD  A,(IX+_SVEL_Y)
	OR  A
	JR  Z,disparo_horizontal_midP
	LD  A,(IX+_SVEL_X)
	OR  A
	JR  Z,disparo_vertical_midP
	LD  A,(TABLA_OBJETOS+10)
	OR  A
	JR  Z,long_maxima1_midP
	LD  (IX+_SLONGITUD),LONG_DISPARO_OB
	JR  sigue_longitud1_midP
long_maxima1_midP
	LD  (IX+_SLONGITUD),255
sigue_longitud1_midP
disparo_vertical_midP
disparo_horizontal_midP
	LD	HL,BALA_EXP
	LD	(IX+_SDIRECCION),L
	LD	(IX+_SDIRECCION+1),H
	RET

mata_al_malo_pero_nada_mas
	LD      A,(Choq_MALOS_desde_DISP)
	LD      IY,SPRITE0
	LD      DE,LONG_SPRITES
situa_IY_Malos_cd1
	ADD     IY,DE
	RRA
	JR      NC,situa_IY_Malos_cd1
	SET     CHECK_MUERTE_DESDE,(IY+_CHECKS)
no_actives_disparo_cd
	LD      (IX+_SESTADO),0
	LD      B,0
	LD      C,(IX+_SID)
	LD      HL,Tabla_INT
	ADD     HL,BC
	LD      (HL),0
	RET
no_actives_disparo_y_explota_cd
	LD      (IX+_SESTADO),4
	RET

control_disparo_parabola_ini
	LD   HL,control_disparo_parabola
	LD   (IX+_SMOVIMIENTO),L
	LD   (IX+_SMOVIMIENTO+1),H

	LD   A,(IX+_SID)
	JP 	 Actualiza_Tabla_INT_cfp_isp_ibp

;Disparo de las plantas
control_disparo_parabola
	LD	 A,(IX+_SESTADO)
	OR   A
	RET  Z

	LD	A,(IX+_SESTADO)
	cp  #fe
	jP  z,elimina_definitivamente_cd

	LD   HL,PATH_PARABOLA
	LD   B,0
	LD   C,(IX+_SVEL_Y)
	ADD  HL,BC
	LD   A,(HL)
	CP   255
	JR   Z,coge_valores_fijos_cdp
	INC  (IX+_SVEL_Y)
	INC  (IX+_SVEL_Y)
	LD   B,A		;EN B EL INCREMENTO DE X
	LD   A,(IX+_SVEL_X)
	CP   128
	LD   A,B
	JR   NC,es_positivo_cdp
	NEG
es_positivo_cdp
	ADD  (IX+_SX)
	LD   (IX+_SX),A
	INC  HL
	LD   A,(HL)
	LD   B,A
	JR   calcula_y_cdp
coge_valores_fijos_cdp
	INC  HL
	LD   A,(HL)
	LD   B,4
calcula_y_cdp
	LD   A,B
	ADD  (IX+_SY)
	LD   (IX+_SY),A

	CALL comprueba_coordenadas_dp
	LD   A,(IX+_SESTADO)
	OR   A
	ret  Z

	CALL choque_malos
	JR   C,final_disparo_sin_estado

	LD   IY,SPRITE0
	LD	 HL,SPRITE0_CHECKS
	BIT	 CHECK_CAMBIO,(HL)
	JR   NZ,no_detectes_colision_DP
	CALL rectangles_collide
; 	JR   C,final_disparo_sin_estado		;NO MUERTE
	JP   C,desactiva_disparo_mata_DP
no_detectes_colision_DP

	LD   A,(IX+_SID)
	CALL Actualiza_Tabla_INT_cfp_isp_ibp
	CALL Actualiza_Tabla_INT_UPD
	LD   HL,BALA_ACIDO
	LD	(IX+_SDIRECCION),L
	LD	(IX+_SDIRECCION+1),H
	RET

final_disparo
	LD   (IX+_SESTADO),0
final_disparo_sin_estado
	LD   A,(IX+_SID)
	CALL Actualiza_Tabla_INT_ibp
	RET

comprueba_coordenadas_dp
	LD   A,(IX+_SESTADO)
	OR	 A
	RET  Z

	LD   A,(IX+_X)
	CP	 79
	JP   NC,elimina_disparo_CD

	LD   A,(IX+_Y)
	CP   40
	JP   C,elimina_disparo_CD

	LD   A,(IX+_Y)
	CP   192
	JP   NC,elimina_disparo_CD

	RET

desactiva_disparo_mata_DP
	SET     CHECK_MUERTE_DESDE,(IY+_CHECKS)
	LD      A,(SPRITE0_MIRADA)
	OR      A
	JR      NZ,izquierda_prota_DP
	BIT     1,(IX+_signos)
	JR      NZ,desactiva_disparo_DP
	LD      (IY+_MIRADA),IZQUIERDA
	Jp      elimina_disparo_CD
izquierda_prota_DP
	BIT     1,(IX+_signos)
	JR      Z,desactiva_disparo_DP
	LD      (IY+_MIRADA),DERECHA
desactiva_disparo_DP
	jp      elimina_disparo_CD

;disparo tipo Evaristo
control_disparo_malo_ini
	LD      IY,SPRITE0
	CALL    rectangles_collide
	RET  C
	CALL 	ejecute_ini_evaristo
	LD      HL,control_disparo_malo
	LD      (IX+_SMOVIMIENTO),L
	LD      (IX+_SMOVIMIENTO+1),H
	LD      (IX+_SESTADO),#FF
	LD      A,(IX+_SID)
	JP      Actualiza_Tabla_INT_cfp_isp_ibp

control_disparo_malo
	LD		A,(IX+_SESTADO)
	OR      A
	RET     Z

	LD	A,(IX+_SESTADO)
	CP	#FD
	CALL 	Z,final_disparo

	;ejecuta Evaristo
	CALL    eje_Evaristo

	CALL	comprueba_coordenadas_cdm_coord

	CALL    es_obstaculo_disp
	JR      NZ,desactiva_disparo_cdm

	LD      A,(IX+_SESTADO)
	OR      A
	RET     Z

	LD      IY,SPRITE0
	CALL    rectangles_collide
; 	JR      C,no_pintes_CDM					;NO MUERTE
	JR      C,desactiva_disparo_mata_cdm

	;imprimo sprite
	LD      HL,BALA_VARYLIO
	LD      (IX+_SDIRECCION),L
	LD      (IX+_SDIRECCION+1),H

	CALL    choque_malos
	JR      C,no_pintes_CDM

	LD      A,(IX+_SID)
	CALL    Actualiza_Tabla_INT_cfp_isp_ibp
	;capturo buffer
	;CALL	Captura_Fondo_Bala

;         LD      A,(IX+_SX)
;         LD      (IX+_SANTX),A
;         LD      A,(IX+_SY)
;         LD      (IX+_SANTY),A

	RET

no_pintes_CDM
	LD      A,(IX+_SID)
	CALL 	Actualiza_Tabla_INT_ibp
	RET

	;JP  Actualiza_Tabla_INT_isp
	;JP	Imprime_Sprite_Bala_Puntero

desactiva_disparo_mata_cdm
   	BIT     CHECK_INVULNERABLE,(IY+_CHECKS)
	LD      a,FX_imp_disp_prota
	CALL    Z,Toca_FX_Pos
	SET     CHECK_MUERTE_DESDE,(IY+_CHECKS)
	LD      A,(IY+_MIRADA)
	OR      A
	JR      NZ,izquierda_prota_cdm
	BIT     1,(IX+_signos)
	JR      NZ,desactiva_disparo_cdm
	LD      (IY+_MIRADA),IZQUIERDA
	JR      desactiva_disparo_cdm
izquierda_prota_cdm
	BIT     1,(IX+_signos)
	JR      Z,desactiva_disparo_cdm
	LD      (IY+_MIRADA),DERECHA
desactiva_disparo_cdm
	LD      (IX+_SESTADO),0
	LD      A,(IX+_SID)
	JP      Actualiza_Tabla_INT_ibp

comprueba_coordenadas_cdm_coord
	LD   A,(IX+_SESTADO)
	OR	 A
	RET  Z

	LD   A,(IX+_X)
	CP	 79
	JR   NC,desactiva_disparo_cdm

	LD   A,(IX+_Y)
	CP   40
	JR   C,desactiva_disparo_cdm

	LD   A,(IX+_Y)
	CP   192
	JR   NC,desactiva_disparo_cdm

	RET


ejecute_ini_evaristo
; 	LD      A,(SEMAFORO_CALC_EVARISTO)
; 	OR      A
; 	RET     NZ
; 	INC     A
; 	LD      (SEMAFORO_CALC_EVARISTO),A
	LD      C,(IX+_SVEL_X)
	LD      E,(IX+_SVEL_Y)
	LD		(IX+_SVEL_Y),0	;aprovecho esto para los decimales de Y
	LD		(IX+_SVEL_X),0	;aprovecho esto para los decimales de X
	LD      B,(IX+_X)
	LD      D,(IX+_Y)
	LD      (IX+_SESTADO),255

ini_Evaristo
;    Funcion LineaEvaristo( X1, X2, Y1, Y2 )
;			     B   Cs  D   Es

;calculo dY y lo almaceno en _dY
	XOR  A
	res  0,(IX+_signos)
	LD   A,E
	SUB  D
	JP   P,es_positivo_dY
	set  0,(IX+_signos)
	NEG
es_positivo_dY
	LD   L,A
	LD   H,0
	SRA  L
	;RL   H
	;SLA  L
	;RL   H
	LD   (IX+_dY),L
	;LD   (IX+_dY+1),H
	OR   A
	JR   Z,no_power_Y
	push bc
	push de
	CALL power_hl
	pop  de
	pop  bc
no_power_Y
	PUSH HL

;calculo dX y lo almaceno en -dX multiplicado por 4
	XOR  A
	res  1,(IX+_signos)
	LD   A,C
	SUB  B
	JP   P,es_positivo_dX
	set  1,(IX+_signos)
	NEG
es_positivo_dX
	LD   L,A
	LD   H,0
	SLA  L
	RL   H
	;SLA  L
	;RL   H
	LD   (IX+_dX),L
	;LD   (IX+_dX+1),H
	OR   A
	JR   Z,no_power_X
	CALL power_hl
no_power_X

	POP  DE
	ADD  HL,DE

	LD   A,L
	LD   L,H
	CALL sqrt_la

 	LD   B,(IX+_dX)
	LD   C,0
	LD   E,D
	LD   D,0
	push de
	CALL BC_div_DE
	LD   (IX+_dX),C
	LD   (IX+_dX+1),A

	LD   B,(IX+_dY)
	LD   C,0
	pop  de
	CALL BC_div_DE
	SLA  C
	RL   A
	SLA  C
	RL   A
	LD   (IX+_dY),C
	LD   (IX+_dY+1),A
	RET
; 	JP	Imprime_Sprite_Bala

eje_Evaristo
	LD   A,(IX+_SESTADO)
	OR   A
	RET  Z
	LD   A,(IX+_signos)
	LD   H,(IX+_X)
	LD   L,(IX+_SVEL_X)
	LD   E,(IX+_dX)
	LD   D,(IX+_dX+1)
	BIT  1,A
	JR   NZ,restox_eb
	ADD  HL,DE
	JR   siguex_be
restox_eb
	XOR  A
	SBC  HL,DE
siguex_be
	LD   (IX+_X),H
	LD   (IX+_SVEL_X),L

	LD   A,(IX+_signos)
	LD   H,(IX+_Y)
	LD   L,(IX+_SVEL_Y)
	LD   E,(IX+_dY)
	LD   D,(IX+_dY+1)
	BIT  0,A
	JR   NZ,restoy_eb
	ADD  HL,DE
	JR   siguey_be
restoy_eb
	XOR  A
	SBC  HL,DE
siguey_be
	LD   (IX+_Y),H
	LD   (IX+_SVEL_Y),L

	RET


;-------------------------------
;Square Root
;Inputs:
;LA = number to be square rooted
;Outputs:
;D  = square root


sqrt_la:
	ld	de, #0040	; 40h appends "01" to D
	ld	h, d

	ld	b, 7

	; need to clear the carry beforehand
	or	a

_loop:
	sbc	hl, de
	jr	nc, $+3
	add	hl, de
	ccf
	rl	d
	rla
	adc	hl, hl
	rla
	adc	hl, hl

	djnz	_loop

	sbc	hl, de		; optimised last iteration
	ccf
	rl	d

	ret

;potencia de l y lo deja en hl
power_hl:
	ld      b,h
	ld      c,l
	ld      d,h
	ld      e,l
	ld      hl,0
power_hl_cont
	add     hl,de
	dec     bc
	ld      a,c
	or      b
	jr      nz,power_hl_cont
	ret

;resultado en AC
BC_div_DE
	LD   HL,0
	LD   A,B
	LD   B,16
buc_div
	SLL  C
	RLA
	ADC  HL,HL
	SBC  HL,DE
	JR   NC,$+4
	ADD  HL,DE
	DEC  C
	DJNZ buc_div
	RET
