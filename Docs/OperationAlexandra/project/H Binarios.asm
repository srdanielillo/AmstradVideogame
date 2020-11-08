write direct -1,-1,#c0
;se carga el TILESET 1
ORG	DIRECCION_TILES_1
INCBIN	"vs 1/tileset0.bin";tiles/tiles-abu-z1.bmp.bin"
;se carga el TILESET 2
ORG	DIRECCION_TILES_2
INCBIN	"vs 1/tileset1.bin"

org &5920
PANTALLA_07
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,%01100000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla07.asm"
 	DB 88+72-48,4,21,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 80,50,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
	DB #a0,32,20,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_IZQ	;SuperSprite
	DB #a0+16,32,20,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA_IZQ	;SuperSprite
  	DB 80-32,34,0,0			;(3)y,x,desp,velocidad
  	DW TIPO_BOMBONA
	;  fin enemigos
	DB 255
	DB 8,STA_PUERTA,20,7		;puerta pantalla 21
	DW dsTile_Puerta,Objeto_Puerta_Cons,Objeto_Nulo_Trigger
	DB 2 	;ancho de la puerta
	DB 16,STA_LLAVE,23,10		;botonera
	DW dSTILE_botonera,Objeto_Coger_Cons,Objeto_Texto_Trigger
	DB 16 	;tag
	DB 17,STA_TEXTO,100,100
	DW dSTILE_52,Objeto_Texto_Cons,Objeto_Puerta_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_11
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00000001,%01101000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla11.asm"
 	DB 88,12,28,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 72-16,12,16,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 88+40,6,44,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_23
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,%10000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla23.asm"
 	DB 184,58,88,88
 	DW TIPO_RANA_SALTADORA
	DB 48,12,30,1		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_DIFICIL_DER	;SuperSprite
	DB #48+16+16+8,#1a,56+8,0		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_DIFICIL_ARR	;SuperSprite
	DB 48+16+12,12,30,1		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite

	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

DIRECCION_T_MASCARAS	EQU	#6000
TABLA_MASCARASH		EQU	#60
ORG	DIRECCION_T_MASCARAS
TABLA_MASCARAS

DIRECCION_T_MASCARAS_R	EQU	#6100
TABLA_MASCARASH_R	EQU	#61
ORG	DIRECCION_T_MASCARAS_R
TABLA_ROTACIONES

ORG   &6200
;**********************
;Free 3840 bytes (&900)
;**********************
PANTALLA_00
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	DB 0,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla00.asm"
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_01
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00000001,%00000110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla01.asm"
 	DB 88+72-48,24,20,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 184,48,20,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 184-24-16,40,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255
PANTALLA_02
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla02.asm"
 	DB 184,44,20,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 184,12,18,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 184-8,44-11,8,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255
PANTALLA_03
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla03.asm"
 	DB 184,18,24,24
 	DW TIPO_RANA_SALTADORA
 	DB 184,58,24,24
 	DW TIPO_RANA_SALTADORA
 	DB 184,22,32,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA		;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255
PANTALLA_04
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010000,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla04.asm"
 	DB 184-48-16,44,20,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 184-56-16,10,22,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
	DB #a0,34,14,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_IZQ	;SuperSprite
	DB #a0+16,34,14,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA_IZQ	;SuperSprite
 	DB 184-32,20,12,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
	;  fin enemigos
	DB 255
	DB 11,STA_OBJETO,34,18		;valvula
	DW dSTILE_ValvulaB,Objeto_Coger_Cons,Objeto_Coger_Trigger
	DB 1 	;
	;  fin objetos
	DB 255
PANTALLA_05
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00000001,%00000110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla05.asm"
 	DB 184,56,56,56
 	DW TIPO_RANA_SALTADORA
 	DB 88+24,6,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_DIFICIL_IZQ	;SuperSprite
 	DB 88+24,44,56,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_DIFICIL_ARR	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_06
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla06.asm"
 	DB 88+72-8,38-16-6,32+6,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_DIFICIL_IZQ	;SuperSprite
 	DB 88+72+16,48-8,28,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_DIFICIL_DER	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_08
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla08.asm"
 	DB 48,8,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 184,18,64,64
 	DW TIPO_RANA_SALTADORA
 	DB 88+80-48,49,21,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 88,49,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
	;  fin enemigos
	DB 255
	DB 9,STA_OBJETO,23,20		;botiquin
	DW dsTile_Botiquin,Objeto_Coger_Cons,Objeto_Vida_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_09
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla09.asm"
 	DB 48,12,26,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 88+80-48,54,16,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 88+32,10,56,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_ARR	;SuperSprite
 	DB 48,50,48,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_ARR	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_10
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010000,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla10.asm"
 	DB 184,48,96,96
 	DW TIPO_RANA_SALTADORA
 	DB 96,6,14,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA		;SuperSprite
 	DB 184,52,12,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
 	DB 48,71,0,50		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 184-32,6,12,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
	;  fin enemigos
	DB 255
	DB 10,STA_OBJETO,34,10		;botiquin
	DW dSTILE_97,Objeto_Coger_Cons,Objeto_CogerPV_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_12
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla12.asm"
 	DB 184,28,80,80
 	DW TIPO_RANA_SALTADORA
 	DB 88,34,33,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
 	DB 72-16,10,36,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 88+24,42,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_13
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla13.asm"
 	DB 72+24,29,0,75			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 72+24,42,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 184-8,24,12,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
 	DB 72+24,54,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 184-32,42,0,25			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_14
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla14.asm"
 	DB 72+24,20,0,75			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 72+24,32,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 72,42,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 136,10,36,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_15
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,%00001000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla15.asm"
 	DB 72+24,#18+10,0,75			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 56,36,36,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 184,#25,40,40
 	DW TIPO_RANA_SALTADORA
 	DB 128,8,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_16
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla16.asm"
 	DB 184-16,44,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
 	DB 72,44,22,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 184-16-24,40,28,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 72+40,46,24,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite

	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_17
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010000,%00001000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla17.asm"
 	DB 184,6,24,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA		;SuperSprite
 	DB 184,36,24,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_18
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00000001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla18.asm"
; 	DB 72,#10,20,1		;(1)y,x,desp,velocidad
; 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
; 	DB 72+16,#10+2,20,1		;(1)y,x,desp,velocidad
; 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
; 	DB 72+32,#10+4,20,1		;(1)y,x,desp,velocidad
; 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
; 	DB 72+32+16,#10+6,20,1		;(1)y,x,desp,velocidad
; 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
; 	DB 72-16,#10+8,20,1		;(1)y,x,desp,velocidad
; 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
;  	DB 72+88,#10+8,0,75			;(3)y,x,desp,velocidad
;  	DW TIPO_PLANTA
;  	DB 72+32,#10,0,75			;(3)y,x,desp,velocidad
;  	DW TIPO_PLANTA
;  	DB 160+16+8,48,28,1		;(1)y,x,desp,velocidad
;  	DW TIPO_BABOSA			;SuperSprite
;  	DB 72+32,#10+#10,0,75			;(3)y,x,desp,velocidad
;  	DW TIPO_PLANTA
;  	DB 72+96+8,#10+#10+8+16,0,75			;(3)y,x,desp,velocidad
;  	DW TIPO_PLANTA
;  	DB 72+32,#10+#10+8+8,0,75			;(3)y,x,desp,velocidad
;  	DW TIPO_PLANTA
;  	DB 72+32,#10+#10+8+8+8,0,75			;(3)y,x,desp,velocidad
;  	DW TIPO_PLANTA
;  	DB 72+32,#18,24,1			;(1)y,x,desp,velocidad
;  	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
;  	DB 72,#18,20,2			;(2)y,x,desp,velocidad
;  	DW TIPO_PULPO_ARR		;SuperSprite
;   	DB 72,#3d+3,0,30*5
;  	DW TIPO_DISPARADOR_IZQ
;   	DB 72-8,#3d+3,0,30*5
;  	DW TIPO_DISPARADOR_IZQ
 	;DB 160,0,20,3			;(2)y,x,desp,velocidad
 	;DW TIPO_PULPO_ARR		;SuperSprite
;  	DB 72+32+16,#18,24,1		;(4)y,x,desp,velocidad
;  	DW TIPO_PULPO_ABA		;SuperSprite
;  	DB 72+16,#18,20,2		;(5)y,x,desp,velocida
;  	DW TIPO_PULPO_ABA		;SuperSprite
	;  fin enemigos
	DB 255
	DB 1,STA_TEXTO,22,16
	DW dSTILE_texto18,Objeto_Texto_Cons,Objeto_Texto_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_19
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 18,20,11,#FF
	DB %00010001,%10000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla19.asm"
 	DB 160+16+8,22,16,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
 	DB 96,#18+30,14,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
	;  fin enemigos
	DB 255
	;OJO
	DB 4,STA_OBJETO,4,11		;botiquin
	DW dsTile_Botiquin,Objeto_Coger_Cons,Objeto_Vida_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_20
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 19,21,#FF,28
	DB %00010001,%00001000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla20.asm"
 	DB 160+16+8,48,28,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 96,12,16,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
 	DB 152,38,8,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
	;  fin enemigos
	DB 255
	DB 3,STA_OBJETO,2,7
	DW dstile_lata,Objeto_Coger_Cons,Objeto_Coger_Trigger
	DB 1 	;objeto gasolina
	;  fin objetos
	DB 255

PANTALLA_21
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 20,22,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla21.asm"
 	DB 160+16+8,58,14,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 96,26,13,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 160+16+8,16,20,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ		;SuperSprite
 	DB 96-32,42,28,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
	;  fin enemigos
	DB 255
	DB 2,STA_LLAVE,33,22		;botonera
	DW dSTILE_botonera,Objeto_Texto_Cons,Objeto_Puerta_Trigger
	DB 6 	;tag
	DB 6,STA_PUERTA,38,19		;puerta pantalla 21
	DW dsTile_Puerta,Objeto_Puerta_Cons,Objeto_Nulo_Cons
	DB 2 	;ancho de la puerta
	;  fin objetos
	DB 255

PANTALLA_22
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla22.asm"
	DB #88-56,#c,60,1		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_DIFICIL_ARR	;SuperSprite
	DB 56,#3a-30,30,1		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
	DB #a0,#14,34,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+16,#14,34,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA_IZQ	;SuperSprite
	;  fin enemigos
	DB 255
	DB 7,STA_OBJETO,29,9		;botiquin
	DW dsTile_Botiquin,Objeto_Coger_Cons,Objeto_Vida_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_24
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,%00000110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla24.asm"
	DB 48+16+12+32,18,36,1		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 184-24-16-72,40,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_25
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010001,%10000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla25.asm"
 	DB 184-32,18,32,32
 	DW TIPO_RANA_SALTADORA
	DB 88,18,22,1		;(1)y,x,desp,velocidad
	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 48,28,0,50		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
	;  fin enemigos
	DB 255		;13
	DB 13,STA_PUERTA,22,19		
	DW dsTile_Puerta,Objeto_Puerta_Cons,Objeto_Nulo_Trigger
	DB 2 	;ancho de la puerta
	DB 12,STA_OBJETO,5,9		;
	DW dsTile_Botiquin,Objeto_Coger_Cons,Objeto_Vida_Trigger
	DB 1 	;tag
	DB 14,STA_LLAVE,26,11
	DW dSTILE_ValvulaR,Objeto_Coger_Cons,Objeto_Coger_Trigger
	DB 1 	;tag
	DB 15,STA_LLAVE,28,22		;botonera
	DW dSTILE_botonera,Objeto_Coger_Cons,Objeto_Puerta_Trigger
	DB 6 	;tag
	;  fin objetos ,Objeto_Texto_Cons,Objeto_Puerta_Trigger
	DB 255

PANTALLA_26
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,19,#FF,#FF
	DB %00010000,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla26.asm"
 	DB 160+16+8,0,38,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_izq			;SuperSprite
 	DB 128,8,24,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA			;SuperSprite
 	DB 128,36,18,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_27
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB #FF,28,#FF,#FF
	DB %00000001,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla27.asm"
 	DB 184,30,24,24
 	DW TIPO_RANA_SALTADORA
 	DB 96,#18+22,20,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_28
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 27,29,#FF,#FF
	DB %00010001,%10000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla28.asm"
 	DB 184,24,48,48
 	DW TIPO_RANA_SALTADORA
 	DB 96,0,19,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
 	DB 184,34,42,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA		;SuperSprite
	;  fin enemigos
	DB 255
	DB 5,STA_LLAVEINV,24,7		;
	DW dsTile_Botiquin,Objeto_Coger_Cons,Objeto_Coger_Trigger
	DB 1 	;tag
	;  fin objetos
	DB 255

PANTALLA_29
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,0
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla29.asm"
 	DB 160+16+8,0,46,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
 	DB 80,16,28,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
 	DB 120,16,34,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

fin_pantalla_29

ORG	DIRECCION_MUSICA
SNG_MENU	;7115
INCBIN  "musica/ER-Menu.bin"
SNG_INGAME	;7401
INCBIN  "musica/ER-ingame.bin"
SNG_FX
INCBIN  "musica/ER-FX.bin"

PANTALLA_46
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010001,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla46.asm"
	DB #a0+32-40,28,12,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+32-24,28,12,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA	;SuperSprite
 	DB 56,6,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_49
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,%01100000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla49.asm"
 	DB 48,16,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 48,68,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

FIN_PANTALLA_49

;SNG_FX		;76c0
;INCBIN  "musica/Pro2-FX.bin"
; org &5920
; SNG_BOSS
;INCBIN "musica/boss.bin"
org &7700
TABLA_SCANLINES_H EQU &77
;Tablas scanlines
TABLA_SCANLINES  DS  256*2

;a continuación se cargan los sprites
;donde acaben las pantallas empezarán
;**************************sprites derecha y no simetricos
INICIO_SPRITES_DER
FIN_SPRITE_DER
;**************************sprites izquierda y no simetricos
INICIO_SPRITES_IZQ
FIN_SPRITES_IZQ
;**************************sin rotación
INICIO_SPRITES_SIMETRICOS
	PROTA
	PROTA_ARR
	INCBIN "Alexandre/hero-sup-izq.bin"
	PROTA_ABA
	INCBIN "Alexandre/hero-inf-der.bin"
	PULPO_ARR
	INCBIN "Alexandre/pulpo-arr.bin"
	PULPO_ABA
	INCBIN "Alexandre/pulpo-aba.bin"
	ALMEJA
	INCBIN "Alexandre/almeja.bin"
	EXPLOSION
	INCBIN "Alexandre/explosion.bin"
	EXPLOSION8
	INCBIN "Alexandre/explosion8.bin"
	RANA
	INCBIN "Alexandre/rana.bin"
	BABOSA
	INCBIN "Alexandre/babosa.bin"
	TORRETA
	INCBIN "Alexandre/torreta.bin"
	DISPARADOR
	INCBIN "Alexandre/disparador.bin"
	PLANTA
	INCBIN "Alexandre/planta.bin"
	BALA
	INCBIN "Alexandre/balas.bin"
	BALA_DES	EQU	BALA+12
	;BALA_MEDIA	EQU	BALA_DES+36
	;BALA_GORDA	EQU	BALA_MEDIA+12
	BALA_ACIDO	EQU	BALA+36+12
	BALA_VARYLIO	EQU	BALA_ACIDO+12
	BALA_EXP	EQU	BALA_VARYLIO+12
	BOMBONA
	INCBIN "Alexandre/bombona.bin"
FIN_SPRITES_SIMETRICOS

;ORG	DIRECCION_PANTALLAS
;se cargan los datos de las pantallas

PANTALLA_30
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000000,%01100001
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla30.asm"
 	DB 100,32,56,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_ARR	;SuperSprite
 	DB 60+24,44,18,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
  	DB 72+56,#3d+7,0,30*2
 	DW TIPO_DISPARADOR_IZQ
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_31
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000000,%00010001
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla31.asm"
 	DB 48,66,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
  	DB 72+56+32,#3d+12,0,30*2
 	DW TIPO_DISPARADOR_IZQ
  	DB 72+56+40,4,0,30*3
 	DW TIPO_DISPARADOR_DER
  	DB 48+16,6,0,30*4
 	DW TIPO_DISPARADOR_DER
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_32
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000000,%00010011
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla32.asm"
 	DB 48+16,66-22,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
  	DB 72+56-32,#3d+7,0,30*2
 	DW TIPO_DISPARADOR_IZQ
  	DB 72+56+40-16,8,0,30*3
 	DW TIPO_DISPARADOR_DER
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_33
	DB %00000001,%0000110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla33.asm"
 	DB 56,26,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
  	DB 72+48,8,0,30*2
 	DW TIPO_DISPARADOR_DER
  	DB 72+56+56,26,0,30*3
 	DW TIPO_DISPARADOR_DER
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_34
	DB %00010001,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla34.asm"
	DB #a0,#28+4,20,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+16,#28+4,20,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA_IZQ	;SuperSprite
  	DB 72+56+40,72,0,30*3
 	DW TIPO_DISPARADOR_IZQ
 	DB 160+16+8,6,21,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_35
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,%00110000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla35.asm"
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_36
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000001,%00000110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla36.asm"
  	DB 96+24,70,0,45
 	DW TIPO_DISPARADOR_IZQ
  	DB 96+32+40,74,0,75
 	DW TIPO_DISPARADOR_IZQ
  	DB 80,0,0,45
 	DW TIPO_DISPARADOR_DER
  	DB 80+32,0,0,75
 	DW TIPO_DISPARADOR_DER
  	DB 80+32+48,0,0,45
 	DW TIPO_DISPARADOR_DER
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_37
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,%00000110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla37.asm"
 	DB 88+72-88,6,60,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_ARR	;SuperSprite
 	DB 88+72-48,36,20,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_DER	;SuperSprite
 	DB 64-16,46,20,1		;(5)y,x,desp,velocidad
 	DW TIPO_ALMEJA_FACIL_IZQ	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_38
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000001,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla38.asm"
 	DB 48+64,60,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 184-24-72,16,26,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
 	DB 184-24,12,96,96
 	DW TIPO_RANA_SALTADORA
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_39
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010001,%01100110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla39.asm"
 	DB 48,22,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 48,58,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 184,6,30,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_40
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla40.asm"
 	DB 50,44,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 184-16-72,16,20,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA_IZQ		;SuperSprite
	DB #a0,18,30,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+16,18,30,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_41
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000001,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla41.asm"
 	DB 56+32,6,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA_I			;SuperSprite
 	DB 56+16,20,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA_I			;SuperSprite
 	DB 56+16,56,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA_I			;SuperSprite
 	DB 56+32,70,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA_I			;SuperSprite
	;  fin enemigos
	DB 255
	DB 18,STA_TEXTO,22,16
	DW dSTILE_texto18,Objeto_Texto_Cons,Objeto_Texto_Trigger
	DB 18 	;tag
	;  fin objetos
	DB 255

PANTALLA_42
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,%01100000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla42.asm"
 	DB 56+32,0,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
 	DB 56+32,70,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
  	DB 80+32+48+24,70,0,75
 	DW TIPO_DISPARADOR_IZQ
  	DB 80+32+48+24,10,0,45
 	DW TIPO_DISPARADOR_DER
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_43
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000001,%01100110
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla43.asm"
 	DB 88,32,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 88,40,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 128+24,46,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 104,56,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 184,24,36,1		;(1)y,x,desp,velocidad
 	DW TIPO_RANA_CORREDORA		;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_44
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010000,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla44.asm"
 	DB 120,28,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 88,52,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
 	DB 128+16,60,0,50			;(3)y,x,desp,velocidad
 	DW TIPO_PLANTA
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_45
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000001,%01100000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla45.asm"
  	DB 72,52,0,30*3
 	DW TIPO_DISPARADOR_IZQ
  	DB 48,2,0,30*3
 	DW TIPO_DISPARADOR_DER
 	DB 160+16,48,21,1		;(1)y,x,desp,velocidad
 	DW TIPO_BABOSA_IZQ			;SuperSprite
	DB #a0-24,14,30,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+16-24,14,30,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA	;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_47
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010001,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla47.asm"
	DB #a0+32-40,30,18,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+32-24,30,18,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA	;SuperSprite
 	DB 56,28,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_48
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00010001,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla48.asm"
	DB #a0+32-40,16,18,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+32-24,16,18,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA	;SuperSprite
	DB #a0+32-40,38,20,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ARR_DISPARA	;SuperSprite
	DB #a0+32-24,38,20,1		;(1)y,x,desp,velocidad
	DW TIPO_PULPO_ABA	;SuperSprite
 	DB 48,68,0,40		;(1)y,x,desp,velocidad
 	DW TIPO_TORRETA			;SuperSprite
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

PANTALLA_50
	;  NAVEGACION
	;  IZQ,DER,ARR,ABA,PUERTA
	;DB 28,#FF,#FF,#FF
	DB %00000000,%00000000
			;  SuperTiles que componen la pantalla
			;  identificador del SuperTile
	; empiezan la zona repetitiva
	READ "vs 1\pantallas\pantalla50.asm"
	;  fin enemigos
	DB 255
	;  fin objetos
	DB 255

pantalla_50_fin


