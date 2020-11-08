;;----------------------------------------------
;;Captura_Fondo_Pantalla
;;Captura el buffer del sprite IX
;;----------------------------------------------
;;Incrementa_Buffer
;;Actualiza el buffer al nuevo buffer para el siguiente sprite
;;----------------------------------------------
;;Captura_Bloque_Fondo_Pantalla
;;Captura un bloque de fonde pantalla, vertical u horizontal
;;----------------------------------------------

;;
;;Captura el buffer del sprite IX
;;
;;ENTRADA
;;IX:dirección del objeto sprite
;;SALIDA
;;Nada
;;destruye BC,HL,DE,A
;;
Captura_Fondo_Pantalla                      ;926T
    LD      (Stack_Anterior),SP

    LD       SP,ANCHO_MAPA_BYTES-6

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_Y)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_X)
    ADD     HL,BC

    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

    LD      A,8         ; número de líneas a dibujar
bucle_y_cfp
    LDI                 ; paso 6 bytes
    LDI
    LDI
    LDI
    LDI
    LDI

    ADD     HL,SP

    LDI         ; paso 6 bytes
    LDI
    LDI
    LDI
    LDI
    LDI

    ADD     HL,SP

    LDI         ; paso 6 bytes
    LDI
    LDI
    LDI
    LDI
    LDI

    LD      BC,#800-#50-#50-6
    ADD     HL,BC
    JR      NC,siguiente_scanline_cfp
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_cfp

    DEC     A
    JR      NZ,bucle_y_cfp

    LD      SP,(Stack_Anterior)

    RET

;;
;;Actualiza el buffer al nuevo buffer para el siguiente sprite
;;y lo CAPTURA
;;
;;ENTRADA
;;IX:dirección del objeto sprite
;;SALIDA
;;Nada
;;destruye BC,HL,DE,A
;;
Incrementa_Buffer
    LD      HL,(Buffer_actual)
    LD      A,(IX+_IDESP)
    OR      A                 ;si es 0 captura "normal", solo el fondo ya que no habrá movimiento
    JR      NZ,inc_fondo_IB
    LD      B,(IX+_ANCHO)
    DEC     B
    LD      C,(IX+_ALTO)
    LD      A,C
otro_IB
    ADD     A,C
    DJNZ    otro_IB
    LD      C,A
    ADD     HL,BC
    JR      fin_IB
inc_fondo_IB
    ;si no es 0, captura todo el fondo
    ;hay que modificarlo para movimientos verticales
    LD      A,(IX+_MIRADA)
    CP      ARRIBA
    JR      Z,inc_fondo_vert_IB
    CP      ABAJO
    JR      Z,inc_fondo_vert_IB
    LD      A,(IX+_IDESP)
    LD      C,A
    LD		A,(IX+_ANCHO)
    ADD		A,C
    LD		C,A
    LD      B,0
    LD      E,(IX+_ALTO)
otro1_IB
    ADD     HL,BC
    DEC     E
    JR      NZ,otro1_IB
    JR      fin_IB
inc_fondo_vert_IB
    LD      A,(IX+_IDESP)
    LD      C,A
    LD      A,(IX+_ALTO)
    ADD     A,C
    LD      C,A
    LD      B,0
    LD      E,(IX+_ANCHO)
otro2_IB
    ADD     HL,BC
    DEC     E
    JR      NZ,otro2_IB
fin_IB
    LD      (Buffer_actual),HL
;     JP      Captura_Bloque_Fondo_Pantalla

;;
;;Captura_Bloque_Fondo_Pantalla
;;
;;ENTRADA
;;IX:dirección del objeto sprite
;;SALIDA
;;Nada
;;destruye todo
;;
Captura_Bloque_Fondo_Pantalla
    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_Y)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_X)
    ADD     HL,BC

    LD      A,(IX+_MIRADA)
    CP      DERECHA
    JP      Z,horizontal_CBFP
    CP      IZQUIERDA
    JP      Z,horizontal_i_CBFP
    JP      vertical_CBFP

horizontal_i_CBFP
    LD      C,(IX+_DESP)
    SBC     HL,BC
horizontal_CBFP
    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

	LD		B,(IX+_ALTO)	;ALTO  a capturar
	SRL		B
	SRL		B
	SRL		B				;alto/8

	LD		A,(IX+_IDESP)	;ANCHO a capturar
	ADD		A,(IX+_ANCHO)
	EX		AF,AF'

;;DE: Buffer
;;HL: Dirpan
;;B : Alto
;;A': Ancho
captura_zona_de_pantalla
    LD		A,8
ocho_veces_CBFP
	PUSH	BC
	PUSH	HL
alto_CBFP
	PUSH	BC
	EX		AF,AF'
	LD		C,A
	LD		B,0
	EX		AF,AF'
	PUSH	HL
	LDIR
	POP		HL
    LD      BC,ANCHO_MAPA_BYTES
    ADD     HL,BC
	POP		BC
	DJNZ	alto_CBFP

	POP		HL
    LD      BC,#800
    ADD     HL,BC
    JR      NC,siguiente_scanline_CBFP
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_CBFP
	POP		BC

	DEC		A
	JR 		NZ,ocho_veces_CBFP
	RET

;;HL: Buffer
;;DE: Dirpan
;;B : Alto
;;A': Ancho
imprime_zona_de_pantalla

balto_izp
    PUSH    BC
    EX      AF,AF'
    LD      C,A
    LD      B,0
    EX      AF,AF'
    PUSH    DE
    LDIR
    POP     DE
    EX      HL,DE
    LD      BC,#800
    ADD     HL,BC
    JR      NC,siguiente_scanline1_izp
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline1_izp
    EX      HL,DE
    POP     BC
    DJNZ    balto_izp
    RET

vertical_CBFP
    LD      L,(IX+_Y)
    LD      A,(IX+_MIRADA)
    CP      ARRIBA
    JR      Z,es_arriba_CBFP
    LD      A,(IX+_Y)
    SBC     (IX+_IDESP)
    LD      L,A
es_arriba_CBFP
    LD      H,TABLA_SCANLINES_H
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_X)
    ADD     HL,BC

    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

    LD      A,(IX+_ANCHO)   ;ANCHO a capturar
    EX      AF,AF'

    LD      B,(IX+_ALTO)    ;ALTO  a capturar

    LD      A,(IX+_IDESP)
    ADD     A,(IX+_ALTO)
    ADD     A,B
    LD      B,A

    ;;DE: Buffer
    ;;HL: Dirpan
    ;;B : Alto
    ;;A': Ancho
captura_zona_stile
balto_CBFP
    PUSH    BC
    EX      AF,AF'
    LD      C,A
    LD      B,0
    EX      AF,AF'
    PUSH    HL
    LDIR
    POP     HL
    LD      BC,#800
    ADD     HL,BC
    JR      NC,siguiente_scanline1_CBFP
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline1_CBFP
    POP     BC
    DJNZ    balto_CBFP
    RET

;;;;;; SOLO BALAS
Captura_Fondo_Bala                      ;168-173T  (sin salto y con salto)
    LD      A,(IX+_SESTADO)
    OR      A
    RET     Z

    LD      B,6
    EXX     

    LD      (Stack_Anterior),SP

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_Y)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_X)
    ADD     HL,BC

    LD      E,IXL
    LD      D,IXH
    EX      HL,DE
    LD      BC,_SBUFFER
    ADD     HL,BC
    EX      HL,DE   ;DE dirbuff

    LD      SP,#800-2

otro_bucle_CFBa
    LDI                 ; paso 4 bytes (16)
    LDI                 ;(16)

    EXX
    DEC     B
    JR      Z,salir_CFBa
    EXX

    ADD     HL,SP
    JR      NC,siguiente_scanline_CFBa
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_CFBa
    JR      otro_bucle_CFBa
salir_CFBa
    LD      A,(IX+_X)
    LD      (IX+_ANTX),A
    LD      A,(IX+_Y)
    LD      (IX+_ANTY),A

    LD      SP,(Stack_Anterior)
    RET

;     LDI                 ; paso 4 bytes
;     LDI

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_CFBa1
;     LD      BC,#C050
;     ADD     HL,BC
; siguiente_scanline_CFBa1
;     LDI                 ; paso 4 bytes
;     LDI

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_CFBa2
;     LD      BC,#C050
;     ADD     HL,BC
; siguiente_scanline_CFBa2
;     LDI                 ; paso 4 bytes
;     LDI

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_CFBa3
;     LD      BC,#C050
;     ADD     HL,BC
; siguiente_scanline_CFBa3
;     LDI                 ; paso 4 bytes
;     LDI

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_CFBa4
;     LD      BC,#C050
;     ADD     HL,BC
; siguiente_scanline_CFBa4
;     LDI                 ; paso 4 bytes
;     LDI

;     LD      A,(IX+_X)
;     LD      (IX+_ANTX),A
;     LD      A,(IX+_Y)
;     LD      (IX+_ANTY),A

;     LD      SP,(Stack_Anterior)
;     RET

;;***********************************************
Imprime_Bloque_Buffer_Pantalla                  ;697T ->16
                                                ;434T ->8
    LD      (stack_anterior),SP

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_ANTY)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_ANTX)
    ADD     HL,BC

    EX      DE,HL                   ;DE DIRPAN

    LD      L,(IX+_BUFF)
    LD      H,(IX+_BUFF+1)
    LD		C,(IX+_DESP)
    LD      A,(IX+_MIRADA)
    CP      ARRIBA
    JP      NC,vertical_IBBP
    ;LD		B,0
    ADD		HL,BC

    EX		DE,HL			;HL screen address   DE   BUFFER

    LD      A,(IX+_IDESP)
    EX      AF,AF'

    LD      A,(IX+_ALTO)
    CP      8
    JR      Z,bucle_Alto8_IBBP

;16 de alto
bucle4_bytes_IBBP
    LD      SP,ANCHO_MAPA_BYTES-4
    LD      A,8								               ; n�mero de l�neas a dibujar
bucle_y_IBBP_4
    EX      HL,DE           ;DE screen address   HL   BUFFER

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI

    LD		B,0
    EX      AF,AF'
    LD		C,A
    EX      AF,AF'
    ADD		HL,BC
    EX      HL,DE
    ADD     HL,SP
    EX      DE,HL

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI

    LD		B,0
    EX      AF,AF'
    LD      C,A
    EX      AF,AF'
    ADD		HL,BC

    EX      HL,DE
    LD      BC,#800-84
    ADD     HL,BC
    JR      NC,siguiente_scanline_IBBP_4
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_IBBP_4

    DEC     A
    JR      NZ,bucle_y_IBBP_4

    LD      SP,(stack_anterior)

    RET

;8 de alto
bucle_Alto8_IBBP
    LD      SP,ANCHO_MAPA_BYTES-4
    LD      A,8                                            ; n�mero de l�neas a dibujar
bucle_y_IBBP_a8
    EX      HL,DE

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI

    LD      B,0
    EX      AF,AF'
    LD      C,A
    EX      AF,AF'
    ADD     HL,BC

    EX      HL,DE
    LD      BC,#800-4
    ADD     HL,BC
    JR      NC,siguiente_scanline_IBBP_a8
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_IBBP_a8

    DEC     A
    JR      NZ,bucle_y_IBBP_a8

    LD      SP,(stack_anterior)

    RET

; bucle2_bytes_IBBP
;     LD      A,8                                            ; n�mero de l�neas a dibujar
; bucle_y_IBBP_2
;     EX      HL,DE

;     LDI          ; paso 2 bytes
;     LDI

;     LD      B,0
;     LD      C,(IX+_IDESP)
;     ADD     HL,BC

;     EX      HL,DE
;     LD      BC,#800-66
;     ADD     HL,BC
;     JR      NC,siguiente_scanline_IBBP_2
;     LD      BC,#C040
;     ADD     HL,BC
; siguiente_scanline_IBBP_2

;     DEC     A
;     JR      NZ,bucle_y_IBBP_2

;     LD      SP,(stack_anterior)

;     RET

vertical_IBBP                               ;FALTA OPTIMIZAR

;     LD      A,(IX+_ANCHO)
;     CP      4
;     JR      Z,vertical4_IBBP
;     CP      6
;     JR      Z,vertical6_IBBP
;     JR      vertical2_IBBP

vertical4_IBBP
    SLA     C
    RL      B
    SLA     C
    RL      B
    ;LD      B,0
    ADD     HL,BC
    EX      HL,DE   ;;HL:pant DE:buff

    LD      SP,#800-4
    LD      A,(IX+_ALTO)
bucle_ancho_IBBP
    EX      DE,HL
    LDI
    LDI
    LDI
    LDI
    EX      DE,HL
    ADD     HL,SP
    JR      NC,siguiente_scanline1_IBBP
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline1_IBBP
    DEC     A
    JR      NZ,bucle_ancho_IBBP

    LD      SP,(stack_anterior)
    RET

; vertical6_IBBP
;     XOR     A
;     LD      B,6
; multi6_IBBP
;     ADD     A,C
;     DJNZ    multi6_IBBP
;     LD      C,A
;     LD      B,0
;     ADD     HL,BC
;     EX      HL,DE   ;;HL-pant DE-buff

;     LD      SP,#800-6
;     LD      A,(IX+_ALTO)
; bucle_ancho6_IBBP
;     EX      DE,HL
;     LDI
;     LDI
;     LDI
;     LDI
;     LDI
;     LDI
;     EX      DE,HL
;     ADD     HL,SP
;     JR      NC,siguiente_scanline6_IBBP
;     LD      BC,#C050
;     ADD     HL,BC
; siguiente_scanline6_IBBP
;     DEC     A
;     JR      NZ,bucle_ancho6_IBBP

;     LD      SP,(stack_anterior)
;     RET

; vertical2_IBBP
;     SLA     C
;     LD      B,0
;     ADD     HL,BC
;     EX      HL,DE   ;;HL-pant DE-buff

;     LD      SP,#800-2
;     LD      A,(IX+_ALTO)
; bucle_ancho2_IBBP
;     EX      DE,HL
;     LDI
;     LDI
;     EX      DE,HL
;     ADD     HL,SP
;     JR      NC,siguiente_scanline12_IBBP
;     LD      BC,#C050
;     ADD     HL,BC
; siguiente_scanline12_IBBP
;     DEC     A
;     JR      NZ,bucle_ancho2_IBBP

;     LD      SP,(stack_anterior)
;     RET

;***************************************
Imprime_Buffer_Bala                             ;149-154T
    LD      (stack_anterior),SP

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_ANTY)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_ANTX)
    ADD     HL,BC

    LD      E,IXL
    LD      D,IXH
    EX      HL,DE
    LD      BC,_SBUFFER
    ADD     HL,BC

    LD      SP,#800-2

    LDI          ; paso 4 bytes
    LDI

    EX      HL,DE
    ADD     HL,SP
    JR      NC,siguiente_scanline_ibBa
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_ibBa
    EX      HL,DE

    LDI          ; paso 4 bytes
    LDI

    EX      HL,DE
    ADD     HL,SP
    JR      NC,siguiente_scanline_ibBa1
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_ibBa1
    EX      HL,DE
    LDI          ; paso 4 bytes
    LDI

    EX      HL,DE
    ADD     HL,SP
    JR      NC,siguiente_scanline_ibBa2
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_ibBa2
    EX      HL,DE
    LDI          ; paso 4 bytes
    LDI

    EX      HL,DE
    ADD     HL,SP
    JR      NC,siguiente_scanline_ibBa3
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_ibBa3
    EX      HL,DE
    LDI          ; paso 4 bytes
    LDI

    EX      HL,DE
    ADD     HL,SP
    JR      NC,siguiente_scanline_ibBa4
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_ibBa4
    EX      HL,DE
    LDI          ; paso 4 bytes
    LDI

    LD      SP,(stack_anterior)

    RET

;*********************************************
Imprime_Buffer_Pantalla                             ;974T
    LD      (stack_anterior),SP

    LD      SP,ANCHO_MAPA_BYTES-6

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_ANTY)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_ANTX)
    ADD     HL,BC

    LD      E,(IX+_BUFF)
    LD      D,(IX+_BUFF+1)

    LD      A,8								               ; n�mero de l�neas a dibujar
bucle_y_wsbs816_4
    EX      HL,DE

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI
    LDI
    LDI

    EX      HL,DE
    ADD     HL,SP
    EX      DE,HL

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI
    LDI
    LDI

    EX      HL,DE
    ADD     HL,SP
    EX      DE,HL

    LDI          ; paso 4 bytes
    LDI
    LDI
    LDI
    LDI
    LDI

    EX      HL,DE
    LD      BC,#800-#50-#50-6
    ADD     HL,BC
    JR      NC,siguiente_scanline_wsbs816_4
    LD      BC,#C050
    ADD     HL,BC
siguiente_scanline_wsbs816_4

    DEC     A
    JR      NZ,bucle_y_wsbs816_4
salir_ibp
    LD      SP,(stack_anterior)

    RET


;********************************************
Imprime_Sprite_Bala                                 ;261-268T
    LD      A,(IX+_SESTADO)
    CP      #fe
    RET     Z

    LD      A,(IX+_SESTADO)
    OR      A
    RET     Z

    ld      b,6
    EXX

    LD      (stack_anterior),SP

    LD      SP,#800-2

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_ANTY)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      B,0
    LD      C,(IX+_ANTX)
    ADD     HL,BC

    LD      B,(IX+ _SDIRECCION+1)
    LD      C,(IX+ _SDIRECCION)

otro_isBa
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    PINTA_CON_MASCARA
    PINTA_CON_MASCARA

    EXX
    dec     b
    JR      Z,salir_isBa
    EXX

    ADD     HL,SP
    JR      NC,siguiente_scanline_isBa
    LD      DE,#C050
    ADD     HL,DE
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras
siguiente_scanline_isBa
    jr      otro_isBa
;     PINTA_CON_MASCARA
;     PINTA_CON_MASCARA

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_isBa1
;     LD      DE,#C050
;     ADD     HL,DE
;     LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras
; siguiente_scanline_isBa1

;     PINTA_CON_MASCARA
;     PINTA_CON_MASCARA

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_isBa2
;     LD      DE,#C050
;     ADD     HL,DE
;     LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras
; siguiente_scanline_isBa2

;     PINTA_CON_MASCARA
;     PINTA_CON_MASCARA

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_isBa3
;     LD      DE,#C050
;     ADD     HL,DE
;     LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras
; siguiente_scanline_isBa3

;     PINTA_CON_MASCARA
;     PINTA_CON_MASCARA

;     ADD     HL,SP
;     JR      NC,siguiente_scanline_isBa4
;     LD      DE,#C050
;     ADD     HL,DE
;     LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras
; siguiente_scanline_isBa4

;     PINTA_CON_MASCARA
;     ;el ultimo PINTA_CON_MASCARA le quito los INC
;     LD      A,(BC)
;     LD      E,A
;     LD      A,(DE)
;     AND     (HL)
;     OR      E
;     LD      (HL),A
salir_isBa
    LD      SP,(Stack_Anterior)

    RET

;********************************************
Imprime_Sprite_Pantalla                        ;70T
    LD      (stack_anterior),SP

    LD      H,(IX+ _DSPR+1)
    LD      L,(IX+ _DSPR)
    XOR     A
    LD      E,(IX+ _SPR_A) ;antes A
    RL      E
    LD      D,0
    ADD     HL,DE
    LD      C,(HL)
    INC     HL
    LD      B,(HL)          ;BC-dirsprite

    LD      H,TABLA_SCANLINES_H
    LD      L,(IX+_ANTY)
    LD      E,(HL)
    INC     H
    LD      D,(HL)  ;DE screen address
    EX      DE,HL   ;sumo x ahora
    LD      D,0
    LD      E,(IX+_ANTX)
    ADD     HL,DE               ;HL-dirpan

    LD      E,C               ;HL-dirpan
    LD      D,B               ;DE-dirspr

    LD      A,(IX+_ANCHO)
    CP      6
    JR      Z,Imprime_Sprite_Prota
    LD      A,(IX+_ALTO)
    CP      8
    JP      Z,bucle4_bytes_wss_8a
    JP      bucle4_bytes_wss

                                                ;incluyendo los 70 de ISP
                                                ;2919-2923T  (impresion normal)
                                                ;            (blanco tb optimizada)
Imprime_Sprite_Prota
    LD      A,(SPRITE0_MIRADA)
    OR      A                                   ;CP   MIRO_DER
    JR      Z,rotado_ISP
    LD     (sm_dirsprite_ISPN+2),BC
    CALL   Imprime_Parte_Normal
sm_dirsprite_ISPN    
    LD      IY,0
    LD      DE,#360      ;me pongo en la parte de abajo del sprite
    ADD     IY,DE
    JP      Imprime_Parte_Rotada_conIY
rotado_ISP
    LD     (sm_dirsprite_ISPR+1),BC
    CALL   Imprime_Parte_Rotada
sm_dirsprite_ISPR    
    LD      DE,0
    EX      DE,HL
    LD      BC,#360      ;me pongo en la parte de abajo del sprite
    ADD     HL,BC
    EX      DE,HL
    LD      C,E
    LD      B,D

Imprime_Parte_Normal
    LD      (stack_anterior),SP
    LD      SP,#800-6
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras
    BIT     CHECK_MUERTE,(IX+_CHECKS)
    JP      NZ,Imprime_Parte_Normal_Blanco
    LD      A,12                ;dejo en b 8, y en C las Y
bucle_y_IPN
    EX      AF,AF'
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    ADD     HL,SP
    JR      NC,siguiente_scanline_IPN
    LD      SP,#C050
    ADD     HL,SP
    LD      SP,#800-6
siguiente_scanline_IPN
    EX      AF,AF'
    DEC     A
    JR      NZ,bucle_y_IPN
    LD      SP,(stack_anterior)
    RET

Imprime_Parte_Normal_Blanco
    LD      A,12                ;dejo en b 8, y en C las Y
bucle_y_IPNB
    EX      AF,AF'
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    ADD     HL,SP
    JR      NC,siguiente_scanline_IPNB
    LD      SP,#C050
    ADD     HL,SP
    LD      SP,#800-6
siguiente_scanline_IPNB
    EX      AF,AF'
    DEC     A
    JR      NZ,bucle_y_IPNB
    LD      SP,(stack_anterior)
    RET

Imprime_Parte_Rotada
    ;cargo en IY la dirección del sprite
    LD   IYH,B
    LD   IYL,C
Imprime_Parte_Rotada_conIY
    LD   (stack_anterior),SP
    LD   SP,#800+5
    LD   BC,5
    add  HL,BC
    LD   D,TABLA_MASCARASH_R
    bit  CHECK_MUERTE,(IX+_CHECKS)
    JP   NZ,Imprime_Parte_Rotada_Blanco
    LD      a,12                ;dejo en b 8, y en C las Y
bucle_y_IPR
    EX  AF,AF'
    PINTA_CON_MASCARA_ROTADO 0
    DEC   HL
    PINTA_CON_MASCARA_ROTADO 1
    DEC   HL
    PINTA_CON_MASCARA_ROTADO 2
    DEC   HL
    PINTA_CON_MASCARA_ROTADO 3
    DEC   HL
    PINTA_CON_MASCARA_ROTADO 4
    DEC   HL
    PINTA_CON_MASCARA_ROTADO 5
    LD    BC,6
    ADD   IY,BC
    ADD   HL,SP
    JR    NC,siguiente_scanline_IPR
    LD    SP,#C050
    ADD   HL,SP
    LD    SP,#800+5
siguiente_scanline_IPR
    EX    AF,AF'
    DEC   A
    JR    NZ,bucle_y_IPR
    LD    SP,-5
    ADD   HL,SP
    LD    SP,(stack_anterior)
    RET

Imprime_Parte_Rotada_Blanco
    LD      a,12                ;dejo en b 8, y en C las Y
bucle_y_IPRB
    EX      AF,AF'
    PINTA_CON_MASCARA_ROTADO_BLANCO 0
    DEC   HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 1
    DEC   HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 2
    DEC   HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 3
    DEC   HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 4
    DEC   HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 5
    LD    BC,6
    ADD   IY,BC
    ADD   HL,SP
    JR    NC,siguiente_scanline_IPRB
    LD    SP,#C050
    ADD   HL,SP
    LD    SP,#800+5
siguiente_scanline_IPRB
    EX  AF,AF'
    DEC     A
    JR      NZ,bucle_y_IPRB
    LD    SP,-5
    ADD   HL,SP
    LD      SP,(stack_anterior)
    RET

;********************************
bucle4_bytes_wss                        ;1163T (incluyendo 82 de ISP)
                                        ;      (blanco tb optimizada)
;     LD      A,(IX+_CHECKS)
;     BIT     CHECK_SIMETRIA,A
;     JR      NZ,es_simetrico_b4b
;     LD      A,(IX+ _MIRADA)
;     OR      A                                   ;CP   MIRO_DER
;     JP      Z,bucle4_bytes_rotado_wss
;todos los malos son simetricos , asi que me ahorro la comprobacion
;es_simetrico_b4b
    LD      SP,ANCHO_MAPA_BYTES-4

    BIT     CHECK_MUERTE,(IX+_CHECKS)
    JP      NZ,blanco_4_bytes_wss

    LD      a,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_4
    EX      af,af'
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    ADD     HL,SP
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA

    LD      DE,#800-#50-4
    ADD     HL,DE
    JR      NC,siguiente_scanline_wssd23_4
    LD      DE,#C050
    ADD     HL,DE
siguiente_scanline_wssd23_4

    EX      af,af'
    DEC     a
    JP      NZ,bucle_y_wssd23_4

    LD      SP,(stack_anterior)
    RET

blanco_4_bytes_wss

    LD      A,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23b_4
    EX      af,af'

    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    ADD     HL,SP
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO

    LD      DE,#800-#50-4
    ADD     HL,DE
    JR      NC,siguiente_scanline_wssd23b_4
    LD      DE,#C050
    ADD     HL,DE
siguiente_scanline_wssd23b_4

    EX      af,af'
    DEC     a
    JP      NZ,bucle_y_wssd23b_4

    LD      SP,(stack_anterior)
    RET

bucle4_bytes_wss_8a                         ;677T (incluyendo 79 de ISP)
                                            ;blanco tb optimizado
    LD      A,(IX+_CHECKS)
    BIT     CHECK_SIMETRIA,A
    JR      NZ,es_simetrico_b4b8a
    LD      A,(IX+ _MIRADA)
    OR      A                                   ;CP   MIRO_DER
    JP      Z,bucle4_bytes_rotado_wss_8a
es_simetrico_b4b8a
    LD      SP,#800-4

    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    BIT     CHECK_MUERTE,(IX+_CHECKS)
    JP      NZ,blanco4_bytes_wss_8a

    EX      AF,AF'
    LD      A,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_48a
    EX       AF,AF'

    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA
    PINTA_CON_MASCARA

    ADD     HL,SP
    JR      NC,siguiente_scanline_wssd23_48a
    LD      DE,#C050
    ADD     HL,DE
siguiente_scanline_wssd23_48a
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    EX      AF,AF'
    DEC     a

    JP      NZ,bucle_y_wssd23_48a

    LD      SP,(stack_anterior)
    RET


blanco4_bytes_wss_8a
    EX      AF,AF'
    LD      A,8                ;dejo en b 8, y en C las Y
blanco_y_wssd23_48a
    EX      AF,AF'

    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO
    PINTA_CON_MASCARA_BLANCO

    ADD     HL,SP
    JR      NC,siguiente_scanline_wssd23_48a_blanco
    LD      DE,#C050
    ADD     HL,DE
siguiente_scanline_wssd23_48a_blanco
    LD      D,TABLA_MASCARASH            ;Usamos DE para la tabla de m�scaras

    EX      AF,AF'
    DEC     A
    JP      NZ,blanco_y_wssd23_48a

    LD      SP,(stack_anterior)
    RET

; ;************************************
; bucle4_bytes_rotado_wss
;     LD      SP,ANCHO_MAPA_BYTES+3

;     ;cargo en IY la dirección del sprite
;     LD   IYH,B
;     LD   IYL,C

;     LD   BC,3
;     add  HL,BC

;     LD      D,TABLA_MASCARASH_R

;     BIT     CHECK_MUERTE,(IX+_CHECKS)
;     JP      NZ,blanco_4_bytes_rotado_wss

;     EXX
;     LD      B,8                ;dejo en b 8, y en C las Y
; bucle_y_wssd23r_4
;     EXX

;     REPEAT  1
;         PINTA_CON_MASCARA_ROTADO 0
;         DEC   HL
;         PINTA_CON_MASCARA_ROTADO 1
;         DEC   HL
;         PINTA_CON_MASCARA_ROTADO 2
;         DEC   HL
;         PINTA_CON_MASCARA_ROTADO 3
;         ADD   HL,SP
;         LD    BC,4
;         ADD   IY,BC
;     REND
;     PINTA_CON_MASCARA_ROTADO 0
;         DEC   HL
;     PINTA_CON_MASCARA_ROTADO 1
;         DEC   HL
;     PINTA_CON_MASCARA_ROTADO 2
;         DEC   HL
;     PINTA_CON_MASCARA_ROTADO 3
;         LD    BC,4
;         ADD   IY,BC

;     LD      DE,#800-#50+3
;     ADD     HL,DE
;     JR      NC,siguiente_scanline_wssd23r_4
;     LD      DE,#C050
;     ADD     HL,DE
; siguiente_scanline_wssd23r_4
;     LD      D,TABLA_MASCARASH_R            ;Usamos DE para la tabla de m�scaras

;     EXX

;     DEC     B
;     JP      NZ,bucle_y_wssd23r_4

;     LD      SP,(stack_anterior)
;     RET

; blanco_4_bytes_rotado_wss

;     EXX
;     LD      B,8                ;dejo en b 8, y en C las Y
; bucle_y_wssd23rb_4
;     EXX

;     REPEAT  1
;         PINTA_CON_MASCARA_ROTADO_BLANCO 0
;         DEC   HL
;         PINTA_CON_MASCARA_ROTADO_BLANCO 1
;         DEC   HL
;         PINTA_CON_MASCARA_ROTADO_BLANCO 2
;         DEC   HL
;         PINTA_CON_MASCARA_ROTADO_BLANCO 3
;         ADD   HL,SP
;         LD    BC,4
;         ADD   IY,BC
;     REND
;     PINTA_CON_MASCARA_ROTADO_BLANCO 0
;         DEC   HL
;     PINTA_CON_MASCARA_ROTADO_BLANCO 1
;         DEC   HL
;     PINTA_CON_MASCARA_ROTADO_BLANCO 2
;         DEC   HL
;     PINTA_CON_MASCARA_ROTADO_BLANCO 3
;         LD    BC,4
;         ADD   IY,BC

;     LD      DE,#800-#50+3
;     ADD     HL,DE
;     JR      NC,siguiente_scanline_wssd23rb_4
;     LD      DE,#C050
;     ADD     HL,DE
; siguiente_scanline_wssd23rb_4
;     LD      D,TABLA_MASCARASH_R            ;Usamos DE para la tabla de m�scaras

;     EXX

;     DEC     B
;     JP      NZ,bucle_y_wssd23rb_4

;     LD      SP,(stack_anterior)
;     RET

;---------------------------
blanco4_bytes_wss_8ar
    LD      SP,#800+3

    EXX
    LD      B,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_48a_rotadob
    EXX

    PINTA_CON_MASCARA_ROTADO_BLANCO 0
    DEC HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 1
    DEC HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 2
    DEC HL
    PINTA_CON_MASCARA_ROTADO_BLANCO 3
    LD    BC,4
    ADD   IY,BC

    ADD     HL,SP
    JR      NC,siguiente_scanline_wssd23_48arb
    LD      DE,#C050
    ADD     HL,DE
siguiente_scanline_wssd23_48arb
    LD      D,TABLA_MASCARASH_R            ;Usamos DE para la tabla de m�scaras

    EXX

    DEC     B
    JP      NZ,bucle_y_wssd23_48a_rotadob

    LD      SP,(stack_anterior)
    RET


;---------------------------
bucle4_bytes_rotado_wss_8a
    LD      SP,#800+3

    ;cargo en IY la dirección del sprite
    LD   IYH,B
    LD   IYL,C

    LD   BC,3
    add  HL,BC

    LD      D,TABLA_MASCARASH_R            ;Usamos DE para la tabla de m�scaras

    BIT     CHECK_MUERTE,(IX+_CHECKS)
    JP      NZ,blanco4_bytes_wss_8ar

    EXX
    LD      B,8                ;dejo en b 8, y en C las Y
bucle_y_wssd23_48a_rotado
    EXX

    PINTA_CON_MASCARA_ROTADO 0
    DEC HL
    PINTA_CON_MASCARA_ROTADO 1
    DEC HL
    PINTA_CON_MASCARA_ROTADO 2
    DEC HL
    PINTA_CON_MASCARA_ROTADO 3
    LD    BC,4
    ADD   IY,BC

    ADD     HL,SP
    JR      NC,siguiente_scanline_wssd23_48ar
    LD      DE,#C050
    ADD     HL,DE
siguiente_scanline_wssd23_48ar
    LD      D,TABLA_MASCARASH_R            ;Usamos DE para la tabla de m�scaras

    EXX

    DEC     B
    JP      NZ,bucle_y_wssd23_48a_rotado

    LD      SP,(stack_anterior)
    RET