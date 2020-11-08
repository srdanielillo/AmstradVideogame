pinta_boss
; 	ld de,sng_boss
; 	call ply_init
	LD  HL,SPRITE1_INT
	LD  (HL),0
	inc HL
	LD  (HL),0
	inc HL
	LD  (HL),0
	inc HL
	LD  (HL),0
	inc HL
	LD  (HL),0

	LD HL,sprite5
	ld (HL),5 ;id
	inc hl
	ld (hl),8 ;ancho
	inc hl
	ld (hl),16;alto
	inc hl
	ld (hl),#27 ;x
	inc hl
	ld (hl),#27 ;antx
	inc hl
	ld (hl),56+32 ;y
	inc hl
	ld (hl),56+32 ;anty
	ld ix,sprite5
	ld hl,TIPO_BOSS
	CALL Coge_Supersprites_HL
	ld hl,SPRITE5_VIDA
	LD (hl),30

	ld hl,dstile_boss
	ld bc,#0a11
	XOR A
	LD (CHECK_ASIGNA_DUREZAS),A
	JP Pinta_Supertile_HL

activa_enemigos_boss
	ld a,3
	ld (semaforo_ia_prota),a
	ld a,0
	CALL	Actualiza_Tabla_INT_isp

	LD A,1
	CALL    lanza_torreta
; 	CALL	Actualiza_Tabla_INT_cfp
; 	CALL	Actualiza_Tabla_INT_isp
; 	LD      A,FX_exp_grande
; 	CALL    Toca_FX_Pos
; 	CALL    espera_10_barridos

	LD A,2
	CALL    lanza_torreta
; 	CALL	Actualiza_Tabla_INT_cfp
; 	CALL	Actualiza_Tabla_INT_isp
; 	LD      A,FX_exp_grande
; 	CALL    Toca_FX_Pos
; 	CALL    espera_10_barridos

	LD A,3
	CALL    lanza_torreta
; 	CALL	Actualiza_Tabla_INT_cfp
; 	CALL	Actualiza_Tabla_INT_isp
; 	LD      A,FX_exp_grande
; 	CALL    Toca_FX_Pos
; 	CALL    espera_10_barridos

	LD A,4
	CALL    lanza_torreta
; 	CALL	Actualiza_Tabla_INT_cfp
; 	CALL	Actualiza_Tabla_INT_isp
; 	LD      A,FX_exp_grande
; 	CALL    Toca_FX_Pos
; 	CALL    espera_10_barridos

	LD A,1
	CALL	Actualiza_Tabla_INT_UPD
	LD A,2
	CALL	Actualiza_Tabla_INT_UPD
	LD A,3
	CALL	Actualiza_Tabla_INT_UPD
	LD A,4
	CALL	Actualiza_Tabla_INT_UPD
	LD A,5
	JP   	Actualiza_Tabla_INT_UPD

lanza_torreta
	CALL	Actualiza_Tabla_INT_cfp
	;CALL	Actualiza_Tabla_INT_UPD
	CALL	Actualiza_Tabla_INT_isp
	LD      A,FX_exp_grande
	CALL    Toca_FX_Pos
;	JR      espera_10_barridos

espera_10_barridos
; 	ld a,#fd
; 	ld (SEMAFORO_SPR_INT),A
	LD      B,40
e10b
	push    bc
	CALL    wVb
	ld a,3
	ld (semaforo_ia_prota),a
	ld a,0
	CALL	Actualiza_Tabla_INT_isp
	pop     bc
	DJNZ    e10b
; 	ld a,0
; 	ld (SEMAFORO_SPR_INT),A
	RET

update_boss
	SET     CHECK_MUERE,(IX+_CHECKS)
	RES     CHECK_NIVEL,(IX+_CHECKS)
	SET     CHECK_ABIERTO,(IX+_CHECKS)
	LD      A,(IX+_VIDAS)
	OR      A
	JR      Z,fin_boss
	BIT     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	RET     Z
	RES     CHECK_MUERTE_DESDE,(IX+_CHECKS)
	LD      A,(IX+_VIDAS)
	OR      A
	RET     Z
	DEC     A
	LD      (IX+_VIDAS),A
	LD      A,4
	LD      (EFECTO_FLASH),A
	Ld      A,FX_imp_art_cerrado
	JP      Toca_FX_Pos

fin_boss
	LD      A,1
	LD      (fin_juego),A
	RET

; explota_morir_ini
; 	LD      HL,DSPR_EXPLOSION_MALO
; 	LD      (IX+_DSPR),L
; 	LD      (IX+_DSPR+1),H
; 	LD	    (IX+_CAD),0
; 	LD      (IX+_ICAD),1
; 	LD      (IX+_SPR),5
; 	LD      (IX+_SPR_A),5
; 	LD      (IX+_ALTO),16
; 	LD      (IX+_ANCHO),8
; 	CALL  	Siguiente_Sprite
; 	LD      HL,explota_morir
; 	LD      (IX+_UPD),L
; 	LD      (IX+_UPD+1),H
; 	LD		A,(IX+_ID)
; 	JP		Actualiza_Tabla_INT_cfp_isp_ibp

; explota_morir
; 	LD	A,(IX+_CAD)
; 	OR	A
; 	JR	Z,mueve_exm
; 	DEC	(IX+_CAD)
; 	JP	sigue_exm
; mueve_exm
; 	LD	A,(IX+_ICAD)
; 	LD	(IX+_CAD),A
; 	CALL    Siguiente_Sprite
; 	LD      A,(IX+_SPR_A)
; 	OR      A
; 	RET     Z
; sigue_exm
; 	LD		A,(IX+_ID)
; 	CALL 	Actualiza_Tabla_INT_isp
; 	JP		Actualiza_Tabla_INT_ibp

explota_explota_ini
	LD      A,(IX+_ID)
	RLA     
	RLA     
	LD      (IX+_ICAD),A
	LD      HL,explota_explota_ini1
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	LD		A,(IX+_ID)
	JP		Actualiza_Tabla_INT_cfp_isp_ibp

explota_explota_ini1
	DEC 	(IX+_ICAD)
	JP      NZ,Actualiza_Tabla_INT_ibp
	LD      HL,DSPR_EXPLOSION_MALO
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD	    (IX+_CAD),0
	LD      (IX+_ICAD),1
	LD      (IX+_SPR),5
	LD      (IX+_SPR_A),5
	CALL  	Siguiente_Sprite
	LD      HL,explota_explota
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	JR      comun_mueve
; 	LD		A,(IX+_ID)
; 	CALL 	Actualiza_Tabla_INT_isp
; 	JP		Actualiza_Tabla_INT_ibp

explota_explota
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_ee
	DEC	(IX+_CAD)
	JP	sigue_ee
mueve_ee
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	CALL    Siguiente_Sprite
	LD      A,(IX+_SPR_A)
	OR      A
	JR      NZ,sigue_ee
	LD      DE,nueva_posicion_ee
	Ld      (IX+_UPD),E
	Ld      (IX+_UPD+1),D
	JP      Actualiza_Tabla_INT_ibp
sigue_ee
comun_mueve
	LD		A,(IX+_ID)
	CALL 	Actualiza_Tabla_INT_isp
	JP		Actualiza_Tabla_INT_ibp

rangos
	db      0,16
	DB 		20,36
	db      40,56
	db      60,76
nueva_posicion_ee
	ld      hl,rangos-2
	ld      b,0
	LD      c,(IX+_ID)
	rlc     c
	add     hl,bc
	ld      b,(hl)
	inc     hl
	ld      c,(hl)
	CALL    Random_B_C_q
	LD      (IX+_X),A
	LD      B,8*5
	LD      C,8*23
	CALL    Random_B_C_q
	LD      (IX+_Y),A
	CALL    Captura_Bloque_Fondo_Pantalla
	LD      A,FX_exp_pequena
	CALL    Toca_FX_Pos
	LD      DE,explota_explota
	Ld      (IX+_UPD),E
	Ld      (IX+_UPD+1),D
	LD		A,(IX+_ID)
	jp   	Actualiza_Tabla_INT_UPD

Random_B_C_q
    call Random
    cp   b
    jr   c,Random_B_C_mn
    cp   c
    jr   nc,Random_B_C_my
    ret
Random_B_C_mn
	ld   a,b
	ret
Random_B_C_my
	ld   a,c
	ret

ix_udp
	LD      (IX+_UPD),L
	LD      (IX+_UPD+1),H
	RET

ending
	LD      IX,SPRITE1
	LD      HL,explota_explota_ini
	CALL    ix_udp
; 	LD      (IX+_UPD),L
; 	LD      (IX+_UPD+1),H
	LD      IX,SPRITE2
	CALL    ix_udp
; 	LD      (IX+_UPD),L
; 	LD      (IX+_UPD+1),H
	LD      IX,SPRITE3
	CALL    ix_udp
; 	LD      (IX+_UPD),L
; 	LD      (IX+_UPD+1),H
	LD      IX,SPRITE4
	CALL    ix_udp
; 	LD      (IX+_UPD),L
; 	LD      (IX+_UPD+1),H

	LD      b,250
	CALL    espera_f

	LD  HL,SPRITE1_INT
	LD  (HL),BIT_iBp
	inc HL
	LD  (HL),BIT_iBp
	inc HL
	LD  (HL),BIT_iBp
	inc HL
	LD  (HL),BIT_iBp

	LD      b,2
	CALL    espera_f

 	LD   HL,TEXTO_7
	CALL pinta_texto_OTT_sin_interactuar

	LD  HL,SPRITE1_INT
	LD  (HL),8
	inc HL
	LD  (HL),8
	inc HL
	LD  (HL),8
	inc HL
	LD  (HL),8

	LD      b,250
	CALL    espera_f

	LD      A,(SPRITE0_VIDAS)
	ADD     PUNTOS_BOSS
	CALL 	Inc_Puntos
	LD		HL,SPRITE0_CHECKS
	SET		CHECK_CAMBIO,(HL)
	LD      A,50
	LD      (Pantalla_Siguiente),A
	XOR     A
	LD      (fin_juego),A
	RET

explota_morir
	LD  A,(IX+_TAG)
	OR  A
	jr  Z,pona1_em
	LD	A,(IX+_CAD)
	OR	A
	JR	Z,mueve_eme
	DEC	(IX+_CAD)
	JR	sigue_eme
mueve_eme
	LD	A,(IX+_ICAD)
	LD	(IX+_CAD),A
	CALL    Siguiente_Sprite
	LD  A,(IX+_SPR_A)
	OR  A
	JR  NZ,sigue_eme
	LD  (IX+_SPR_A),6
	LD  (IX+_TAG),A
sigue_eme
	LD		A,(IX+_ID)
	CALL   	Actualiza_Tabla_INT_UPD
	CALL	Actualiza_Tabla_INT_cfp_isp_ibp
	ld  a,2
	ld (semaforo_ia_prota),a

	ld      a,(sm_explosion+1)
	or      a
	jr      nz,pona1_em
	LD      a,1
	jr      siguea_em
pona1_em
	xor     a
siguea_em
	ld      (sm_explosion+1),a

	RET

explota_al_morir
	LD      IX,SPRITE0
	LD      HL,DSPR_EXPLOSION_MALO
	LD      (IX+_DSPR),L
	LD      (IX+_DSPR+1),H
	LD      (IX+_SPR),6
	LD      (IX+_SPR_A),0
	LD      (IX+_ALTO),16
	LD      (IX+_ANCHO),8
	LD      (IX+_TAG),1
	RES     CHECK_MUERTE,(IX+_CHECKS)
	LD      HL,explota_morir
	CALL    ix_udp
	INC     (IX+_X)
	LD      A,(IX+_Y)
	add     4
	LD      (IX+_Y),A

	LD	    (IX+_CAD),0
	LD      (IX+_ICAD),3
	xor     a
	CALL   	Actualiza_Tabla_INT_UPD
	JP		Actualiza_Tabla_INT_cfp_isp_ibp

espera_f
	LD      A,(Pas_Interrupcion)
	ADD     B
	LD      B,A
espera_ef
	ld      a,(sm_explosion+1)
	or      a
	jr      nz,pona1
	LD      a,1
	jr      siguea
pona1
	xor     a
siguea
	ld      (sm_explosion+1),a

	push bc
	push hl
	ld a,3
	ld (semaforo_ia_prota),a
	ld a,0
	CALL	Actualiza_Tabla_INT_isp
	pop hl
	pop bc

	LD      A,(Pas_Interrupcion)    
	CP      B
	JR      NZ,espera_ef
	xor     a
	ld      (sm_explosion+1),a
RET

Pinta_texto_fIN
	LD   BC,#0C05
	LD   HL,TEXTO_FIN1
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	CALL Imprime_Texto
	LD   HL,TEXTO_FIN2
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	LD   BC,#0D0A
	CALL Imprime_Texto
	LD   HL,TEXTO_FIN3
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	LD   BC,#0E08
	CALL Imprime_Texto

	LD   HL,TEXTO_FIN4
	LD   D,COLOR_ROJO2
	LD   E,JUEGO_TILES_2
	LD   BC,#100a			
	CALL Imprime_Texto

	LD   HL,TEXTO_FIN5
	LD   D,COLOR_ROJO1
	LD   E,JUEGO_TILES_2
	LD   BC,#1305
	CALL Imprime_Texto

	LD   HL,TEXTO_FIN6
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#1610
	CALL Imprime_Texto

	LD   HL,dstile_estrella
	LD   BC,#031d
	JP   Pinta_Supertile_HL

  
TEXTO_5                 DM "HOLY GOD! I THINK I'VE REACHED THE",0
                        DM "COMMAND CENTER OF THESE CREATURES.",0
                        DM "I FEEL THE GELID LOOK OF HIS EYE.",255
TEXTO_6                 DM "I CAN NOT LET THESE HORRORS GET",0
                        DM "OUT OF HERE. I HAVE TO PUT AN END",0
                        DM "TO ALL THIS HERE AND NOW.",255

TEXTO_FIN1    DM "YOU HAVE MANAGED TO PUT AN END",255
TEXTO_FIN2    DM "TO A TERRIBLE THREAT",255
TEXTO_FIN3    DM "BY GIVING YOUR OWN LIFE",255
TEXTO_FIN4    DM "YOU ARE A TRUE HERO!",255
TEXTO_FIN5    DM "OPERATION ALEXANDRA ENDS HERE",255
TEXTO_FIN6    DM "GAME OVER",255
