;;----------------------------------------------
;;Ajusta el sprite al tile siguiente
;;Ajusta_Sprite
;;----------------------------------------------
;;Pasa al siguiente sprite
;;Siguiente_Sprite
;;----------------------------------------------
;;Ejecuta_Rutina_Sprite
;;Ejecuta la rutina de un sprite dado en IX
;;----------------------------------------------
;;Inicializa_Sprite
;;Inicializa los datos de los sprites
;;----------------------------------------------
;;Actualiza_Tabla_INT_cfp
;;Asigna al sprite A, para que capture el fondo de pantalla (cfp)
;;----------------------------------------------
;;Actualiza_Tabla_INT_UPD
;;Asigna al sprite A, para que ejecute rutina de UPDATE
;;----------------------------------------------
;;Asigna_Sprite_ID
;;Devuelve en IX el puntero al sprite A
;;----------------------------------------------
;;Actualiza_Tabla_INT_isp
;;Asigna al sprite A, para que imprima el sprite en pantalla (isp)
;;----------------------------------------------
;;Actualiza_Tabla_INT_ibp
;;Asigna al sprite A, para que imprima el buffer en pantalla (ibp)
;;----------------------------------------------
;;Puede ir hacia derecha A px el sprite
;;Puedo_Ir_a_Derecha
;;----------------------------------------------
;;Puede ir hacia izquierda A px el sprite
;;Puedo_Ir_a_Izquierda
;;----------------------------------------------
;;Puede ir hacia abajo A px el sprite
;;Puedo_Ir_a_Abajo
;;----------------------------------------------
;;Puede ir hacia arriba A px el sprite
;;Puedo_Ir_a_Arriba
;;----------------------------------------------


;;
;;Ajusta el sprite al tile siguiente
;;
;;ENTRADA
;;IX:Sprite
;;SALIDA
;;nada
;;destruye B,AF
;;
Ajusta_Sprite
	XOR	A
	LD	B,(IX+_Y)
	SRL	B
	RRA
	SRL	B
	RRA
	SRL	B	;Y/8
	RRA
	SCF
	CCF
	RRA
	RRA
	RRA
	RRA
	RRA
	OR	A
	RET	Z
	LD	B,A
	LD	A,(IX+_Y)
	ADD	A,8
	SUB	A,B
	LD	(IX+_Y),A
	RET

;;
;;Pasa al siguiente sprite
;;
;;ENTRADA
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Siguiente_Sprite
	LD	A,(IX+_SPR_A)
	INC	A
	CP	(IX+_SPR)
	JR	C,salir_SS
	JR	Z,salir_SS
	XOR	A
salir_SS
	LD	(IX+_SPR_A),A
	RET


;;
;;Ejecuta la rutina de imprime_sprite_pantalla de IX
;;
;;ENTRADA
;;HL:SPRITEX_INT
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_ISP
	LD	A,(HL)
	AND	BIT_isp
	RET	Z
	LD      A,BIT_NEG_isp
	AND     (HL)
	LD      (HL),A
	JP	Imprime_Sprite_Pantalla

Ejecuta_ISPB
	LD	A,(HL)
	AND	BIT_isp
	RET	Z
	LD  A,BIT_NEG_isp
	AND (HL)
	LD  (HL),A
	JP	Imprime_Sprite_Bala

;;
;;Ejecuta la rutina de Imprime_buffer_pantalla de IX
;;
;;ENTRADA
;;HL:SPRITEX_INT
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_IBP
	LD	A,(HL)
	AND	BIT_ibp
	RET	Z
	LD      A,BIT_NEG_ibp
	AND     (HL)
	LD      (HL),A
	LD		A,(IX+_ID)
	CP		0
	JP		Z,Imprime_Buffer_Pantalla
	JP		Imprime_Bloque_Buffer_Pantalla

Ejecuta_IBPB
	LD	 A,(HL)
	AND	 BIT_ibp
	RET	 Z
	LD   A,BIT_NEG_ibp
	AND  (HL)
	LD   (HL),A
	JP	 Imprime_Buffer_Bala
;;
;;Ejecuta la rutina de Captura_Fondo_Pantalla de IX
;;
;;ENTRADA
;;HL:SPRITEX_INT
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_CFP
	LD	A,(HL)
	AND	BIT_cfp
	RET	Z
	LD      A,BIT_NEG_cfp
	AND     (HL)
	LD      (HL),A
	JP      Captura_Fondo_Pantalla

Ejecuta_CFPB
	LD	A,(HL)
	AND	BIT_cfp
	RET	Z
	LD      A,BIT_NEG_cfp
	AND     (HL)
	LD      (HL),A
	JP      Captura_Fondo_Bala

;;
;;Ejecuta la rutina de un sprite dado en IX
;;
;;ENTRADA
;;IX:Sprite
;;SALIDA
;;nada
;;destruye A
;;
Ejecuta_Rutina_Sprite
; 	LD    A,(SEMAFORO_PAUSA)
; 	OR    A
; 	RET   NZ
	LD	  A,(HL)
	AND	  BIT_UPD
	RET	  Z
Ejecuta_Rutina_Sprite_sin
	LD    	  L,(IX+_UPD)
	LD        H,(IX+_UPD+1)
sm_rut_spr0
	JP        (HL)

;;
;;Inicializa los datos de los sprites
;;
;;ENTRADA
;;HL':UPDATE
;;D':Mirada
;;E':desplazamiento
;;B':cadencia o velocidad
;;BC:(y,x)
;;HL:Dirección del sprite
;;A:ID del sprite
;;A':numero de sprites
;;D:ANCHO
;;E:ALTO
;;SALIDA
;;nada
;;destruye Nada
;;
Inicializa_Sprite
	LD	(IX+_ID),A;
	LD	(IX+_UPD),L;
	LD	(IX+_UPD+1),H;
	LD	(IX+_MIRADA),D;
	CP	0
	JR	Z,prota_IS
	LD	(IX+_IDESP),E;
	LD	(IX+_DESP),0;
	LD	(IX+_ADESP),0;
	LD	(IX+_ICAD),B;
	LD	(IX+_CAD),B;
	JR	sigue_IS
prota_IS
	LD	(IX+_PATH),0
	LD	(IX+_PATH+1),0
	LD	(IX+_CHECKS),0
sigue_IS
	EXX
	LD	(IX+_ANTX),C;
	LD	(IX+_X),C;
	LD	(IX+_ANTY),B;
	LD	(IX+_Y),B;
	LD	(IX+_DSPR),L;
	LD	(IX+_DSPR+1),H;
	EX	AF,AF'      ;A'
	LD	(IX+_SPR),A;
	LD	(IX+_SPR_A),0;
	LD	(IX+_ANCHO),D;
	LD	(IX+_ALTO),E;
	EX	AF,AF'      ;A'
	CALL	Actualiza_Tabla_INT_cfp
	CALL	Actualiza_Tabla_INT_UPD
	JP	Actualiza_Tabla_INT_isp

;;
;;Asigna al sprite A, para que capture el fondo de pantalla (cfp) (isp) (ibp)
;;
;;ENTRADA
;;A:Id del sprite o del disparo
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_cfp_isp_ibp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,%00000111
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que capture el fondo de pantalla (cfp)
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_cfp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_cfp
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que ejecute rutina de UPDATE
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_UPD
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_UPD
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que imprima el sprite en pantalla (isp)
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_isp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_isp
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Asigna al sprite A, para que imprima el buffer en pantalla (ibp)
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;nada
;;destruye BC,HL
;;
Actualiza_Tabla_INT_ibp
	PUSH	AF
	LD	HL,Tabla_INT
	LD	B,0
	LD	C,A
	ADD	HL,BC
	LD	A,BIT_ibp
	OR	(HL)
	LD	(HL),A
	POP	AF
	RET

;;
;;Devuelve en IX el puntero al sprite A
;;
;;ENTRADA
;;A:Id del sprite
;;SALIDA
;;IX:dirección del sprite
;;destruye BC,HL,DE
;;
Asigna_Sprite_ID
	LD	HL,SPRITE0_ID
	LD	DE,LONG_SPRITES
	LD	B,NUMERO_SPRITES
otro_asID
	LD	C,(HL)
	CP	C
	JR	Z,fin_asID
	ADD	HL,DE
	DJNZ	otro_asID
fin_asID
	PUSH	HL
	POP	IX
	RET

Backup_TINT
	LD  HL,Tabla_INT
	LD  DE,Tabla_BCK
	LD  BC,13
	LDIR
	RET

Restore_TINT
	LD  HL,Tabla_BCK
	LD  DE,Tabla_INT
	LD  BC,13
	LDIR
	RET

;;
;;Puede ir hacia izquierda A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede
;;destruye HL,BC,DE,AF
;;
Puedo_Ir_a_Izquierda								;OPTIMIZADO
	;numero de tiles en vertical a comprobar
	LD		L,3   			;SOLO PROTA numero de tiles del prota
	;desplazamiento en D
	LD		D,A
	LD		A,(SPRITE0_X)		;SOLO PROTA
	;coordenada a comprobar (X-A)
	SUB		A,D
	;comprueba que no este fuera del mapa
	CP		ANCHO_MAPA_BYTES
	RET		NC 				;se sale con NC si está fuera de pantalla
	;ajuste para que el bounding sea mas preciso por la izquierda
	INC 	A
	;dejo en C el punto a comprobar
	LD		C,A
	SRL 	C
comun_PIdi
	;calculo si son 3 o 4 los tiles a comprobar (depende de si está en coordena Y/8 y resto 0)
	LD		A,(SPRITE0_Y)		;SOLO PROTA
	LD		H,A
	XOR		A
	SRL		H
	RL		A
	SRL		H
	RL		A
	SRL		H
	RL		A
	OR		A
	JR		Z,sigue_PIAI
	;si el resto de la division es >0 entonces compruebo 4 tiles
	INC		L
sigue_PIAI
	;cojo la Y en B
	LD      A,L
	LD		B,H		;SOLO PROTA
otro_PIAI
	;salvo el contador de tiles a revisar
	EX      AF,AF'
	;salvo la coordenada actual
	PUSH	BC
	CALL	Lee_Durezas_Div		;;BC,DE,HL
	POP		BC
	;si a>0 he encontrado algo
	OR		A
	JR		NZ,salir_PIADI
	;incremento las Y
	inc 	b
	;compruebo si he terminado de mirar todos los tiles
	EX      AF,AF'
	DEC		A
	JR		NZ,otro_PIAI
	;C y Z si no he encontrado nada
	SCF
	RET

;;
;;Puede ir hacia derecha A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede
;;destruye HL,BC,DE,AF
;;
Puedo_Ir_a_Derecha							;OPTIMIZADO
	;numero de tiles en vertical a comprobar
	LD		L,3   			;SOLO PROTA numero de tiles del prota
	;desplazamiento en D (viene ya con el ancho del sprite (6))
	LD	D,A
	LD  A,(SPRITE0_X)
	ADD	A,D
	;comprueba que no este fuera del mapa
	CP		ANCHO_MAPA_BYTES+1
	RET		NC 				;se sale con NC si está fuera de pantalla
	;ajuste para que el bounding sea mas preciso por la izquierda
	DEC 	A
	;dejo en C el punto a comprobar
	LD		C,A
	DEC     C
	SRL 	C
	JR      comun_PIdi
; 	;calculo si son 3 o 4 los tiles a comprobar (depende de si está en coordena Y/8 y resto 0)
; 	LD		A,(SPRITE0_Y)		;SOLO PROTA
; 	LD		H,A
; 	XOR		A
; 	SRL		H
; 	RL		A
; 	SRL		H
; 	RL		A
; 	SRL		H
; 	RL		A
; 	OR		A
; 	JR		Z,sigue_PIAI
; 	;si el resto de la division es >0 entonces compruebo 4 tiles
; 	INC		L
; sigue_PIAD
; 	;cojo la Y en B
; 	LD      A,L
; 	LD		B,H		;SOLO PROTA
; otro_PIAD
; 	;salvo el contador de tiles a revisar
; 	EX      AF,AF'
; 	;salvo la coordenada actual
; 	PUSH	BC
; 	CALL	Lee_Durezas_Div		;;BC,DE,HL
; 	POP		BC
; 	;si a>0 he encontrado algo
; 	OR		A
; 	JR		NZ,salir_PIADI
; 	;incremento las Y
; 	inc 	b
; 	;compruebo si he terminado de mirar todos los tiles
; 	EX      AF,AF'
; 	DEC		A
; 	JR		NZ,otro_PIAD
; 	;C y Z si no he encontrado nada
; 	SCF
; 	RET

salir_PIADI
	PUSH	AF
	CP      BIT_TOTAL
	JR      Z,salir1_PIADI
	CP		BIT_MATAN
	JR		NZ,objetos_PIADI
	SET		CHECK_MUERTE_DESDE,(IX+_CHECKS)
	JR		salir1_PIADI
objetos_PIADI
	CP		BIT_OBJETO
	JR		NZ,salir1_PIADI
	LD		(CHECK_OBJETO),A
salir1_PIADI
	POP	AF
	SCF
	RET

; salir_PIADI
; 	CP	BIT_MATAN
; 	JR	NZ,salir1_PIADI
; 	SET	CHECK_MUERTE,(IX+_CHECKS)
; 	RET
; salir1_PIADI
; 	CP	BIT_OBJETO
; 	JR	NZ,salir2_PIADI
; 	LD	(CHECK_OBJETO),A
; 	RET
; salir2_PIADI
; 	SCF
; 	RET

Puedo_Ir_a_Abajo							;OPTIMIZADO
	;direccion de la Y a comrpobar
	ADD		A,(IX+_Y)
 	ADD		A,24		;SOLO PROTA
 	;compruebo que se ha salido de la pantalla
	CP		ALTO_MAPA_PX+1
	RET		NC
	;dejo en B las Y/8
	LD		B,A
	DEC		B
	SRL		B
	SRL		B
	SRL		B
	;dejo en C las X
	LD      C,(IX+_X)
	;ajuste del bounding
 	INC     C
	;numero de tiles en vertical a comprobar
	LD		A,4		;SOLO PROTA
otro_PIAAb
	EX      AF,AF'
	PUSH	BC
	SRL     C
	CALL	Lee_Durezas_Div		;;BC,DE,HL
	POP		BC
	OR		A
	JR		NZ,salir_PIADI
	INC		C
	EX      AF,AF'
	DEC		A
	JR 		NZ,otro_PIAAb
	SCF
	RET

Puedo_Ir_a_Arriba								;OPTIMIZADO
	;direccion de la Y a comrpobar
	LD	B,A
	LD	A,(SPRITE0_Y)
	SUB	B
 	;compruebo que se ha salido de la pantalla
	CP  40
	JR  C,niega_carry
	;dejo en B las Y/8
	LD		B,A
	;DEC		B
	XOR     A
	SRL		B
	RLA
	SRL		B
	RLA
	SRL		B
	RLA
	OR      A
; 	;dejo en C las X
	LD      C,(IX+_X)
	;ajuste del bounding
 	INC     C
	;numero de tiles en vertical a comprobar
	LD		A,4		;SOLO PROTA
	JR  	otro_PIAAb

;;
;;Puede ir hacia arriba A px el sprite
;;
;;ENTRADA
;;IX:Sprite
;;A:px de desplazamiento
;;SALIDA
;;A:1ª dureza encontrada
;;Z:puede, NZ:no puede
;;destruye BC,DE,AF
;;
; Puedo_Ir_a_Arriba
; 	;LD	E,(IX+_ANCHO)
; 	;dec e
; 	;dec e	;resto dos en la anchura para que el ruso no vuele
; 	LD	E,4		;SOLO PROTA

; 	LD	B,A
; 	LD	A,(IX+_Y)
; 	SUB	B
; 	;CP	ALTO_MAPA_BYTES
; 	;RET	NC
; 	CP  40
; 	JR  C,niega_carry
; 	LD	B,A
; 	LD	D,1	;empiezo con x+1 para que el ruso no vuele
; otro_PIAAr
; 	PUSH	DE
; 	LD	A,(IX+_X)
; 	ADD	A,D
; 	LD	C,A
; 	PUSH	BC
; 	CALL	Lee_Durezas		;;BC,DE,HL
; 	POP	BC
; 	POP	DE
; 	OR	A
; 	JP	NZ,salir_PIADI
; 	INC	D
; 	DEC	E
; 	JR 	NZ,otro_PIAAr
; 	SCF
; 	RET
niega_carry
	CCF
	RET

; ; es_obstaculo_disp_prota
; 	LD	C,(IX+_SX)
; 	LD	B,(IX+_SY)
; 	push bc
; 	CALL	Lee_Durezas		;;BC,DE,HL
; 	pop  bc
; 	CP      BIT_OBJETO
; 	RET     Z
; 	OR		A
; 	JP		NZ,salir_PIADI
; 	ld      a,b
; 	add     6
; 	ld      b,a
; 	CALL	Lee_Durezas		;;BC,DE,HL
; 	CP      BIT_OBJETO
; 	RET     Z
; 	OR		A
; 	JP		NZ,salir_PIADI
; 	RET
es_obstaculo_disp_prota
es_obstaculo_disp
	LD	C,(IX+_SX)
	LD	B,(IX+_SY)
es_obstaculo_disp_BC_prota
es_obstaculo_disp_BC
	push bc
	CALL	Lee_Durezas		;;BC,DE,HL
	pop  bc
	CP      BIT_OBJETO
	RET     Z
	OR		A
	JP		NZ,salir_PIADI
	ld      a,b
	add     5
	ld      b,a
	CALL	Lee_Durezas		;;BC,DE,HL
	CP      BIT_OBJETO
	RET     Z
	OR		A
	JP		NZ,salir_PIADI
	RET
