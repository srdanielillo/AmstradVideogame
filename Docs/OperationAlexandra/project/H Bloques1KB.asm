org &C000

;incbin "loader.scr"

ORG	#C000+2000
inicio_spare0
	Barra_vida db  12,12,12,13,13,13,13,14,14,14

	Pantalla_Siguiente  DB  #ff

	Cadencia_Disparo  DB  0

	Invulnerable  DB 0

	Pulsa_Escape    DB  0

	Choq_MALOS            DB  0
	Choq_DISP             DB  0
	Choq_MALOS_desde_DISP DB 0

	HIGH_SCORE      DW  0
	SCORE           DW  0
	SCORE_A         DW  0

	TEXTO_HSCORE    DM  "HI-SCORE:",255
	TEXTO_SCORE     EQU TEXTO_HSCORE+3
	TEXTO_SALUD     DM  "HEALTH",255
	TEXTO_PAUSA     DM  "PAUSE",255	
	;sprites activos en una pantalla
	SPRITES_PANTALLA        DB      0
	Hay_Musica      DB  #ff
FIN_BLOQUE01

ORG	inicio_spare0+&800
inicio_spare1
	DSPR_PROTA_ANDAR        DW PROTA,PROTA,PROTA+72,PROTA+72,PROTA+144,PROTA+144,PROTA+72,PROTA+72
	DSPR_PROTA_REPOSO       DW PROTA+72
	DSPR_PROTA_CAYENDO
	DSPR_PROTA_SALTAR       DW PROTA+576
	DSPR_PROTA_AGACHAR
	DSPR_PROTA_ATERRIZA     DW PROTA+720
	DSPR_PROTA_DISPARO      DW PROTA+216,PROTA+216,PROTA+216,PROTA+216,PROTA+72,PROTA+72,PROTA+72,PROTA+72,PROTA+72,PROTA+72,PROTA+72,PROTA+72

	seed1  					dw 0
FIN_BLOQUE02

ORG	inicio_spare1+&800
inicio_spare2
	DSPR_PROTA_DISPARO_O    DW PROTA+360,PROTA+360,PROTA+360,PROTA+360,PROTA+288,PROTA+288,PROTA+288,PROTA+288,PROTA+288,PROTA+288,PROTA+288,PROTA+288
	DSPR_PROTA_DISPARO_V    DW PROTA+504,PROTA+504,PROTA+504,PROTA+504,PROTA+432,PROTA+432,PROTA+432,PROTA+432,PROTA+432,PROTA+432,PROTA+432,PROTA+432
FIN_BLOQUE03

ORG	inicio_spare2+&800
inicio_spare3
	DSPR_PROTA_DISPARO_A    DW PROTA+792,PROTA+792,PROTA+792,PROTA+792,PROTA+720,PROTA+720,PROTA+720,PROTA+720,PROTA+720,PROTA+720,PROTA+720,PROTA+720
	DSPR_PROTA_DISPARO_S    DW PROTA+648,PROTA+648,PROTA+648,PROTA+648,PROTA+576,PROTA+576,PROTA+576,PROTA+576,PROTA+576,PROTA+576,PROTA+576,PROTA+576
FIN_BLOQUE04

ORG	inicio_spare3+&800
inicio_spare4
	DSPR_EXPLOSION_MALO     DW EXPLOSION,EXPLOSION,EXPLOSION+64,EXPLOSION+128,EXPLOSION+192,EXPLOSION+192+64,EXPLOSION+192+128
	DSPR_EXPLOSION_MALO8    DW EXPLOSION8,EXPLOSION8,EXPLOSION8+32,EXPLOSION8+64,EXPLOSION8+96,EXPLOSION8+128,EXPLOSION8+160
	DSPR_DISPARO_EXP        DW BALA_EXP,BALA_EXP+36,BALA_EXP+24,BALA_EXP+12;,BALA_EXP   ;esta va al revés
	DSPR_BABOSA             DW BABOSA,BABOSA,BABOSA+32,BABOSA+32  ;4
	DSPR_BOMBONA            DW BOMBONA

	seed2  					dw 0
FIN_BLOQUE05

ORG	inicio_spare4+&800
inicio_spare5
	;definición de los caminos del sprite
PATH_SALTO_VERTICAL
                       ; U   D
                  DB   %10000000
                  DB   %10000000
                  DB   %01100000
                  DB   %01100000
                  DB   %01000000
                  DB   %01000000
                  DB   %00100000
                  DB   %00100000
                  DB   %00000000
                  DB   %00000000
                  DB   %00000000
PATH_CAIDA_VERTICAL
                  ;DB   %00000010
                  DB   %00000010
                  DB   %00000100
                  DB   %00000100
                  DB   %00000110
                  DB   %00000110
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %00001000
                  DB   %11111111
PATH_ATERRIZA
                  DB   %00000000
                  DB   %00000000
                  DB   %11111111
PATH_RESPINGO
                  DB   %01000000
                  DB   %00100000
                  DB   %00000000
                  DB   %11111111

DSPR_NULO         DW DSPR_NULO

FIN_BLOQUE06

ORG	inicio_spare5+&800
inicio_spare6
TINTAS_JUEGO
  DB  #54
  DB  #4f,#54,#44,#55,#5c,#5d,#56,#4c,#46,#5e,#40,#5f,#4e,#47,#4a,#4b
  ;DB  #56,#5c,#4c,#4e,#4a,#5e,#52,#58
  ;DB  #4d,#4f,#44,#57,#53,#4b,#40,#54
TINTAS_BLANCO
  DB      #4B
  DB      #4B,#4B,#4B,#4B,#4B,#4B,#4B,#4B
  DB      #4B,#4B,#4B,#4B,#4B,#4B,#4B,#4B

OFFSET_PANTALLA DB 0

DATOS_PANTALLA_ACTUAL   DS      4

TIPO_PULPO_ARR_DISPARA
        DB  _4x16,_05SPR OR _DER ,%11100000 or 4        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_PULPO_ARR,Update_Pulpo_Ini_Px

FIN_BLOQUE07

ORG	inicio_spare6+&800
inicio_spare7
TINTAS_JUEGO1
  DB      #54
  DB      #4d,#54,#44,#55,#5c,#5d,#56,#4c,#56,#46,#5e,#57,#4e,#4e,#59,#59

TINTAS_JUEGO2
  DB      #54
  DB      #4c,#54,#44,#55,#5c,#58,#5d,#58,#5c,#5d,#5d,#5d,#4c,#4c,#46,#46

TIPO_PULPO_ARR_IZQ
        DB  _4x16,_05SPR OR _IZQ ,%11000000 or 4        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_PULPO_ARR,Update_Pulpo_Ini_Px
; TIPO_PULPO_ARR_DER
;         DB  _4x16,_05SPR OR _DER ,%11000000 or 4        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
;         DW  DSPR_PULPO_ARR,Update_Pulpo_Ini_Px
TIPO_PULPO_ABA
        DB  _4x16,_05SPR OR _DER ,%10000000 or 0        ;#4,#10,6,DERECHA,CHECKS | IMPACTOS PARA MUERTE
        DW  DSPR_PULPO_ABA,Update_Pulpo_Px_ABA

FIN_BLOQUE08