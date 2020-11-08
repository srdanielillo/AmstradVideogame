; Este codigo fuente se puede distribuir libremente
; y utilizar para lo que se quiera por quien quiera
; siempre y cuando no sea para uso lucrativo y que se 
; mencione a 4mhz.es como creador del mismo

; CONFIGURACION DE ENSAMBLADOR

WRITE DIRECT -1,-1,#c0
run	start

NOLIST

READ	"H Constantes.asm"
READ	"H macros.asm"

ORG	INICIO_CODIGO

inicio_menu
	;inicializa
	;CALL	fadeout

inicio_menu_sm
	LD  a,(pantalla_actual)
	cp  PANTALLA_FIN
	jr  z,no_cambies_musica
	LD	DE,SNG_MENU
	CALL	PLY_Init
	xor a
	LD  (HAY_MUSICA),A
no_cambies_musica
	ld de,SNG_FX
	call PLY_SFX_Init

	XOR    a
	LD     (EFECTO_TINTAS),A
    
    ;LD      HL,TINTAS_NEGRO
	;CALL    Cambia_Tintas_Marcador
	CALL	fadeout

	LD      A,PANTALLA_MENU
	CALL	Pinta_Pantalla
	;CALL	Vuelca_Marcador
	CALL	fadein

	XOR	 A
	LD   (TEXTO_ANIMADO),A
	ld   (Pas_Interrupcion),a
inicio_bucle_menu
	LD   A,(Pas_Interrupcion)
	CP   25
	JR   NZ,teclado_ibm
	xor  a
	ld   (Pas_Interrupcion),a
	LD   A,(TEXTO_ANIMADO)
	cp   0
	JR   z,otro_ibm
	LD   A,0
	LD   HL,TEXTO_PRESSPLAY_B
	jr   sigue_ibm
otro_ibm
	ld   a,1
	LD   HL,TEXTO_PRESSPLAY
sigue_ibm
	ld   (TEXTO_ANIMADO),A
	LD   D,COLOR_ROJO2
	LD   E,JUEGO_TILES_2
	LD   BC,#0a0B
	CALL Imprime_Texto

teclado_ibm
	LD  A,(TECLADO0)
  	BIT JOY_FIRE1,A
	JR	Z,inicio_bucle_menu

	LD      A,FX_press_fire	
	CALL    Toca_FX_Pos

	;**********************
; 	JR  fin_3seg	;QUITAR
	;**********************
	XOR	 A
	LD   (TEXTO_ANIMADO),A
	ld   (Pas_Interrupcion),a
	ld   b,a
inicio_bucle_3seg
	LD   A,(Pas_Interrupcion)
	CP   5
	JR   NZ,inicio_bucle_3seg
	inc  b
	ld   a,b
	cp   25
	jr   z,fin_3seg
	push bc
	xor  a
	ld   (Pas_Interrupcion),a
	LD   A,(TEXTO_ANIMADO)
	cp   0
	JR   z,otro_3seg
	LD   A,0
	LD   HL,TEXTO_PRESSPLAY_B
	jr   sigue_3seg
otro_3seg
	ld   a,1
	LD   HL,TEXTO_PRESSPLAY
sigue_3seg
	ld   (TEXTO_ANIMADO),A
	LD   D,COLOR_ROJO2
	LD   E,JUEGO_TILES_2
	LD   BC,#0a0B
	CALL Imprime_Texto
	pop  bc
	JR	 inicio_bucle_3seg
fin_3seg
	;inicializo semillas de random
	ld		a,r
	ld      (seed1),A
	ld		a,r
	ld      (seed1+1),A
	ld      a,(Pas_Interrupcion)
	ld      (seed2),a
	ld      a,(Sig_Interrupcion)
	ld      (seed2+1),a

	;comentado inicio en checkpoints
	;LD	A,(Zonas_Liberadas)
	;OR	A
	;JR	Z,inicio_normal_juego

	;CALL	nuevo_menu
	;JR	inicio_check

inicio_normal_juego
	LD	A,PANTALLA_INICIO
	LD	BC,#0008
inicio_check
	PUSH	BC
	PUSH	AF
	CALL	fadeout

 	;LD      HL,TINTAS_JUEGO
	;CALL    Cambia_Tintas_Marcador

	;inicializo los objetos para que aparezcan 
	LD	HL,TABLA_OBJETOS
	LD	DE,TABLA_OBJETOS+1
	LD	(HL),1
	LD  BC,NUMERO_OBJETOS-1
	LDIR

	LD      HL,0
	LD      (SCORE),HL
	LD      (SCORE_A),HL
	LD      (TEMP_OBJETO),HL

	LD      A,10
	LD      (SPRITE0_VIDAS),A
	CALL    Pinta_HUD_Juego

	LD	DE,SNG_INGAME
	CALL PLY_Init

	POP	AF
	CALL	Pinta_Pantalla
	;CALL    fadein

	LD       HL,TINTAS_JUEGO
	CALL     Cambia_Tintas_Marcador

	POP	BC

; 	LD	HL,0
; 	LD	(CHECK_MARCADOR0),HL
; 	LD	(CHECK_MARCADOR1),HL

	LD	IX,SPRITE0
	LD	BC,#8003		;posición (y,x)=(0,8)
	LD	HL,DSPR_PROTA_REPOSO	;posición del sprite
	LD	DE,#0618		;ancho y alto
	LD	A,0			;número de sprites
	EX	AF,AF'  ;'
	LD	A,0			;ID del sprite
	LD  (INVULNERABLE),A
	EXX
	LD	HL,Update_Prota		;rutina de UPDATE del prota
	LD	D,DERECHA
	LD	E,#FF			;no captura buffer de fondo
	LD	B,#FF
	CALL	Inicializa_Sprite

	CALL    inicio_reposar_Prota

	;CALL	Bck_Sprite0
	;LD	A,9
	;LD	(SPRITE0_VIDAS),A
	;CALL	imprime_vidas

inicio_bucle_juego

	LD      A,(fin_juego)
	OR      A
	CALL    NZ,ending
cambia_pan
	LD		HL,SPRITE0_CHECKS
	BIT		CHECK_CAMBIO,(HL)
	LD		A,(Pantalla_Siguiente)
	CALL	NZ,Pinta_Pantalla
; 	JR      salta_ending
; llama_ending
; 	CALL    ending
; 	JR      cambia_pan
; salta_ending
	;CALL aplica_efectos_tintas
	LD      A,(PANTALLA_ACTUAL)
	CP      PANTALLA_FIN
	JP      Z,sal_al_menu

	LD      A,(SEMAFORO_IA_PROTA)
	cp      2
	jr      z,sigue_bucle_disparos_juego
espera_ia_prota
	LD      A,(SEMAFORO_IA_PROTA)
	CP 		1
	JR      NZ,espera_ia_prota

    LD      IX,SPRITE0
    LD      HL,SPRITE0_INT
    CALL    Ejecuta_Rutina_Sprite

	LD      A,2
	LD      (SEMAFORO_IA_PROTA),A
	;JR 		sigue_bucle_juego

sigue_bucle_disparos_juego
	LD      A,(SEMAFORO_IA_DISPAROS0)
	CP 		2
	JR      Z,sigue_bucle_juego
espera_ia_disparos
	LD      A,(SEMAFORO_IA_DISPAROS0)
	CP 		1
	JR      NZ,espera_ia_disparos
;aqui se podria meter los cambios de color
    LD      IX,DISPARO0
    LD      HL,DISPARO0_INT
    CALL    Ejecuta_Rutina_Sprite
    LD      IX,DISPARO1
    LD      HL,DISPARO1_INT
    CALL    Ejecuta_Rutina_Sprite
    LD      IX,DISPARO2
    LD      HL,DISPARO2_INT
    CALL    Ejecuta_Rutina_Sprite
    LD      IX,DISPARO3
    LD      HL,DISPARO3_INT
    CALL    Ejecuta_Rutina_Sprite
    LD      IX,DISPARO4
    LD      HL,DISPARO4_INT
    CALL    Ejecuta_Rutina_Sprite
;     LD      IX,DISPARO5
;     LD      HL,DISPARO5_INT
;     CALL    Ejecuta_Rutina_Sprite

	LD      A,2
	LD      (SEMAFORO_IA_DISPAROS0),A

	CALL	Prota_Toca_Objeto

	LD      A,(CHECK_BOMBONA)
	OR      A
	JR      Z,sigue_bucle_juego
sera_la_bombona
	XOR     A
	LD      (CHECK_BOMBONA),A
	LD   	IY,STATIC2
	LD      A,(iy+S_ID)
	CALL   	mira_otro_OPT1

;pendiente de optimizacion
; 	LD   	IY,#011E
; 	CALL    pinta_high_score_sin_verificar
; 	LD      IY,#011f
; 	LD      D,COLOR_MORADO
; 	CALL    Activa_Color
; 	CALL    pinta_ceros_derecha_sin_color
sigue_bucle_juego
	LD   	IY,#021E
	CALL    pinta_puntos
	LD   	IY,#011E
	CALL    pinta_high_score

    LD      A,(TECLADO0)
    BIT     KEY_ESCAPE,A
    JR      Z,comprueba_vidas_sbj

	LD      A,FX_menu_esc
	CALL    Toca_FX_Pos

    LD      A,#FE
    LD      (SEMAFORO_SPR_INT),A
; 	CALL    Backup_TINT

	LD      A,(Sig_Interrupcion)
	push    af

    CALL	Pinta_HUD_Input_Fin

    LD      A,(INPUT11)
    CP      64
    JR      NZ,mensaje_fin_sm
    CALL    Pinta_HUD_Juego

;    CALL	Restore_TINT

    pop     af
	dec     a
	cp      #ff
	jr      nz,espera_prev_int
	ld      a,5    
espera_prev_int
	ld      b,a
espera_int
    LD   	a,(Sig_Interrupcion)
    cp      b
    jr      nz,espera_int

	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#00	;activo int de cfp


comprueba_vidas_sbj
	LD	A,(SPRITE0_VIDAS)
	OR	A
	JP	NZ,inicio_bucle_juego
	;explota el prota
	LD      A,FX_exp_grande
	CALL    Toca_FX_Pos
	CALL    explota_al_morir
	ld  b,150
	call espera_fs
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp
	LD   HL,TEXTO_FIN6
	LD   D,COLOR_MORADO
	LD   E,JUEGO_TILES_2
	LD   BC,#0d10
	CALL Imprime_Texto
	ld  b,250
	call espera_fs
	JP		inicio_menu_sm
sal_al_menu
    LD      A,(TECLADO0)
    OR      A
    JR      Z,sal_al_menu
;    LD      A,(TECLADO1)
;   OR      A
;    JR      Z,sal_al_menu
sal_al_menu2
	LD	HL,SEMAFORO_SPR_INT
	LD	(HL),#FE	;desactivo int de cfp

	JP		inicio_menu_sm
mensaje_fin_sm
	pop     af
	JP		inicio_menu_sm
 	;LD      HL,TEXTO_EJEMPLO
	;CALL    Pinta_HUD_Texto

tricks
; 	LD  IX,SPRITE0
; 	LD	HL,TECLADO0
; 	BIT	KEY_F2,(HL)
; 	CALL NZ,pantalla_abajo
; 	LD	HL,TECLADO1
; 	BIT	KEY_F8,(HL)
; 	CALL NZ,pantalla_arriba
; 	LD	HL,TECLADO1
; 	BIT	KEY_F6,(HL)
; 	CALL NZ,pantalla_derecha
; 	LD	HL,TECLADO1
; 	BIT	KEY_F4,(HL)
; 	CALL NZ,pantalla_izquierda
; 	LD	HL,TECLADO1
; 	BIT	KEY_5,(HL)
; 	CALL NZ,truco_vida
; 	JP		inicio_bucle_juego

MAP_CODE_INTERRUPCIONES
	READ	"H Interrupciones.asm"
MAP_CODE_PANTALLAS_TILES
	READ	"H Pantallas-Tiles.asm"
MAP_CODE_PROTA
	READ	"H Prota vs 2.asm"
MAP_CODE_DISPARO
	READ	"H Disparo.asm"
MAP_CODE_MALOS
	READ	"H Malos.asm"
MAP_CODE_STATICS
	READ	"H Statics.asm"
MAP_CODE_TECSOUND
	READ    "H TecSoundOtros.asm"
MAP_CODE_ARKOS
	READ	"H ArkosTrackerPlayer_CPC_MSX.asm"
MAP_CODE_GRAFICAS
	READ	"H Graficas vs 1.asm"
MAP_CODE_FIN
	;READ	"H Split.asm"
	READ	"H Binarios.asm"

	READ	"H Data.asm"
MAP_CODE_SPRITES
	READ	"H Sprites.asm"
MAP_CODE_COLISIONES
	READ	"H Colisiones.asm"
MAP_CODE_BOSS
	READ    "H Boss.asm"
MAP_CODE_TABLAS
	READ	"H Tablas.asm"
FIN_BUFFER
; 	READ	"H DataSup.asm"

fin_codigo_alto
	READ	"H Bloques1KB.asm"

;aprovechando huecos en tabla de scanline
ORG &77c1
TEXTO_BESTSCORE   DM "BEST SCORE:",255        ;12
TEXTO_LASTSCORE   DM "LAST SCORE:",255        ;12
TEXTO_PRESSPLAY   DM "PRESS FIRE TO PLAY",255 ;19
TEXTO_PRESSPLAY_B DM "                  ",255 ;19
Pas_Interrupcion        DB      0			  ;1
ORG &78c1
;definición de los objetos de la pantalla
STATIC0
        STATIC0_ID      DB      0       ;ID del objeto
        STATIC0_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC0_X       DB      0       ;X
        STATIC0_Y       DB      0       ;Y
        STATIC0_STILE   DW      0       ;STile a pintar
        STATIC0_CONS    DW      0       ;código para inicialización del objeto
        STATIC0_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC0_TAG     DB      0       ;para usar a discrección
        STATIC0_BUFFER  DW      0       ;buffer del fondo
STATIC1
        STATIC1_ID      DB      0       ;ID del objeto
        STATIC1_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC1_X       DB      0       ;X
        STATIC1_Y       DB      0       ;Y
        STATIC1_STILE   DW      0       ;STile a pintar
        STATIC1_CONS    DW      0       ;código para inicialización del objeto
        STATIC1_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC1_TAG     DB      0       ;para usar a discrección
        STATIC1_BUFFER  DW      0       ;buffer del fondo
STATIC2
        STATIC2_ID      DB      0       ;ID del objeto
        STATIC2_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC2_X       DB      0       ;X
        STATIC2_Y       DB      0       ;Y
        STATIC2_STILE   DW      0       ;STile a pintar
        STATIC2_CONS    DW      0       ;código para inicialización del objeto
        STATIC2_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC2_TAG     DB      0       ;para usar a discrección
        STATIC2_BUFFER  DW      0       ;buffer del fondo
STATIC3
        STATIC3_ID      DB      0       ;ID del objeto
        STATIC3_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
        STATIC3_X       DB      0       ;X
        STATIC3_Y       DB      0       ;Y
        STATIC3_STILE   DW      0       ;STile a pintar
        STATIC3_CONS    DW      0       ;código para inicialización del objeto
        STATIC3_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
        STATIC3_TAG     DB      0       ;para usar a discrección
        STATIC3_BUFFER  DW      0       ;buffer del fondo

TEXTO_GFX         DM "GAMEDESIGN",255 ;11
