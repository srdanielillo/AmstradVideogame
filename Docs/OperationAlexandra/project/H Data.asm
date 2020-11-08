;
;Aquí empieza la DATA DIVISION propia del juego
;
TINTAS_JUEGO3
  DB      #54
  DB      #5C,#54,#54,#44,#44,#44,#44,#44,#44,#5c,#5c,#5c,#5c,#5c,#55,#55
TINTAS_JUEGO4
  DB      #54
  DB      #44,#54,#54,#44,#54,#54,#54,#54,#54,#44,#44,#44,#44,#44,#44,#44
TINTAS_NEGRO
  DB      #54
  DB      #54,#54,#54,#54,#54,#54,#54,#54
  DB      #54,#54,#54,#54,#54,#54,#54,#54
TINTAS_PENUMBRA
  DB  #54
  DB  #4f,#54,#54,#44,#5c,#58,#56,#5d,#56,#56,#46,#57,#5e,#5e,#4e,#53

PALETA0 DB #54,#5f,#54,#4b,#54,#54,#54,#5f,#54,#54,#54,#5d,#54,#54,#54,#54,#4b
PALETA1 DB #54,#5f,#54,#54,#4b,#54,#54,#54,#5f,#54,#54,#5d,#54,#54,#54,#54,#4b
PALETA2 DB #54,#5f,#54,#54,#54,#4b,#54,#54,#54,#5f,#54,#54,#5d,#54,#54,#54,#4b
PALETA3 DB #54,#5f,#54,#54,#54,#54,#4b,#54,#54,#54,#5f,#54,#5d,#54,#54,#54,#4b
PALETA4 DB #54,#5f,#54,#4b,#54,#54,#54,#5f,#54,#54,#54,#54,#54,#5d,#54,#54,#4b
PALETA5 DB #54,#5f,#54,#54,#4b,#54,#54,#54,#5f,#54,#54,#54,#54,#5d,#54,#54,#4b
PALETA6 DB #54,#5f,#54,#54,#54,#4b,#54,#54,#54,#5f,#54,#54,#54,#54,#5d,#54,#4b
PALETA7 DB #54,#5f,#54,#54,#54,#54,#4b,#54,#54,#54,#5f,#54,#54,#54,#5d,#54,#4b

nieve_actual db 0

pantallas_efecto_parpadeo DB 4,18,19,20,21
pantallas_efecto_penumbra DB 3,27,28,29
pantallas_efecto_nieve1   DB 4,26,5,1,4
pantallas_efecto_nieve2   DB 4,17,6,2,3
; ZONA0 DS 17
; ZONA2 DS 17
; ZONA3 DS 17
; ZONA4 DS 17


;definición de las direcciones de los sprites

DSPR_ALMEJA_ABRIR       DW ALMEJA+192,ALMEJA+128,ALMEJA+128,ALMEJA+64,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA  ;21

DSPR_RANA_SALTO         DW RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64,RANA+64                  ;13
                        DW RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96,RANA+96  ;15
DSPR_RANA_ATERRIZA      DW RANA+96,RANA+32,RANA+64,RANA+64,RANA+96,RANA+96,RANA+32,RANA+32,RANA+64,RANA+64  ;9
DSPR_TORRETA_GIRA       DW TORRETA,TORRETA+64,TORRETA+64,TORRETA+64,TORRETA+64,TORRETA+128,TORRETA+128,TORRETA+128,TORRETA,TORRETA,TORRETA  ;11
                        DW TORRETA+64,TORRETA+64,TORRETA+64,TORRETA+128,TORRETA+128,TORRETA+128,TORRETA,TORRETA+64,TORRETA+128      ;9
                        DW TORRETA,TORRETA+64,TORRETA+128,TORRETA,TORRETA+64,TORRETA+128,   TORRETA,TORRETA+64,TORRETA+128          ;9
                        DW TORRETA,TORRETA+64,TORRETA+128,TORRETA,TORRETA+64,TORRETA+128,TORRETA,TORRETA,TORRETA+64,TORRETA+64     ;10
                        DW TORRETA+128,TORRETA+128,TORRETA+128,TORRETA,TORRETA,TORRETA,TORRETA+64,TORRETA+64,TORRETA+64,TORRETA+64  ;10
                        DW TORRETA+128,TORRETA+128,TORRETA+128,TORRETA+128;,TORRETA                                                  ;5
DSPR_PLANTA_ABRE        DW PLANTA,PLANTA+64,PLANTA+128,PLANTA+192,PLANTA+192  ;5
                        DW PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128
                        DW PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128,PLANTA+128
                        DW PLANTA+192,PLANTA+192,PLANTA+128,PLANTA+64,PLANTA+0
DSPR_DISPARADOR         DW DISPARADOR,DISPARADOR,DISPARADOR+32,DISPARADOR+32,DISPARADOR+64,DISPARADOR+64,DISPARADOR+96,DISPARADOR+96  ;8
DSPR_PLANTA             DW PLANTA   ;1
DSPR_PULPO_ARR          DW PULPO_ARR,PULPO_ARR+64,PULPO_ARR+128,PULPO_ARR+192,PULPO_ARR+192+64,PULPO_ARR+192+128,PULPO_ARR+192+192
DSPR_ALMEJA_ABIERTA     DW ALMEJA       ;1
DSPR_ALMEJA_CERRADA     DW ALMEJA+192   ;1
DSPR_RANA_STANDBY
DSPR_RANA_CORRER        DW RANA,RANA+32,RANA,RANA+64  ;4
DSPR_DISPARO_DES        DW BALA+36,BALA+24,BALA+12,BALA;,BALA_EXP   ;esta va al revés 4
DSPR_TORRETA            DW TORRETA  ;1

PATH_PARABOLA
                  DB  1,-4
                  DB  1,-4
                  DB  1,-3
                  DB  1,-3
                  DB  1,-2
                  DB  1,-1
                  DB  1,0
                  DB  1,1
                  DB  1,2
                  DB  1,3
                  DB  1,3
                  DB  1,4
                  DB  0,4
                  DB  1,4
                  DB  0,4
                  DB  0,4
                  DB  1,4
                  DB  0,4
                  DB  0,4
                  DB  0,4
                  DB  1,4
                  DB  0,4
                  DB  0,4
                  DB  0,4
                  DB  0,4
                  DB  1,4
                  DB  255

offset_rana_ARR
                  DB  96,88,80,72,64,56,48,40,32,24,16, 0, 0, 0, 0, 0, 0, 0,16,24,32,40,48,56,64,72,80,88,96
offset_rana_ARR1
                  DB  -8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-8,-4,-3,-1, 0, 0, 1, 3, 4, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
offset_rana_ATE   
                  DB  8,-1,-1, 0, 1, 1, 0, 0, 0, 0

TIPO_BOMBONA
        DB  _4x16,_00SPR OR _IZQ ,%11000010 or 1        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_BOMBONA,Update_Bombona
; TIPO_NULO
;         DB  _0x00,_00SPR OR _IZQ ,%11000000 or 4        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
;         DW  DSPR_PULPO_ARR,Update_Nulo
TIPO_PULPO_ABA_IZQ
        DB  _4x16,_05SPR OR _IZQ ,%10000000 or 0        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_PULPO_ABA,Update_Pulpo_Px_ABA
TIPO_ALMEJA_FACIL_DER
        DB  _4x16,_00SPR OR _DER ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
TIPO_ALMEJA_FACIL_IZQ
        DB  _4x16,_00SPR OR _IZQ ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
TIPO_ALMEJA_FACIL_ARR
        DB  _4x16,_00SPR OR _ARR ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
; TIPO_ALMEJA_FACIL_ABA
;         DB  _4x16,_00SPR OR _ABA ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
;         DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
TIPO_ALMEJA_DIFICIL_DER
        DB  _4x16,_00SPR OR _DER ,%11010000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
TIPO_ALMEJA_DIFICIL_IZQ
        DB  _4x16,_00SPR OR _IZQ ,%11010000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
TIPO_ALMEJA_DIFICIL_ARR
        DB  _4x16,_00SPR OR _ARR ,%11010000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_ALMEJA_CERRADA,Update_Almeja_Ini_Px
TIPO_RANA_CORREDORA
        DB  _4x08,_03SPR OR _DER ,%11010000 or 1        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_RANA_CORRER,Update_RanaC_Ini_Px
TIPO_RANA_CORREDORA_IZQ
        DB  _4x08,_03SPR OR _IZQ ,%11010000 or 1        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_RANA_CORRER,Update_RanaC_Ini_Px
TIPO_RANA_SALTADORA
        DB  _4x08,_03SPR OR _ABA ,%11010000 or 1        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_RANA_STANDBY,Update_RanaS_Ini_Px
TIPO_BABOSA
        DB  _4x08,_03SPR OR _DER ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_BABOSA,Update_RanaC_Ini_Px
TIPO_BABOSA_IZQ
        DB  _4x08,_03SPR OR _IZQ ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_BABOSA,Update_RanaC_Ini_Px
TIPO_TORRETA
        DB  _4x16,_00SPR OR _DER ,%11100000 or 5        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_TORRETA,Update_Torreta_Ini_Px
TIPO_TORRETA_I
        DB  _4x16,_00SPR OR _DER ,%11110000 or 1        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_TORRETA,Update_Torreta_Ini_Px
TIPO_DISPARADOR_DER
        DB  _4x08,_07SPR OR _DER ,%01100000 or 4        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_DISPARADOR,Update_Disparador_Ini_Px
TIPO_DISPARADOR_IZQ
        DB  _4x08,_07SPR OR _IZQ ,%01100000 or 4        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_DISPARADOR,Update_Disparador_Ini_Px
TIPO_PLANTA
        DB  _4x16,_03SPR OR _DER ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_PLANTA,Update_Planta_Ini_Px
TIPO_BOSS
        DB  _4x16,_00SPR OR _DER ,%11100000 or 3        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_PLANTA,Update_Boss
;a continuación se definen los SuperTiles
;TILESET
;ANCHO,ALTO
;Tiles ANCHO*ALTO
; dstile_0
;         ;DB  JUEGO_TILES_1
;         ;DB      2,2
;         DB  %0010
;         DB  %0010
;         DB  TILE_FONDO,TILE_FONDO
;         DB  TILE_FONDO,TILE_FONDO

stiles_inicio
read "vs 1\pantallas\stiles-new1.asm"
dstile_hud_izq
db %10010101
db 1,2
db 6,0
db 7,0
db 8,0
db 9,2
dstile_hud_relleno
db %10010101
db 3,3
db 0,0
db 0,0
db 0,0
db 3,3
dstile_hud_centro
db %10010101
db 4,2
db 6,0
db 7,0
db 8,0
db 10,2
dstile_hud_derecha
db %10010101
db 3,5
db 0,6
db 0,7
db 0,8
db 3,11
dstile_estrella
db %10010010
db 92,93
db 94,95
dstile_boss
db %11010110
db 0,177,178,179,180,0
db 181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204
db 0,205,206,207,208,0
dSTILE_texto18
db %00000111

stiles_fin
;
;Aquí empieza la DATA DIVISION propia del motor
;
TECLADO0    DB  0
;TECLADO1    DB  0

PANTALLA_ACTUAL         DB      0
;DUREZAS_PANTALLA_ACTUAL DS      128

;LOADER
;incbin "cargador/tablas-1.bin"

;define un mapa de pantallas
;en cada word tenemos la dirección de los datos de la pantalla
MAPA_PANTALLAS    DS  NUMERO_PANTALLAS*2
;MAPA_PANTALLAS  EQU #2772
;define un mapa de SuperTiles
;en cada word tenemos la dirección de los datos del SuperTile
MAPA_STILES   DS NUMERO_STILES*2
;MAPA_STILES EQU #27E2
;tabla con los objetos cogidos o no
TABLA_OBJETOS     DS  NUMERO_OBJETOS

;definir arrays de mapa de durezas de 2 bits
;32x16x2bits=
MAPA_DUREZAS            DS ANCHO_MAPA_TILES*ALTO_MAPA_TILES/DIVBITS_DUREZAS

; sm_retorno_ccs  db 0
Buffer_actual   DW      BUFFER
; Buffer_Mayor    DW      BUFFER
Stack_Anterior  DW      0

; Buffer_Scroll   DM      40,40,40,40,40,40,40,40
;                 DM      40,40,40,40,40,40,40,40
;                 DM      40,40,40,40,40,40,40,40
;                 DM      40,40,40,40,40,40,40,40
;                 DB      255

SONIDOS
  DB 36,%01000000 OR 1  ;disparo prota
  DB 35,%00000000 OR 2  ;salto
  DB 26,%00000000 OR 2  ;aterrizaje
  DB 33,%01000000 OR 3  ;exp pequeña
  DB 50,%01000000 OR 3  ;exp grande
  DB 53,%01000000 OR 4  ;disp artefacto
  DB 41,%01000000 OR 5  ;disp bologico
  DB 69,%01000000 OR 6  ;impacto con artefacto cerrado
  DB 64,%01000000 OR 6  ;impacto con artefacto abierto
  DB 29,%01000000 OR 5  ;impacto con biologico
  db 33,%01000000 OR 4  ;impacto disparo con prota
  db 45,%00000000 OR 2  ;impacto enemigo con prota
  db 36,%01000000 OR 7  ;abre puerta
  db 64,%10000000 OR 8  ;coger objeto
  db 64,%10000000 OR 9  ;usar objeto
  db 72,%00000000 OR 10 ;menu-esc
  db 65,%00000000 OR 10 ;menu-opcion
  db 55,%00000000 OR 11 ;texto
  db 64,%00000000 OR 12 ;press fire
  db 41,%01000000 OR 1  ;disparo prota largo


TEXTO_CONTINUA  DM  "CONTINUE",255  ;8
TEXTO_SALIR     DM  "EXIT",255      ;5
TEXTO_COPYR       DM "COPYRIGHT 2018",255
TEXTO_CODE        DM "PROGRAM",255
TEXTO_MUSICA      DM "SOUND",255
TEXTO_JGNAVARRO   DM "JGNAVARRO",255
TEXTO_AZICUETAN   DM "AZICUETANO",255
TEXTO_MCKLAIN     DM "MCKLAIN",255
TEXTO_TESTING     DM "TESTING",255;TU-MISMO & ALGUIEN-MAS",255
TEXTO_TESTING1    DM "BLACKMORES JGONZA METR81 POMEZ666",255;TU-MISMO & ALGUIEN-MAS",255

INPUT11         DB  64
INPUT12         DW  TEXTO_CONTINUA
INPUT21         DB  0
INPUT22         DW  TEXTO_SALIR

; TEXTO_VERDE DM "VERDE",255
; TEXTO_MORA1 DM "MORADO 1",255
; TEXTO_MORA2 DM "MORADO 2",255
; TEXTO_ROJO1 DM "ROJO 1",255
; TEXTO_ROJO2 DM "ROJO 2",255

CHECK_ASIGNA_DUREZAS  DB 1
CHECK_PINTA_TILE      DB 1
TEMP_OBJETO           DW 0

; SONIDOS  DB %10000000 OR 40
;          DB %00000000 OR 56
;          DB %10000000 OR 60
;          DB %10000000 OR 24
;          DB %01000000 OR 60
;          DB %00000000 OR 62
;          DB %10000000 OR 62
;          DB %10000000 OR 60


; STATIC4
;         STATIC4_ID      DB      0       ;ID del objeto
;         STATIC4_TIPO    DB      0       ;Tipo del static Puerta, objeto o llave
;         STATIC4_X       DB      0       ;X
;         STATIC4_Y       DB      0       ;Y
;         STATIC4_STILE   DW      0       ;STile a pintar
;         STATIC4_CONS    DW      0       ;código para inicialización del objeto
;         STATIC4_TRIGGER DW      0       ;código que se ejecuta en caso de contacto
;         STATIC4_TAG     DB      0       ;para usar a discrección
DISPARO0
        DISPARO0_ID         DB  0
        DISPARO0_ANCHO      DB  2       ;ancho en bytes
        DISPARO0_ALTO       DB  6       ;alto en bytes
        DISPARO0_X          DB  0
        DISPARO0_ANTX       DB  0
        DISPARO0_Y          DB  0
        DISPARO0_ANTY       DB  0
        DISPARO0_DIRECCION  DW  BALA            ;rutina de la bala en salida
        DISPARO0_VEL_X      DB  1
        DISPARO0_VEL_Y      DB  1
        DISPARO0_MOVIMIENTO DW  control_disparo
        DISPARO0_ESTADO     DB  0
        DISPARO0_BUFFER     DS  14
        DISPARO0_LONG       DB  0
DISPARO1
        DISPARO1_ID         DB  0
        DISPARO1_ANCHO      DB  2       ;ancho en bytes
        DISPARO1_ALTO       DB  6       ;alto en bytes
        DISPARO1_X          DB  0
        DISPARO1_ANTX       DB  0
        DISPARO1_Y          DB  0
        DISPARO1_ANTY       DB  0
        DISPARO1_DIRECCION  DW  BALA            ;rutina de la bala en salida
        DISPARO1_VEL_X      DB  1
        DISPARO1_VEL_Y      DB  1
        DISPARO1_MOVIMIENTO DW control_disparo
        DISPARO1_ESTADO     DB  0
        DISPARO1_BUFFER     DS  14
        DISPARO1_LONG       DB  0
DISPARO2
        DISPARO2_ID         DB  0
        DISPARO2_ANCHO      DB  2       ;ancho en bytes
        DISPARO2_ALTO       DB  6       ;alto en bytes
        DISPARO2_X          DB  0
        DISPARO2_ANTX       DB  0
        DISPARO2_Y          DB  0
        DISPARO2_ANTY       DB  0
        DISPARO2_DIRECCION  DW  BALA    ;rutina de la bala para los dibujos precompilados
        DISPARO2_VEL_X      DB  1
        DISPARO2_VEL_Y      DB  1
        DISPARO2_MOVIMIENTO DW control_disparo_malo
        DISPARO2_ESTADO     DB  0
        DISPARO2_BUFFER     DS  14
        DISPARO2_dX         DW  0
        DISPARO2_dY         DW  0
        DISPARO2_signos     DB  1
DISPARO3
        DISPARO3_ID         DB  0
        DISPARO3_ANCHO      DB  2       ;ancho en bytes
        DISPARO3_ALTO       DB  6       ;alto en bytes
        DISPARO3_X          DB  0
        DISPARO3_ANTX       DB  0
        DISPARO3_Y          DB  0
        DISPARO3_ANTY       DB  0
        DISPARO3_DIRECCION  DW  BALA    ;rutina de la bala para los dibujos precompilados
        DISPARO3_VEL_X      DB  1
        DISPARO3_VEL_Y      DB  1
        DISPARO3_MOVIMIENTO DW control_disparo_malo
        DISPARO3_ESTADO     DB  0
        DISPARO3_BUFFER     DS  14
        DISPARO3_dX         DW  0
        DISPARO3_dY         DW  0
        DISPARO3_signos     DB  1
DISPARO4
        DISPARO4_ID         DB  0
        DISPARO4_ANCHO      DB  2       ;ancho en bytes
        DISPARO4_ALTO       DB  6       ;alto en bytes
        DISPARO4_X          DB  0
        DISPARO4_ANTX       DB  0
        DISPARO4_Y          DB  0
        DISPARO4_ANTY       DB  0
        DISPARO4_DIRECCION  DW  BALA    ;rutina de la bala para los dibujos precompilados
        DISPARO4_VEL_X      DB  1
        DISPARO4_VEL_Y      DB  1
        DISPARO4_MOVIMIENTO DW control_disparo_malo
        DISPARO4_ESTADO     DB  0
        DISPARO4_BUFFER     DS  14
        DISPARO4_dX         DW  0
        DISPARO4_dY         DW  0
        DISPARO4_signos     DB  1
; DISPARO5
;         DISPARO5_ID         DB  0
;         DISPARO5_ANCHO      DB  2       ;ancho en bytes
;         DISPARO5_ALTO       DB  6       ;alto en bytes
;         DISPARO5_X          DB  0
;         DISPARO5_ANTX       DB  0
;         DISPARO5_Y          DB  0
;         DISPARO5_ANTY       DB  0
;         DISPARO5_DIRECCION  DW  BALA    ;rutina de la bala para los dibujos precompilados
;         DISPARO5_VEL_X      DB  1
;         DISPARO5_VEL_Y      DB  1
;         DISPARO5_MOVIMIENTO DW 0
;         DISPARO5_ESTADO     DB  0
;         DISPARO5_BUFFER     DS  14
;         DISPARO5_dX         DW  0
;         DISPARO5_dY         DW  0
;         DISPARO5_signos     DB  1

;definición de los sprites del juego
SPRITE_BCK
                        DS      30
SPRITE0
        SPRITE0_ID      DB      0       ;identificador del sprite
        SPRITE0_ANCHO   DB      0       ;ancho en bytes
        SPRITE0_ALTO    DB      0       ;alto en bytes
        SPRITE0_X       DB      0       ;X
        SPRITE0_ANTX    DB      0       ;X para buffer
        SPRITE0_Y       DB      0       ;Y
        SPRITE0_ANTY    DB      0       ;Y para buffer
        SPRITE0_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE0_SPR     DB      0       ;número de sprites
        SPRITE0_SPR_A   DB      0       ;sprite actual
        SPRITE0_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE0_BUFF    DW      0       ;puntero al buffer
        SPRITE0_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE0_PATH    DW      0       ;puntero al camino activo
        SPRITE0_CHECKS  DB      0       ;checks del sprite
        SPRITE0_ESTADOS DB      0       ;estados para el movimiento
;         SPRITE0_COLLY   DB      0       ;cuando se agacha, añado 8 al COLLY
                        DS      3       ;relleno
        SPRITE0_TAG     DW      0       ;usos varios
        SPRITE0_VIDAS   DB      10      ;vidas (objeto de pokes ;-)
;         SPRITE0_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE0_DIRPANA DW      0       ;direccion de video anterior X,Y
SPRITE1
        SPRITE1_ID      DB      0       ;identificador del sprite
        SPRITE1_ANCHO   DB      0       ;ancho en bytes
        SPRITE1_ALTO    DB      0       ;alto en bytes
        SPRITE1_X       DB      0       ;X
        SPRITE1_ANTX    DB      0       ;X para buffer
        SPRITE1_Y       DB      0       ;Y
        SPRITE1_ANTY    DB      0       ;Y para buffer
        SPRITE1_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE1_SPR     DB      0       ;número de sprites
        SPRITE1_SPR_A   DB      0       ;sprite actual
        SPRITE1_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE1_BUFF    DW      0       ;puntero al buffer
        SPRITE1_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE1_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE1_DESP    DB      0       ;temporal para desplazamiento
        SPRITE1_CHECKS  DB      0       ;checks de los malos
        SPRITE1_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE1_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE1_CAD     DB      0       ;temporal cadencia de ICAD
        SPRITE1_DISP    DB      0       ;tiempo para disparar
        SPRITE1_TAG     DW      0       ;usos varios
        SPRITE1_VIDA    DB      0       ;tiempo para morir
;         SPRITE1_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE1_DIRPANA DW      0       ;direccion de video anterior X,Y
SPRITE2
        SPRITE2_ID      DB      0       ;identificador del sprite
        SPRITE2_ANCHO   DB      0       ;ancho en bytes
        SPRITE2_ALTO    DB      0       ;alto en bytes
        SPRITE2_X       DB      0       ;X
        SPRITE2_ANTX    DB      0       ;X para buffer
        SPRITE2_Y       DB      0       ;Y
        SPRITE2_ANTY    DB      0       ;Y para buffer
        SPRITE2_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE2_SPR     DB      0       ;número de sprites
        SPRITE2_SPR_A   DB      0       ;sprite actual
        SPRITE2_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE2_BUFF    DW      0       ;puntero al buffer
        SPRITE2_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE2_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE2_DESP    DB      0       ;temporal para desplazamiento
        SPRITE2_CHECKS  DB      0       ;checks de los malos
        SPRITE2_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE2_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE2_CAD     DB      0       ;temporal cadencia de ICAD
        SPRITE2_DISP    DB      0       ;tiempo para disparar
        SPRITE2_TAG     DW      0       ;usos varios
        SPRITE2_VIDA    DB      0       ;tiempo para morir
;         SPRITE2_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE2_DIRPANA DW      0       ;direccion de video anterior X,Y
SPRITE3
        SPRITE3_ID      DB      0       ;identificador del sprite
        SPRITE3_ANCHO   DB      0       ;ancho en bytes
        SPRITE3_ALTO    DB      0       ;alto en bytes
        SPRITE3_X       DB      0       ;X
        SPRITE3_ANTX    DB      0       ;X para buffer
        SPRITE3_Y       DB      0       ;Y
        SPRITE3_ANTY    DB      0       ;Y para buffer
        SPRITE3_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE3_SPR     DB      0       ;número de sprites
        SPRITE3_SPR_A   DB      0       ;sprite actual
        SPRITE3_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE3_BUFF    DW      0       ;puntero al buffer
        SPRITE3_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE3_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE3_DESP    DB      0       ;temporal para desplazamiento
        SPRITE3_CHECKS  DB      0       ;checks de los malos
        SPRITE3_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE3_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE3_CAD     DB      0       ;temporal cadencia de ICAD
        SPRITE3_DISP    DB      0       ;tiempo para disparar
        SPRITE3_TAG     DW      0       ;usos varios
        SPRITE3_VIDA    DB      0       ;tiempo para morir
;         SPRITE3_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE3_DIRPANA DW      0       ;direccion de video anterior X,Y
SPRITE4
        SPRITE4_ID      DB      0       ;identificador del sprite
        SPRITE4_ANCHO   DB      0       ;ancho en bytes
        SPRITE4_ALTO    DB      0       ;alto en bytes
        SPRITE4_X       DB      0       ;X
        SPRITE4_ANTX    DB      0       ;X para buffer
        SPRITE4_Y       DB      0       ;Y
        SPRITE4_ANTY    DB      0       ;Y para buffer
        SPRITE4_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE4_SPR     DB      0       ;número de sprites
        SPRITE4_SPR_A   DB      0       ;sprite actual
        SPRITE4_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE4_BUFF    DW      0       ;puntero al buffer
        SPRITE4_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE4_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE4_DESP    DB      0       ;temporal para desplazamiento
        SPRITE4_CHECKS  DB      0       ;checks de los malos
        SPRITE4_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE4_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE4_CAD     DB      0       ;temporal cadencia de ICAD
        SPRITE4_DISP    DB      0       ;tiempo para disparar
        SPRITE4_TAG     DW      0       ;usos varios
        SPRITE4_VIDA    DB      0       ;tiempo para morir
;         SPRITE4_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE4_DIRPANA DW      0       ;direccion de video anterior X,Y
SPRITE5
        SPRITE5_ID      DB      0       ;identificador del sprite
        SPRITE5_ANCHO   DB      0       ;ancho en bytes
        SPRITE5_ALTO    DB      0       ;alto en bytes
        SPRITE5_X       DB      0       ;X
        SPRITE5_ANTX    DB      0       ;X para buffer
        SPRITE5_Y       DB      0       ;Y
        SPRITE5_ANTY    DB      0       ;Y para buffer
        SPRITE5_DSPR    DW      0       ;Dirección del puntero de sprite
        SPRITE5_SPR     DB      0       ;número de sprites
        SPRITE5_SPR_A   DB      0       ;sprite actual
        SPRITE5_UPD     DW      0       ;puntero a rutina UPDATE
        SPRITE5_BUFF    DW      0       ;puntero al buffer
        SPRITE5_MIRADA  DB      0       ;hacia donde mira el sprite
        SPRITE5_IDESP   DB      0       ;desplazamiento total (x o y)
        SPRITE5_DESP    DB      0       ;temporal para desplazamiento
        SPRITE5_CHECKS  DB      0       ;checks de los malos
        SPRITE5_ADESP   DB      0       ;temporal para anterior desplazamiento
        SPRITE5_ICAD    DB      0       ;se mueve siempre o cada X frames
        SPRITE5_CAD     DB      0       ;temporal cadencia de ICAD
        SPRITE5_DISP    DB      0       ;tiempo para disparar
        SPRITE5_TAG     DW      0       ;usos varios
        SPRITE5_VIDA    DB      0       ;tiempo para morir
;         SPRITE5_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE5_DIRPANA DW      0       ;direccion de video anterior X,Y
; SPRITE6
;         SPRITE6_ID      DB      0       ;identificador del sprite
;         SPRITE6_ANCHO   DB      0       ;ancho en bytes
;         SPRITE6_ALTO    DB      0       ;alto en bytes
;         SPRITE6_X       DB      0       ;X
;         SPRITE6_ANTX    DB      0       ;X para buffer
;         SPRITE6_Y       DB      0       ;Y
;         SPRITE6_ANTY    DB      0       ;Y para buffer
;         SPRITE6_DSPR    DW      0       ;Dirección del puntero de sprite
;         SPRITE6_SPR     DB      0       ;número de sprites
;         SPRITE6_SPR_A   DB      0       ;sprite actual
;         SPRITE6_UPD     DW      0       ;puntero a rutina UPDATE
;         SPRITE6_BUFF    DW      0       ;puntero al buffer
;         SPRITE6_MIRADA  DB      0       ;hacia donde mira el sprite
;         SPRITE6_IDESP   DB      0       ;desplazamiento total (x o y)
;         SPRITE6_DESP    DB      0       ;temporal para desplazamiento
;         SPRITE6_CHECKS  DB      0       ;checks de los malos
;         SPRITE6_ADESP   DB      0       ;temporal para anterior desplazamiento
;         SPRITE6_ICAD    DB      0       ;se mueve siempre o cada X frames
;         SPRITE6_CAD     DB      0       ;temporal cadencia de ICAD
;         SPRITE6_DISP    DB      0       ;tiempo para disparar
;         SPRITE6_TAG     DW      0       ;usos varios
;         SPRITE6_VIDA    DB      0       ;tiempo para morir
;         SPRITE6_DIRPAN  DW      0       ;direccion de video X,Y
;         SPRITE6_DIRPANA DW      0       ;direccion de video anterior X,Y
;tabla de rutinas a llamar desde interrupciones

SEMAFORO_SPR_INT        DB      #FE     ;no procesa nada en INT
SEMAFORO_SPR_INT_PROTA  DB      0       ;para la dificultad del prota
SEMAFORO_IA_PROTA       DB      0
SEMAFORO_IA_DISPAROS0   DB      0
; SEMAFORO_IA_DISPAROS1   DB      0
SEMAFORO_PARPADEO       DB      0
SEMAFORO_PAUSA          DB      0
; DIFICULTAD              DB      2       ;dificultad inicial
TEXTO_ANIMADO           DB      0
EFECTO_TINTAS           DB      0
EFECTO_FLASH            DB      0
;TRUCO_NO_MUERES         DB      1       ;truco sin muerte
;SEMAFORO_CALC_EVARISTO  DB      0
; newx                    DB      0
; newy                    DB      0

CHECK_OBJETO            DB      0       ;activa bandera de toque de objeto
CHECK_BOMBONA           DB      0
fin_juego               DB      0
;CHECK_PUZZLE1           DB      0       ;si es uno, se activan las piedras
; CHECK_MARCADOR0         DW      0
; CHECK_MARCADOR1         DW      0

siguiente_parpadeo      DW      0

Sig_Interrupcion        DB      0

Tabla_INT
SPRITE0_INT             DB      0
SPRITE1_INT             DB      0
SPRITE2_INT             DB      0
SPRITE3_INT             DB      0
SPRITE4_INT             DB      0
SPRITE5_INT             DB      0
SPRITE6_INT             DB      0
Tabla_DISP
DISPARO0_INT            DB      0
DISPARO1_INT            DB      0
DISPARO2_INT            DB      0
DISPARO3_INT            DB      0
DISPARO4_INT            DB      0
;DISPARO5_INT            DB      0

Tabla_BCK               DS      13

TEXTO_1                 DM "IT LOOKS LIKE AN OLD ABANDONED",0   
                        DM "NAZI BASE, AND WHATEVER HAPPENS",0
                        DM "HERE DOES NOT SEEM NICE.",255
TEXTO_2                 DM "THIS SECURITY DOOR WORKS BY",0
                        DM "ELECTRONIC OPENING, BUT IT SEEMS",0
                        DM "THE BASE IS RUNNING OUT OF POWER.",255
TEXTO_3                 DM "THIS ENGINE HAS A BROKEN VALVE.",0   
                        DM "MAYBE IN THE COMMUNICATIONS ROOM",0  
                        DM "I CAN FIND A SPARE.",255
TEXTO_4                 DM "I'M NOT SURE HOW TO OPEN THIS",0
                        DM "DOOR. MAYBE IF I COULD DESTROY",0
                        DM "THE OPENING ENGINE.",255

TEXTO_7                 DM "THIS IS THE END, BUT I LEAVE THIS",0
                        DM "WORLD WITH THE SATISFACTION OF",0
                        DM "HAVING SENT ALL THIS TO THE HELL.",255