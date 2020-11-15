;Parámetros propios del juego
;****************************
MODO_MARCADOR		EQU	0		;mode del marcador
ZONA_MARCADOR		EQU	%00010000	;&4000
DIRECCION_MARCADOR	EQU	#4000
MODO_JUEGO		EQU	0		;mode del juego
ZONA_JUEGO		EQU     %00110000	;&c000
DIRECCION_JUEGO		EQU	#C000

BYTE_FONDO_PANTALLA	EQU	#C0		;color para borrar fondo de pantallas

NUMERO_PANTALLAS	EQU	51		;número de pantallas del juego (se añade una pq empieza de 0)
NUMERO_STILES		EQU	228     ;número de SuperTiles
NUMERO_OBJETOS		EQU	20		;número de objetos del recorrido

NUMERO_DE_TINTAS	EQU	16		;16 tintas en mode 0

DIRECCION_TILES		EQU	#4000		;dirección de los TILES
JUEGO_TILES_1		EQU	4
DIRECCION_TILES_1	EQU	#4000		;dirección del juego 1 de TILES
JUEGO_TILES_2		EQU	5
DIRECCION_TILES_2	EQU	#5000		;dirección del juego 2 de TILES

DIRECCION_MUSICA	EQU	#6f26		;dirección de los mapas de pantallas
DIRECCION_PANTALLAS EQU #9000		;dirección de los mapas de pantallas

LONG_DISPARO		EQU 10		;longitud del disparo corto
LONG_DISPARO_OB		EQU 7		;longitud del disparo corto en oblicuo

;Pantalla significativas
PANTALLA_MENU		EQU	0
PANTALLA_INICIO		EQU	18
PANTALLA_INTRO		EQU 1
PANTALLA_BOSS		EQU 41
PANTALLA_FIN        EQU 50

;distancia estre el tile de energia primero y el de debajo
INC_BARRA  EQU 16

PUNTOS_BABOSA	EQU 1
PUNTOS_ALMEJA	EQU 4
PUNTOS_PULPO	EQU 5
PUNTOS_TORRETA	EQU 10
PUNTOS_PLANTA	EQU 3
PUNTOS_DISPARA	EQU 4
PUNTOS_BOSS		EQU 50

FX_disparo_prota 	EQU 0
FX_salto			EQU 1
FX_aterrizaje		EQU 2
FX_exp_pequena		EQU 3
FX_exp_grande		EQU 4
FX_disp_artefacto	EQU 5
FX_disp_biologico	EQU 6
FX_imp_art_cerrado  EQU 7
FX_imp_art_abierto  EQU 8
FX_imp_biologico	EQU 9
FX_imp_disp_prota   EQU 10
FX_imp_enem_prota	EQU 11
FX_abre_puerta		EQU 12
FX_coger_objeto		EQU 13
FX_usar_objeto		EQU 14
FX_menu_esc			EQU 15
FX_menu_opcion		EQU 16
FX_texto			EQU 17
FX_press_fire		EQU 18
FX_disparo_prota_l  EQU 19

;Dimensiones del mapa en tiles y en pixeles
ALTO_MAPA_TILES		EQU	20+5
ANCHO_MAPA_TILES	EQU	40
ALTO_MAPA_BYTES		EQU	ALTO_MAPA_TILES*8
ANCHO_MAPA_BYTES	EQU	ANCHO_MAPA_TILES*2
ALTO_MAPA_PX		EQU	ALTO_MAPA_TILES*8
ANCHO_MAPA_PX		EQU	ANCHO_MAPA_TILES*4

BITS_DUREZAS		EQU	2		;número de bits de durezas para el mapa
DIVBITS_DUREZAS		EQU	8/BITS_DUREZAS	;número de tiles por byte

;;Te paso los límites entre durezas. 
;;Por encima: duro, por debajo: blando --> Tileset principal=120; Tileset secundario=176
DUREZAS_TOTAL		EQU	137		;hasta que tile son durezas totales (no se pueden traspasar)
DUREZAS_MATAN		EQU	132		;hasta que tile son durezas que matan

TILE_FONDO		EQU	0

CORRECTOR_NUMEROS	EQU	48

GRAVEDAD		EQU	8

INTERVALO_DISPARO	EQU	12
INTERVALO_INVULNERABLE	EQU	60

;CHECKS del PROTA
CHECK_CAMBIO		EQU	1	;bit 1 controla si cambia de pantalla o no
CHECK_PATH			EQU	2	;bit 2 controla si estoy en un camino
CHECK_INVULNERABLE	EQU	4	;si te han matado eres invulnerable un ratejo
CHECK_SOBRE_MALO    EQU 5
;CHECKS de los malos
CHECK_MUERE			EQU     5
CHECK_ABIERTO		EQU     1
CHECK_NIVEL			EQU		4	;
CHECK_DISPARA		EQU     5
CHECK_MATA			EQU		6	;bit 1 si mata o no el sprite al chocar
;CHECKS comunes
CHECK_MUERTE		EQU	0	;bit 0 controla si hemos chocado con alguna dureza que mata o no
CHECK_MUERTE_DESDE	EQU	3	;si la muerte viene desde otro objeto, luego se activa la muerte
CHECK_SIMETRIA		EQU	7	;bit 7 para simetricos o no

;ESTADOS del PROTA
ESTADO_REPOSAR 		EQU	0
ESTADO_ANDAR		EQU	1
ESTADO_SALTAR		EQU	2
ESTADO_CAER			EQU	3
ESTADO_ATERRIZAR	EQU	4
ESTADO_AGACHAR		EQU	5
ESTADO_DISPARAR		EQU	6
ESTADO_RESPINGO		EQU	7

;combinaciones de bits para las durezas en el mapa
BIT_TOTAL		EQU	%01
BIT_MATAN		EQU	%10
BIT_VACIO		EQU	%00
BIT_OBJETO		EQU	%11
;combinaciones de bits para las interrupciones
;Captura Fondo Pantalla
BIT_cfp			EQU	%00000100
BIT_NEG_cfp		EQU	%11111011
;UPDATE
BIT_UPD			EQU	%00001000
BIT_NEG_UPD		EQU	%11110111
;Imprime Sprite Pantalla
BIT_isp			EQU	%00000001
BIT_NEG_isp		EQU	%11111110
;Imprime buffer Pantalla
BIT_ibp			EQU	%00000010
BIT_NEG_ibp		EQU	%11111101

MAX_INT			EQU     3       ;Maximo numero de sprites por interrupcion

SND_DISPARO_PRO EQU 1
SND_SALTO_PRO	EQU 2
SND_ATERRIZAJE  EQU 3

STA_LLAVE		EQU	3	;objetos que se cogen y abren puertas
STA_OBJETO		EQU	2	;objetos que se cogen
STA_PUERTA		EQU	1	;puertas que se abren
STA_TEXTO		EQU 4	;Textos
STA_LLAVEINV	EQU	5	;objetos invisibles que se cogen y abren puertas

STILE_0			EQU     0
STILE_1 		EQU 	1		;codigo de cada supertile
STILE_2 		EQU 	2		;para leer bien las pantallas
STILE_3 		EQU 	3		;realmente no haría falta
STILE_4 		EQU 	4
STILE_5 		EQU 	5
STILE_6 		EQU 	6
STILE_7 		EQU 	7
STILE_8 		EQU 	8
STILE_9 		EQU 	9
STILE_10 		EQU 	10
STILE_11 		EQU 	11
STILE_12 		EQU 	12
STILE_13 		EQU 	13
STILE_14 		EQU 	14
STILE_15 		EQU 	15
STILE_16 		EQU 	16
STILE_17 		EQU 	17
STILE_18 		EQU 	18
STILE_19 		EQU 	19
STILE_20 		EQU 	20
STILE_21 		EQU 	21
STILE_22 		EQU 	22
STILE_23 		EQU 	23
STILE_24 		EQU 	24
STILE_25 		EQU 	25
STILE_26 		EQU 	26
STILE_27 		EQU 	27
STILE_28 		EQU 	28
STILE_29 		EQU 	29
STILE_30 		EQU 	30
STILE_31 		EQU 	31
STILE_32 		EQU 	32
STILE_33 		EQU 	33
STILE_34 		EQU 	34
STILE_35 		EQU 	35
STILE_36 		EQU 	36
STILE_37 		EQU 	37
STILE_38 		EQU 	38
STILE_39 		EQU 	39
STILE_40		EQU 	40
STILE_41 		EQU 	41
STILE_42 		EQU 	42
STILE_43 		EQU 	43
STILE_44 		EQU 	44
STILE_45 		EQU 	45
STILE_46 		EQU 	46
STILE_47 		EQU 	47
STILE_48 		EQU 	48
STILE_49 		EQU 	49
STILE_50 		EQU 	50
STILE_51 		EQU 	51
STILE_52 		EQU 	52
STILE_53 		EQU 	53
STILE_54 		EQU 	54
STILE_55 		EQU 	55
STILE_56 		EQU 	56
STILE_57 		EQU 	57
STILE_58 		EQU 	58
STILE_59 		EQU 	59
STILE_60 		EQU 	60
STILE_61 		EQU 	61
STILE_62 		EQU 	62
STILE_63 		EQU 	63
STILE_64 		EQU 	64
STILE_65 		EQU 	65
STILE_66 		EQU 	66
STILE_67 		EQU 	67
STILE_68 		EQU 	68
STILE_69 		EQU 	69
STILE_70 		EQU 	70
STILE_71 		EQU 	71
STILE_72 		EQU 	72
STILE_73		EQU	73
STILE_74		EQU	74
STILE_75		EQU	75
STILE_76		EQU	76
STILE_77		EQU	77
STILE_78		EQU	78
STILE_79		EQU	79
STILE_80		EQU	80
STILE_81		EQU	81
STILE_82		EQU	82
STILE_83		EQU	83
STILE_84		EQU	84
STILE_85		EQU	85
STILE_86		EQU	86
STILE_87		EQU	87
STILE_88		EQU	88
STILE_89		EQU	89
STILE_90		EQU	90
STILE_91		EQU	91
STILE_92		EQU	92
STILE_93		EQU	93
STILE_94		EQU	94
STILE_95		EQU	95
STILE_96		EQU	96
STILE_97		EQU	97
STILE_98		EQU	98
STILE_99		EQU	99
STILE_100		EQU	100
STILE_101		EQU	101
STILE_102		EQU	102
STILE_103		EQU	103
STILE_104		EQU	104
STILE_105		EQU	105
STILE_106		EQU	106
STILE_107		EQU	107
STILE_108		EQU	108
STILE_109		EQU	109
STILE_110		EQU	110
STILE_111		EQU	111
STILE_112		EQU	112
STILE_113		EQU	113
STILE_114		EQU	114
STILE_115		EQU	115
STILE_116		EQU	116
STILE_117		EQU	117
STILE_118		EQU	118
STILE_119		EQU	119
STILE_120		EQU	120
STILE_121		EQU	121
STILE_122		EQU	122
STILE_123		EQU	123
STILE_124		EQU	124
STILE_125		EQU	125
STILE_126		EQU	126
STILE_127		EQU	127
STILE_128		EQU	128
STILE_129		EQU	129
STILE_130		EQU	130
STILE_131		EQU	131
STILE_132		EQU	132
STILE_133		EQU	133
STILE_134		EQU	134
STILE_135		EQU	135
STILE_136		EQU	136
STILE_137		EQU	137
STILE_138		EQU	138
STILE_139		EQU	139
STILE_140		EQU	140
STILE_141		EQU	141
STILE_142		EQU	142
STILE_143		EQU	143
STILE_144		EQU	144
STILE_145		EQU	145
STILE_146		EQU	146
STILE_147		EQU	147
STILE_148		EQU	148
STILE_149		EQU	149
STILE_150		EQU	150
STILE_151		EQU	151
STILE_152		EQU	152
STILE_153		EQU	153
STILE_154		EQU	154
STILE_155		EQU	155
STILE_156		EQU	156
STILE_157		EQU	157
STILE_158		EQU	158
STILE_159		EQU	159
STILE_160		EQU	160
STILE_161		EQU	161
STILE_162		EQU	162
STILE_163		EQU	163
STILE_164		EQU	164
STILE_165		EQU	165
STILE_166		EQU	166
STILE_167		EQU	167
STILE_168		EQU	168
STILE_169		EQU	169
STILE_170		EQU	170
STILE_171		EQU	171
STILE_172		EQU	172
STILE_173		EQU	173
STILE_174		EQU	174
STILE_175		EQU	175
STILE_176		EQU	176
STILE_177		EQU	177
STILE_178		EQU	178
STILE_179		EQU	179
STILE_180		EQU	180
STILE_181		EQU	181
STILE_182		EQU	182
STILE_183		EQU	183
STILE_184		EQU	184
STILE_185		EQU	185
STILE_186		EQU	186
STILE_187		EQU	187
STILE_188		EQU	188
STILE_189		EQU	189
STILE_190		EQU	190
STILE_191		EQU	191
STILE_192		EQU	192
STILE_193		EQU	193
STILE_194		EQU	194
STILE_195		EQU	195
STILE_196		EQU	196
STILE_197		EQU	197
STILE_198		EQU	198
STILE_199		EQU	199
STILE_200		EQU	200
STILE_201		EQU	201
STILE_202		EQU	202
STILE_203		EQU	203
STILE_204		EQU	204
STILE_205		EQU	205
STILE_206		EQU	206
STILE_207		EQU	207
STILE_208		EQU	208
STILE_209		EQU	209
STILE_210		EQU	210
STILE_211		EQU	211
STILE_212		EQU	212
STILE_213		EQU	213
STILE_214		EQU	214
STILE_215		EQU	215
STILE_216		EQU	216
STILE_217		EQU	217
STILE_218		EQU	218
STILE_219		EQU	219
STILE_220		EQU	220
STILE_221		EQU	221
STILE_222		EQU	222
STILE_223		EQU	223
STILE_224		EQU	224
STILE_225		EQU	225
STILE_226		EQU	226
STILE_227		EQU	227

T_PUNTO			EQU	96+14
T_COMA			EQU     97+14
T_GUION			EQU	98+14
T_A			EQU     99+14
T_O			EQU	100+14
T_U 			EQU	101+14
T_MA			EQU	102+14
T_ME			EQU	103+14
T_MP			EQU	104+14
T_MR			EQU	105+14
T_MS			EQU	106+14
T_EXCLAMACION		EQU	176+14
T_INTERROGACION		EQU	177+14
T_ESPACIO		EQU 	147+14
T_ENIE			EQU	77+14
T_0			EQU     86+14
T_1			EQU	87+14
T_2			EQU	88+14
T_3			EQU	89+14
T_4			EQU	90+14
T_5			EQU	91+14
T_6			EQU	92+14
T_7			EQU	93+14
T_8			EQU	94+14
T_9			EQU	95+14

;Parámetros propios del motor
;****************************
INICIO_CODIGO		EQU	#0040

CURRENT_R7_VALUE	EQU	#1E	; valor al comienzo del CRTC R7

PPI_A			EQU	#F400
PPI_C               	EQU 	#F600
PPI_CONTROL         	EQU 	#F700

PPI_PSG_READ        	EQU 	%01000000
PPI_PSG_SELECT      	EQU 	%11000000

PSG_REG_0E          	EQU 	#0E

OFFSET_SPRITES		EQU	INICIO_SPRITES_IZQ-INICIO_SPRITES_DER
TAMANO_BUFFER		EQU	FIN_BUFFER-BUFFER

DERECHA			EQU	0
IZQUIERDA		EQU	1
ARRIBA			EQU	2
ABAJO			EQU	3

KEY_LINE0          	EQU 	0
KEY_LINE1           	EQU 	1
KEY_LINE2           	EQU 	2
KEY_LINE3          	EQU 	3
KEY_LINE4           	EQU 	4
KEY_LINE5           	EQU 	5
KEY_LINE6           	EQU 	6
KEY_LINE7           	EQU 	7
KEY_LINE8           	EQU 	8
KEY_LINE9           	EQU 	9

; Direcciones del Joystick
; Bits
;;------------D
;; JOY_UP              EQU 0
;; JOY_DOWN            EQU 1
;; JOY_LEFT            EQU 2
;; JOY_RIGHT           EQU 3
;; JOY_FIRE1           EQU 4
;; JOY_FIRE2           EQU 5
;; KEY_F2              EQU 6
;; KEY_ESCAPE          EQU 7
;;------------E
;; KEY_F8              EQU 0
;; KEY_1               EQU 1
;; KEY_2               EQU 2
;; KEY_3               EQU 3
;; KEY_4               EQU 4
;; KEY_5               EQU 5
;; KEY_F6              EQU 6
;; KEY_F4              EQU 7

JOY_UP              	EQU 	0
JOY_DOWN            	EQU 	1
JOY_LEFT            	EQU 	2
JOY_RIGHT           	EQU 	3
JOY_FIRE1           	EQU 	4
JOY_FIRE2          		EQU 	5
KEY_F2  	    		EQU 	6
KEY_ESCAPE	    		EQU 	7

KEY_F8              	EQU 	0
KEY_1              		EQU 	1
KEY_2               	EQU 	2
KEY_3					EQU 	3
KEY_4               	EQU 	4
KEY_5               	EQU 	5
KEY_F6              	EQU 	6
KEY_F4              	EQU 	7

NUMERO_SPRITES		EQU	6

S_ID			EQU	0
S_TIPO			EQU	1
S_X			EQU	2
S_Y			EQU	3
S_STILE			EQU	4
S_CONS			EQU	6
S_TRIGGER		EQU	8
S_TAG			EQU	10
S_BUFFER		EQU 11
LONG_STATICS		EQU	13

_ID			EQU	0
_ANCHO			EQU	1
_ALTO			EQU	2
_X       		EQU     3
_ANTX    		EQU	4
_Y       		EQU     5
_ANTY    		EQU	6
_DSPR    		EQU	7
_SPR     		EQU	9
_SPR_A   		EQU	10
_UPD			EQU	11
_BUFF    		EQU	13
_MIRADA			EQU	15
_IDESP			EQU	16	;de este en adelante de lo enemigos
_DESP			EQU	17
_CHECKS			EQU	18	;checks del PROTA (0-camino)
_ADESP			EQU	19
_ICAD			EQU	20
_CAD			EQU	21
_DISP			EQU	22
_TAG			EQU	23
_VIDAS			EQU	25
; _DIRPAN			EQU	26
; _DIRPAN_A		EQU     28

LONG_SPRITES		EQU	26

_SID         		EQU 0
;_ANCHO			EQU 1
;_ALTO			EQU 2
_SX          		EQU 3
_SANTX       		EQU 4
_SY          		EQU 5
_SANTY       		EQU 6
_SDIRECCION   		EQU 7
_SVEL_X      		EQU 9
_SVEL_Y      		EQU 10
_SMOVIMIENTO 		EQU 11
_SESTADO     		EQU 13
_SBUFFER     		EQU 14
_SLONGITUD			EQU 28
_dX         		EQU 28  ;+14
_dY         		EQU 30
_signos         	EQU 32

COLOR_VERDE		EQU 34
COLOR_MORADO	EQU 35
COLOR_ROJO1		EQU 36
COLOR_ROJO2		EQU 37

EFECTO_RECUPERA EQU 5
EFECTO_NIEVE2	EQU 4
EFECTO_NIEVE1	EQU 3
EFECTO_PENUMBRA EQU 2
EFECTO_PARPADEO EQU 1
EFECTO_SIN		EQU 0

LONG_DISPAROS		EQU 33

_PATH			EQU	16	;este es del PROTA
_ESTADOS		EQU	19

_4x16			EQU     %10010000  ;#4 & #10
_4x08			EQU     %10001000  ;#4 & #08
_2x08			EQU	%01001000  ;#2 & #08
_6x16			EQU	%11010000  ;#6 & #10
_0x00			EQU %00000000

_00SPR			EQU     %00000000
_01SPR			EQU	%00010000
_02SPR			EQU	%00100000
_03SPR			EQU	%00110000
_04SPR			EQU	%01000000
_05SPR			EQU	%01010000
_06SPR			EQU	%01100000
_07SPR			EQU	%01110000
_15SPR			EQU	%11110000

_DER			EQU	%00000000
_IZQ			EQU	%00000100
_ARR			EQU	%00001000
_ABA			EQU	%00001100