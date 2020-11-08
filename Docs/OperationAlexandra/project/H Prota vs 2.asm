; Rutina para controlar el movimiento del ruso
;se inicia con modo reposo
Update_Prota
	;control de la cadencia de disparo
	;si hay cadencia activada, la decremento
	LD	A,(Cadencia_Disparo)
	OR  A
	JR	Z,no_hay_cadencia_UP
	DEC	A
	LD	(Cadencia_Disparo),A
no_hay_cadencia_UP
	LD 	A,(SPRITE0_ESTADOS)
	;si tiene que respingar, respinga
	BIT	ESTADO_RESPINGO,A
	JP	NZ,Prota_muriendo_UP
	BIT	CHECK_MUERTE,(IX+_CHECKS)
	JP	NZ,inicio_morir_Prota
	BIT	CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR	NZ,mata_prota_snUP
	;Si está reposando voy a la rutina de reposo
	BIT	ESTADO_REPOSAR,A
	JP  NZ,Prota_reposando_UP
	;Si está saltando voy a la rutina de salto
	BIT	ESTADO_SALTAR,A
	JP  NZ,Prota_saltando_UP
	;Si está cayendo voy a la rutina de caida
	BIT	ESTADO_CAER,A
	JP  NZ,Prota_cayendo_UP
	;Si está andando voy a la rutina de andar
	BIT	ESTADO_ANDAR,A
	JP  NZ,Prota_andando_UP
	;Si está aterrizando voy a la rutina de aterrizaje
	BIT	ESTADO_ATERRIZAR,A
	JP  NZ,Prota_aterrizando_UP
	;Si está agachandose voy a la rutina de agachar
	BIT	ESTADO_AGACHAR,A
	JP  Prota_agachando_UP
;	ret
	;aqui no debería llegar

salir_muerte_UP
;salida normal de la rutina donde activa el redibujado del sprite0
;salir_normal_UP
;	BIT	CHECK_MUERTE_DESDE,(IX+_CHECKS)
;	JR	NZ,mata_prota_snUP
;	jp	mueve_prota_snUP

mata_prota_snUP
	LD      A,(IX+_CHECKS)
	BIT     CHECK_CAMBIO,A
	JR      NZ,mueve_prota_snUPn
	BIT     CHECK_INVULNERABLE,A
	JR      NZ,decrementa_invul_snUP
	SET		CHECK_MUERTE,A
	RES		CHECK_MUERTE_DESDE,A
	LD      (IX+_CHECKS),A
	LD      A,FX_imp_enem_prota
; 	push    bc
	CALL    Toca_FX_Pos
; 	pop     bc
	CALL    Decrementa_vida
	JR		mueve_prota_snUPn

salir_normal_UP
mueve_prota_snUP
	BIT     CHECK_INVULNERABLE,(IX+_CHECKS)
	JR      NZ,decrementa_invul_snUP
mueve_prota_snUPn
	LD   	A,(SPRITE0_ID)
	JP 		Actualiza_Tabla_INT_cfp_isp_ibp
	;CALL 	Actualiza_Tabla_INT_isp
	;JP   	Actualiza_Tabla_INT_ibp
decrementa_invul_snUP
	RES		CHECK_MUERTE,(IX+_CHECKS)
	RES		CHECK_MUERTE_DESDE,(IX+_CHECKS)
	LD		A,(Invulnerable)
	DEC     A
	LD		(Invulnerable),A
	JR		NZ,mueve_prota_snUPn
	RES     CHECK_INVULNERABLE,(IX+_CHECKS)
	JR		mueve_prota_snUPn

;----------------
;ESTADO REPOSANDO
;----------------
;en este estado está esperando pulsación de alguna tecla para activar el estado correspondiente
;además comprueba constantemente si puede caer o no por si se retira algún obstáculo
Prota_reposando_UP
	;si puede caer, cae
	LD		A,2			;la caida, incialmente es de 2 no de GRAVEDAD
	CALL	Puedo_Ir_a_Abajo
	JP      NC,inicio_cambio_pantalla_Ab_UP
	JR      NZ,no_cae_prUP

	LD		C,(IX+_Y)
	LD		A,2			;la caida, inicialmente es de 2 no de GRAVEDAD
	ADD		A,C
	LD		(SPRITE0_Y),A
	CALL	choque_malos_disparos
	JR		C,devuelve_prUP
	CALL	inicio_caer_prota;Prota_cayendo_UP
	JR		mueve_prota_snUPn
devuelve_prUP
	CALL    inicio_estado_muere_Prota
	LD		(IX+_Y),C

no_cae_prUP
	;si no está en estado de reposo lo inicio
	BIT     ESTADO_REPOSAR,(IX+_ESTADOS)
	JR      Z,inicio_pr_UP
	;compruebo que no se esté pulsando el botón de acción
	LD		A,(TECLADO0)
	BIT		JOY_FIRE1,A
	;si se está pulsando activo el disparo
	JP      NZ,Prota_disparando_UP
	;activo salto si pulso la tecla de salto
	BIT		JOY_UP,A
	JR		Z,noup_prUP
	CALL	inicio_saltar_Prota
	JR		mueve_prota_snUPn
	;si pulso derecha o izquierda empiezo a caminar
noup_prUP
	BIT		JOY_LEFT,A
	JR      NZ,Prota_andando_UP;_inii
	BIT		JOY_RIGHT,A
	JR		NZ,Prota_andando_UP;_inid
	;activo agacharse si pulso abajo
	BIT		JOY_DOWN,A
	JR		Z,nodown_prUP
	CALL	inicio_agachar_Prota
	JR		mueve_prota_snUPn
nodown_prUP
	;si llega aqui es pq no hay nada pulsado
	;compruebo si hay disparo, pq tiene que acabar en frame 11
	BIT     ESTADO_DISPARAR,(IX+_ESTADOS)
	JR      Z,salir_normal_UP
	LD		A,(SPRITE0_SPR_A)
	CP		11
	JR		Z,inicio_pr_UP
	CALL	siguiente_sprite
	JP		salir_normal_UP
	;si ha terminado el disparo, vuelvo a reiniciar el reposo
inicio_pr_UP
	CALL    inicio_reposar_Prota
	JP		salir_normal_UP

; Prota_andando_UP_inii
; 	LD		A,1
; 	CALL	Puedo_Ir_a_Izquierda
; 	LD		(IX+_MIRADA),IZQUIERDA
; 	JR      Z,Prota_andando_UP_ini
; 	JR      NC,Prota_andando_UP_ini
; reposar_otra_vez
; 	CALL	inicio_reposar_Prota
; 	JP		salir_normal_UP
; Prota_andando_UP_inid
; 	LD		A,1+6
; 	CALL	Puedo_Ir_a_Derecha
; 	LD		(IX+_MIRADA),DERECHA
; 	JR      Z,Prota_andando_UP_ini
; 	JR      NC,Prota_andando_UP_ini
; 	JR      reposar_otra_vez
; Prota_andando_UP_ini
; 	;tengo que hacer call, pq si no puede avanzar, vuelve a estado reposo
; 	CALL    inicio_andar_Prota
; 	JP		salir_normal_UP

;--------------
;ESTADO ANDANDO
;--------------
;en este estado espera las pulsaciones correspondientes al estado de andar
;además comprueba constantemente si puede caer o no por si se retira algún obstáculo
Prota_andando_UP
	RES    CHECK_SOBRE_MALO,(IX+_CHECKS)
	;si puedo caer, cambio estado a cayendo
	LD		A,2			;la caida, incialmente es de 2 no de GRAVEDAD
	CALL	Puedo_Ir_a_Abajo
	JP      NC,inicio_cambio_pantalla_Ab_UP
	JR      NZ,no_cae_paUP

	LD		C,(IX+_Y)
	LD		A,2			;la caida, incialmente es de 2 no de GRAVEDAD
	ADD		A,C
	LD		(SPRITE0_Y),A
	CALL	choque_malos_disparos

	JR		C,devuelve_paUP
	CALL 	inicio_caer_Prota 				;Prota_cayendo_UP
	JP		mueve_prota_snUPn
devuelve_paUP
	SET     CHECK_SOBRE_MALO,(IX+_CHECKS)
	LD	    (IX+_Y),C
    BIT     CHECK_INVULNERABLE,(IX+_CHECKS)
    CALL    Z,inicio_estado_muere_Prota

no_cae_paUP
	;si no está activado el andar, lo inicio
	BIT     ESTADO_ANDAR,(IX+_ESTADOS)
	;tengo que hacer call, pq si no puede avanzar, vuelve a estado reposo
	CALL    Z,inicio_andar_Prota

	;Puedo andar, así que ando
	LD      A,(TECLADO0)
reposar_pa_UP
	;si se pulsa disparo, detengo la animación y disparo
	BIT     JOY_FIRE1,A
	JP      NZ,Prota_disparando_UP
	;si no está pulsado el disparo, restablezco los sprites y su dirección
	;por si vengo de estar disparando. Si no vengo de estar disparando no tendrá efecto
	LD		(IX+_SPR),7
	LD		HL,DSPR_PROTA_ANDAR
	LD		(SPRITE0_DSPR),HL
	;compruebo si me tengo que agachar y agacho si hace falta
agacharse_pa_UP
	BIT		JOY_DOWN,A
	JR      Z,saltar_pa_UP
	CALL	inicio_agachar_Prota
	JP		mueve_prota_snUPn
	;compruebo si tengo que saltar y salto si hace falta
saltar_pa_UP
	BIT		JOY_UP,A
	JR      Z,izquierda_pa_UP
	CALL	inicio_saltar_Prota
	JP		mueve_prota_snUPn
	;si no ha pulsado otra teclas, entonces se desplaza a derecha o izquierda
izquierda_pa_UP
	BIT     JOY_LEFT,A
	JR      Z,derecha_pa_UP
	LD		A,1
	CALL	Puedo_Ir_a_Izquierda
	LD		(IX+_MIRADA),IZQUIERDA
	JR		NC,inicio_cambio_pantalla_Iz_UP
	JR      Z,decrementa_ip_UP
	;si no me puedo mover, reposo
vuelve_a_reposo_pa_UP
	CALL	inicio_reposar_Prota
	JP      salir_normal_UP
decrementa_ip_UP
	;si me puedo mover, decremento la X e incremento el sprite
	DEC		(IX+_X)
	CALL    choque_propio_disparo
	JR      C,no_avanzo_dipUP
	CALL	choque_malos_disparos;_hor
	JR		NC,no_muevo_ddpUP
	CALL    inicio_estado_muere_Prota
no_avanzo_dipUP
	INC		(IX+_X)
no_muevo_ddpUP
	CALL	siguiente_sprite
	JP      salir_normal_UP
derecha_pa_UP
	BIT     JOY_RIGHT,A
	JR      Z,vuelve_a_reposo_pa_UP
	LD		A,1+6
	CALL	Puedo_Ir_a_Derecha
	LD		(IX+_MIRADA),DERECHA
	JR		NC,inicio_cambio_pantalla_De_UP
	JP		Z,incrementa_dp_UP
	;si no me puedo mover voy a reposo
	JR      vuelve_a_reposo_pa_UP
incrementa_dp_UP
	;si me puedo mover, incremento X e incremento el sprite
	INC		(IX+_X)
	CALL    choque_propio_disparo
	JR      C,no_avanzo_ddpUP
	CALL	choque_malos_disparos;_hor
	JR		NC,no_muevo_ddpUP
	CALL    inicio_estado_muere_Prota
no_avanzo_ddpUP
	DEC		(IX+_X)
	JR      no_muevo_ddpUP

;cambio a pantalla derecha
inicio_cambio_pantalla_De_UP
	CALL pantalla_derecha
	JP   salir_normal_UP

pantalla_derecha
	LD	A,(DATOS_PANTALLA_ACTUAL+1)
	CP	#FF
	RET	Z
	CP  42
	JR  NZ,cambia_pant_der
	LD  A,(SPRITE5_VIDA)
	OR  A
	RET NZ
	LD	A,(DATOS_PANTALLA_ACTUAL+1)
cambia_pant_der
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	(IX+_X),0
	LD	(IX+_ANTX),0
	RET

;cambio a pantalla izquierda
inicio_cambio_pantalla_Iz_UP
	CALL    pantalla_izquierda
	JP      salir_normal_UP

pantalla_izquierda
	LD	A,(DATOS_PANTALLA_ACTUAL+0)
	CP	#FF
	RET Z
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD	A,ANCHO_MAPA_BYTES
	SUB	(IX+_ANCHO)
	LD	(SPRITE0_X),A
	LD	(SPRITE0_ANTX),A
	RET

;cambio a pantalla abajo
inicio_cambio_pantalla_Ab_UP
	CALL    pantalla_abajo
	JP      salir_normal_UP

pantalla_abajo
	LD	A,(DATOS_PANTALLA_ACTUAL+3)
	CP	#FF
	RET Z
	SET	CHECK_CAMBIO,(IX+_CHECKS)
	LD	(Pantalla_Siguiente),A
	LD  A,40
	LD	(SPRITE0_Y),A
	LD	(SPRITE0_ANTY),A
	RET

pantalla_arriba
	LD		A,(DATOS_PANTALLA_ACTUAL+2)
	CP		#FF
	RET     Z
	SET		CHECK_CAMBIO,(IX+_CHECKS)
	LD		(Pantalla_Siguiente),A
	LD		A,ALTO_MAPA_BYTES
	SUB		(IX+_ALTO)
	LD		(IX+_Y),A
	LD		(IX+_ANTY),A
	RET
;---------------
;ESTADO SALTANDO
;---------------
;en este estado espera las pulsaciones correspondientes al estado de saltar
Prota_saltando_UP
	;si no está activado el estado de salto, lo activo
	;BIT     ESTADO_SALTAR,(IX+_ESTADOS)
	;CALL    Z,inicio_saltar_Prota
	;hago el camino del salto. El estado finalizará cuando acabe el camino
; 	LD  	HL,(SPRITE0_PATH)
	CALL 	haz_camino
; 	LD   	(SPRITE0_PATH),HL
	BIT		CHECK_CAMBIO,(IX+_CHECKS)
	JP 		NZ,salir_normal_UP
	;si he acabado el camino es que tengo que aterrizar
	BIT  	CHECK_PATH,(IX+_CHECKS)
	JP   	Z,aterriza_pc_UP
	;si no ha acabado el camino, puedo disparar y moverme a derecha e izquierda
	;si disparo, activo la animación del disparo
	BIT     ESTADO_DISPARAR,(IX+_ESTADOS)
	JR      Z,continua_saltando_ps_UP
	LD		A,(SPRITE0_SPR_A)
	CP		11
	;continuo saltando después de un disparo, pero sin actualizar el PATH que debe continuar
	CALL    Z,inicio_saltar_Prota_sin_PATH
	;si al saltar se tocan derecha o izquierda o fuego, actua
continua_saltando_ps_UP
	;si pulso acción, disparo
	LD      A,(TECLADO0)
	BIT     JOY_FIRE1,A
	CALL	NZ,Prota_disparando_UP
	;sigo mirando si hay que mover a izquierda o derecha
	;si hay algún disparo en 255 no me puedo mover
	LD      A,(TECLADO0)
	BIT     JOY_LEFT,A
	JR      Z,derecha_ps_UP
	LD		A,1
	CALL	Puedo_Ir_a_Izquierda
	LD		(IX+_MIRADA),IZQUIERDA
	JP		NC,inicio_cambio_pantalla_Iz_UP
	JP      NZ,salir_normal_UP
	DEC		(IX+_X)
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JR      hay_choque_ps_UPX
derecha_ps_UP
	BIT     JOY_RIGHT,A
	JP      Z,comprueba_choque_sin_mov_ps_UP ;salir_normal_UP
	LD		A,1+6
	CALL	Puedo_Ir_a_Derecha
	LD		(IX+_MIRADA),DERECHA
	JP		NC,inicio_cambio_pantalla_De_UP
	JP		NZ,salir_normal_UP

	INC		(IX+_X)
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JR      hay_choque_ps_UPX

comprueba_choque_sin_mov_ps_UP
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
hay_choque_ps_UP
	LD      A,(SPRITE0_ANTY)
	LD      (SPRITE0_Y),A
hay_choque_ps_UPX	
	LD      A,(SPRITE0_ANTX)
	LD      (SPRITE0_X),A
	CALL    inicio_estado_muere_Prota
	JP      Z,salir_normal_UP
	CALL    inicio_reposar_Prota
	JP      salir_normal_UP

;CHECK MURIENDO
;--------------
;en este estado respinga hacia el contrario de donde esté
Prota_muriendo_UP
	;si no está activado el estado de salto, lo activo
; 	BIT     ESTADO_RESPINGO,(IX+_ESTADOS)
; 	CALL    Z,inicio_morir_Prota
	;hago el camino del salto. El estado finalizará cuando acabe el camino
; 	LD  	HL,(SPRITE0_PATH)
	CALL 	haz_camino
; 	LD   	(SPRITE0_PATH),HL

	;si he acabado el camino es que tengo que aterrizar
	BIT  	CHECK_PATH,(IX+_CHECKS)
	JR   	Z,vete_aterriza_pc_UP
	;muevo en horizontal
	LD		A,(SPRITE0_MIRADA)
	OR		A
	JR      NZ,mueve_derecha_pmUP
	LD		A,2
	CALL	Puedo_Ir_a_Izquierda
	JP		NC,inicio_cambio_pantalla_Iz_UP
	JP		NZ,salir_normal_UP
	DEC		(IX+_X)
	DEC		(IX+_X)
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JR      hay_choque_ps_UP

mueve_derecha_pmUP
	LD		A,2+6
	CALL	Puedo_Ir_a_Derecha
	JP		NC,inicio_cambio_pantalla_De_UP
	JP		NZ,salir_normal_UP

	INC		(IX+_X)
	INC		(IX+_X)
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JR      hay_choque_ps_UP

vete_aterriza_pc_UP
	LD		A,GRAVEDAD
	CALL	Puedo_Ir_a_Abajo
	JP      NC,inicio_cambio_pantalla_Ab_UP
	JP		NZ,aterriza_pc_UP
	CALL    inicio_caer_prota ;Prota_cayendo_UP
	JP      salir_normal_UP

;**************
;ESTADO CAYENDO
;--------------
;en este estado espera las pulsaciones correspondientes al estado de caer
Prota_cayendo_UP
	;si no está activado el estado de caida, lo activo
; 	BIT     ESTADO_CAER,(IX+_ESTADOS)
; 	CALL    Z,inicio_caer_Prota
	;hago el camino de la caida. El estado finalizará cuando acabe el camino
; 	LD  	HL,(SPRITE0_PATH)
	CALL 	haz_camino
; 	LD   	(SPRITE0_PATH),HL
    jr      C,no_bucle_caida_pcU
	ld      a,(hl)
	cp      255
	jr      nz,no_bucle_caida_pcU
	dec		HL
	LD  	(SPRITE0_PATH),HL
no_bucle_caida_pcU
	;si he acabado el camino es que tengo que aterrizar
	BIT  	CHECK_PATH,(IX+_CHECKS)
	JR   	Z,aterriza_pc_UP
	;si no ha acabado el camino, puedo disparar y moverme a derecha e izquierda
	;si disparo, activo la animación del disparo
	BIT     ESTADO_DISPARAR,(IX+_ESTADOS)
	JR      Z,continua_cayendo_pc_UP
	LD		A,(SPRITE0_SPR_A)
	CP		11
	JR		NZ,continua_cayendo_pc_UP
inicio_pc_UP
	;continuo cayendo después de un disparo, pero sin actualizar el PATH que debe continuar
	CALL    inicio_caer_Prota_sin_PATH
	;si al caer se tocan derecha o izquierda o fuego, actua
continua_cayendo_pc_UP
	;si pulso accion, disparo
	LD      A,(TECLADO0)
	BIT     JOY_FIRE1,A
	CALL	NZ,Prota_disparando_UP
	;sigo mirando si hay que mover a izquierda o derecha
	LD      A,(TECLADO0)
	BIT     JOY_RIGHT,A
	JR      Z,izquierda_pc_UP
	LD		A,1+6
	CALL	Puedo_Ir_a_Derecha
	LD		(IX+_MIRADA),DERECHA
	JP		NC,inicio_cambio_pantalla_De_UP
	JP		NZ,salir_normal_UP

	INC		(IX+_X)
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JP      hay_choque_ps_UPX
izquierda_pc_UP
	BIT     JOY_LEFT,A
	JP      Z,comprueba_choque_sin_mov_ps_UP
	LD		A,1
	CALL	Puedo_Ir_a_Izquierda
	LD		(IX+_MIRADA),IZQUIERDA
	JP		NC,inicio_cambio_pantalla_Iz_UP
	JP      NZ,salir_normal_UP
	DEC		(IX+_X)
	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JP      hay_choque_ps_UPX

aterriza_pc_UP
	CALL	inicio_aterrizar_Prota
	JP		salir_normal_UP

;cuando toca suelo en un salto o caida entra en estado aterrizaje, del cual no se puede salir hasta que no termina
;ESTADO ATERRIZANDO
;------------------
Prota_aterrizando_UP
	;activo el estado de aterrizaje si no se habia entrado todavía
; 	BIT     ESTADO_ATERRIZAR,(IX+_ESTADOS)
; 	CALL    Z,inicio_aterrizar_Prota
	;hago el camino
; 	LD  	HL,(SPRITE0_PATH)
	CALL 	haz_camino
; 	LD   	(SPRITE0_PATH),HL
	;si he acabado el camino es que tengo que reposar
	BIT  	CHECK_PATH,(IX+_CHECKS)
	JP   	Z,Prota_reposando_UP

	CALL	choque_malos_disparos
	JP		NC,salir_normal_UP
	JP      hay_choque_ps_UP

;ESTADO AGACHANDO
;----------------
Prota_agachando_UP
	;si puedo caer, cambio estado a cayendo
	LD		A,GRAVEDAD
	CALL	Puedo_Ir_a_Abajo
	JP      NC,inicio_cambio_pantalla_Ab_UP
	JR      NZ,no_cae_pagUP

	LD		C,(IX+_Y)
	LD		A,GRAVEDAD
	ADD		A,C
	LD		(SPRITE0_Y),A
	CALL	choque_malos_disparos
	JR		C,devuelve_pagUP
	CALL	inicio_caer_prota;Prota_cayendo_UP
	JP		mueve_prota_snUPn
devuelve_pagUP
	CALL    inicio_estado_muere_Prota
	LD		(IX+_Y),C

no_cae_pagUP
	BIT     ESTADO_AGACHAR,(IX+_ESTADOS)
	CALL    Z,inicio_agachar_Prota

	LD      A,(TECLADO0)
	BIT     JOY_FIRE1,A
	JP      NZ,Prota_disparando_UP

	BIT		JOY_LEFT,A
	JR      Z,derecha_pag_UP
	LD		(IX+_MIRADA),IZQUIERDA
derecha_pag_UP
	BIT		JOY_RIGHT,A
	JR      Z,arriba_pag_UP
	LD		(IX+_MIRADA),DERECHA
arriba_pag_UP
	BIT     JOY_UP,A
	JR		Z,noup_pagUP
	CALL	inicio_saltar_Prota
	JP		salir_normal_UP
noup_pagUP
	BIT		JOY_DOWN,A
	JR		NZ,down_pagUP
	CALL	inicio_reposar_Prota
	JP		salir_normal_UP
down_pagUP
	BIT     ESTADO_DISPARAR,(IX+_ESTADOS)
	JP      Z,salir_normal_UP
	LD		A,(SPRITE0_SPR_A)
	CP		11
	JP		Z,inicio_pa_UP
	CALL	siguiente_sprite
	JP		salir_normal_UP
inicio_pa_UP
	CALL    inicio_agachar_Prota
	JP		salir_normal_UP

;-----------------
;ESTADO DISPARANDO
;-----------------
Prota_disparando_UP
	BIT     ESTADO_DISPARAR,(IX+_ESTADOS)
	CALL    Z,inicio_disparar_Prota

	;si está saltando o cayendo no salta al siguiente sprite
	BIT     ESTADO_SALTAR,(IX+_ESTADOS)
	JR      NZ,no_saltes_sprite_pd_UP
	BIT     ESTADO_CAER,(IX+_ESTADOS)
	JR      NZ,no_saltes_sprite_pd_UP
	CALL	siguiente_sprite
no_saltes_sprite_pd_UP

	LD      (IX+_SPR),11

	LD      A,(TECLADO0)
	BIT		JOY_FIRE1,A
	JP      Z,Prota_reposando_UP

	LD		A,(Cadencia_Disparo)
	OR		A
	JR		NZ,no_dispares_ahora_pd_UP
	LD		A,INTERVALO_DISPARO
	LD		(Cadencia_Disparo),A
; 	push    ix

 	CALL	inicia_disparo_Prota
; 	pop     ix
no_dispares_ahora_pd_UP
	BIT		ESTADO_CAER,(IX+_ESTADOS)
	JR		Z,selecciona_direccion_pd_UP1

	LD		HL,DSPR_PROTA_DISPARO_S
	LD		(SPRITE0_DSPR),HL

	RET

selecciona_direccion_pd_UP1
	BIT		ESTADO_SALTAR,(IX+_ESTADOS)
	JR		Z,selecciona_direccion_pd_UP2

	LD		HL,DSPR_PROTA_DISPARO_S
	LD		(SPRITE0_DSPR),HL
	RET

selecciona_direccion_pd_UP2
	LD		HL,DSPR_PROTA_DISPARO
	LD		B,0
	LD		A,(TECLADO0)
	BIT		JOY_LEFT,A
	JR      Z,derecha_pd_UP
	LD		(IX+_MIRADA),IZQUIERDA
	LD      B,1
derecha_pd_UP
	BIT		JOY_RIGHT,A
	JP      Z,arriba_pd_UP
	LD		(IX+_MIRADA),DERECHA
	LD		B,1
arriba_pd_UP
	BIT		JOY_UP,A
	JR		Z,abajo_pd_UP
	LD		A,B
	OR		A
	JR		Z,vertical_pd_UP
	LD		HL,DSPR_PROTA_DISPARO_O
	JR		salir_pd_UP
vertical_pd_UP
	LD		HL,DSPR_PROTA_DISPARO_V
	JR		salir_pd_UP
abajo_pd_UP
	BIT		JOY_DOWN,A
	JR		Z,salir_pd_UP
	LD		HL,DSPR_PROTA_DISPARO_A
salir_pd_UP
	LD		(SPRITE0_DSPR),HL
	JP		salir_normal_UP

inicio_disparar_Prota
	;longitud en la animación
	LD      A,11
	LD		(SPRITE0_SPR),A
	LD		(SPRITE0_SPR_A),A
	;activo el estado disparo y mantengo el reposo
	LD      A,(SPRITE0_ESTADOS)
	SET     ESTADO_DISPARAR,A		;respeto el resto de estados
	;AND     %01100001			;dejo como estaban agachar y reposo
	LD      (SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_DISPARO
	LD		(SPRITE0_DSPR),HL
	RET

inicio_estado_muere_Prota
	LD      A,(Choq_DISP)
	OR      A
	JR      NZ,son_disparos_cmd
	LD      A,(Choq_MALOS)
	OR      A
	RET     Z
	LD      IY,SPRITE0
	LD      DE,LONG_SPRITES
situa_IY_Malos
	ADD     IY,DE
	RRA
	JR      NC,situa_IY_Malos
	LD      A,(IY+_CHECKS)
	BIT     CHECK_MATA,(IY+_CHECKS)
	RET     Z
; 	BIT     CHECK_INVULNERABLE,(IX+_CHECKS)
; 	LD      A,FX_imp_enem_prota
; 	push    bc
; 	CALL    Z,Toca_FX_Pos
; 	pop     bc

	JR      no_son_disparos_cmd
son_disparos_cmd
	LD      a,FX_imp_disp_prota
	push    bc
	CALL    z,Toca_FX_Pos
	pop     bc

	LD      A,(Choq_DISP)
	LD      IY,DISPARO2-LONG_DISPAROS
	LD      DE,LONG_DISPAROS
situa_IY_Disparos
	ADD     IY,DE
	RRA
	JR      NC,situa_IY_Disparos
	;marca para eliminar el disparo
	LD  	(IY+_SESTADO),#fe
	LD   	A,(IY+_SID)
	push    bc
	call   	Actualiza_Tabla_INT_ibp
	pop     bc
	;LD      (IY+_SESTADO),#FD
no_son_disparos_cmd
salta_sonido_nsd
	BIT     CHECK_INVULNERABLE,(IX+_CHECKS)
	RET     NZ
	LD      A,(IY+_VIDAS)		;si el malo esta explotando
	OR      A
	RET     Z
; 	BIT     CHECK_MUERE,(IY+_CHECKS)
; 	RET     NZ
	SET		CHECK_MUERTE,(IX+_CHECKS)
	RES		CHECK_MUERTE_DESDE,(IX+_CHECKS)
Quita_vida
	PUSH    BC
	CALL    Decrementa_vida
	POP     BC
	XOR     A
	RET

inicio_agachar_Prota
	;activo el estado reposo y desactivo el resto
	XOR     A
	SET     ESTADO_AGACHAR,A
	LD      (SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_AGACHAR
	LD		(SPRITE0_DSPR),HL
long_animacion_0_UP
	;longitud en la animación
	XOR     A
	LD		(SPRITE0_SPR),A
	LD		(SPRITE0_SPR_A),A
	RET

inicio_reposar_Prota
	;activo el estado reposo y desactivo el resto
	XOR     A
	SET     ESTADO_REPOSAR,A
	LD      (SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_REPOSO
	LD		(SPRITE0_DSPR),HL
	JR  	long_animacion_0_UP

inicio_andar_Prota
	;longitud en la animación
	LD		(IX+_SPR),7
	LD		(IX+_SPR_A),0
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_ANDAR
	LD		(SPRITE0_DSPR),HL
	;activo el estado andar y desactivo el resto
	XOR     A
;	LD      A,(SPRITE0_ESTADOS)
;	AND     %01000000		;respeto el disparo
	SET     ESTADO_ANDAR,A
	LD      (SPRITE0_ESTADOS),A
	LD		A,(TECLADO0)
	BIT		JOY_LEFT,A
	JR      Z,derecha_iaP
	LD		(IX+_MIRADA),1
	RET
derecha_iaP
	LD		(IX+_MIRADA),0
	RET

inicio_aterrizar_Prota
	;activo el estado aterrizar y desactivo el resto
	LD      a,FX_aterrizaje
	CALL    Toca_FX_Pos

	XOR     A
	SET     ESTADO_ATERRIZAR,A
	LD      (SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_ATERRIZA
	LD		(SPRITE0_DSPR),HL
	;asigno el camino
	SET  	CHECK_PATH,(IX+_CHECKS)
	LD   	HL,PATH_ATERRIZA
	LD   	(SPRITE0_PATH),HL
	JR  	long_animacion_0_UP

inicio_saltar_Prota
	LD      a,FX_salto
	CALL    Toca_FX_Pos
	;asigno el camino
	SET  	CHECK_PATH,(IX+_CHECKS)
	LD   	HL,PATH_SALTO_VERTICAL
	LD   	(SPRITE0_PATH),HL
inicio_saltar_Prota_sin_PATH
	;activo el estado saltar y desactivo el resto
	XOR		A
	SET     ESTADO_SALTAR,A
	LD      (SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_SALTAR
	LD		(SPRITE0_DSPR),HL
	JR  	long_animacion_0_UP

inicio_morir_Prota
	LD   	A,INTERVALO_INVULNERABLE
	LD   	(Invulnerable),A
	LD   	A,(SPRITE0_CHECKS)
	;invulnerabilizo
	SET  	CHECK_INVULNERABLE,A
	;quito check muerte
	RES  	CHECK_MUERTE,A
	;asigno el camino
	SET  	CHECK_PATH,A
	LD   	(SPRITE0_CHECKS),A
	LD   	HL,PATH_RESPINGO
	LD   	(SPRITE0_PATH),HL
inicio_morir_Prota_sin_PATH
	;activo el estado saltar y desactivo el resto
	XOR	A
	SET 	ESTADO_RESPINGO,A
	LD  	(SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_SALTAR
	LD		(SPRITE0_DSPR),HL
	JP  	long_animacion_0_UP

inicio_caer_Prota
	;asigno el camino
	SET  	CHECK_PATH,(IX+_CHECKS)
	LD   	HL,PATH_CAIDA_VERTICAL
	LD   	(SPRITE0_PATH),HL
inicio_caer_Prota_sin_PATH
	;activo el estado caer y desactivo el resto
	XOR      A
	SET     ESTADO_CAER,A
	LD      (SPRITE0_ESTADOS),A
	;indico el puntero a la animación del sprite
	LD		HL,DSPR_PROTA_SALTAR
	LD		(SPRITE0_DSPR),HL
	JP  	long_animacion_0_UP

haz_camino
	LD   	HL,(SPRITE0_PATH)
	LD   	A,(HL)
	CP   	255
	JP   	Z,fin_camino
abajo_HC
	AND		%00001111
	OR		A
	JR		Z,arriba_HC
	EXX
	CALL	Puedo_Ir_a_Abajo
	EXX
	JR		C,no_cambio_pantalla_Ab_HC
	;;cambio de pantalla abajo
; 	LD		A,(DATOS_PANTALLA_ACTUAL+3)
; 	CP		#FF
; 	JR		Z,fin1_HC
; 	SET		CHECK_CAMBIO,(IX+_CHECKS)
; 	LD		(Pantalla_Siguiente),A
; 	LD		(IX+_Y),40
; 	LD		(IX+_ANTY),40
	CALL    pantalla_abajo
	JR		fin1_HC
no_cambio_pantalla_Ab_HC
	JR		NZ,fin_camino
	LD		A,(HL)
	AND		%00001111
	LD		C,(IX+_Y)
	ADD 	A,C
	LD		(SPRITE0_Y),A
; 	JR      fin1_HC
	CALL	choque_malos_disparos
	JR		NC,fin1_HC
	LD		(IX+_Y),C
	CALL    inicio_estado_muere_Prota
	JR      fin_camino_muerte
arriba_HC
	LD		A,(HL)
	AND  	%11110000
	RRA
	RRA
	RRA
	RRA
	EXX
	CALL	Puedo_Ir_a_Arriba
	EXX
	JR		C,no_cambio_pantalla_Ar_HC
	;;cambio de pantalla arriba
	CALL    pantalla_arriba
	JR		fin1_HC
no_cambio_pantalla_Ar_HC
	JR		NZ,fin1_HC
	LD		A,(HL)
	AND  	%11110000
	RRA
	RRA
	RRA
	RRA
	LD 		B,A
	LD		C,(IX+_Y)
	LD 		A,C
	SUB		B
	LD		(SPRITE0_Y),A
; 	JR      fin1_HC
	CALL	choque_malos_disparos
	JR		NC,fin1_HC
	LD		(IX+_Y),C
	CALL    inicio_estado_muere_Prota
	JR		fin_camino_muerte

fin1_HC
	INC		HL
	LD  	(SPRITE0_PATH),HL
	JP		Siguiente_Sprite

fin_camino_muerte
	RES  	CHECK_PATH,(IX+_CHECKS)
	JP   	salir_normal_UP
fin_camino
	RES  	CHECK_PATH,(IX+_CHECKS)
	JP   	Ajusta_Sprite

Prota_Toca_Objeto
		LD	 A,(CHECK_OBJETO)
		OR	 A
		RET	 Z
		XOR	 A
		LD	 (CHECK_OBJETO),A
        LD	 IX,SPRITE0
        LD	 IY,STATIC0
		LD   A,(PANTALLA_ACTUAL)
		CP   PANTALLA_INICIO
		JP   Z,Ejecuta_Triggers_Statics
		CP   PANTALLA_BOSS
		JP   Z,Ejecuta_Triggers_Statics
        CALL Statics_collide
        JR	 C,objeto_PTO
        LD	 IX,SPRITE0
        LD	 IY,STATIC1
        CALL Statics_collide
        JR	 C,objeto_PTO
        LD	 IX,SPRITE0
        LD	 IY,STATIC2
        CALL Statics_collide
        JR	 C,objeto_PTO
        LD	 IX,SPRITE0
        LD	 IY,STATIC3
        CALL Statics_collide
;         JR	C,objeto_PTO
;         LD	IX,SPRITE0
;         LD	IY,STATIC4
;         CALL	Statics_collide
		RET  NC
objeto_PTO
		JP	 Ejecuta_Triggers_Statics
