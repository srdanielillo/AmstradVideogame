;;----------------------------------------------
;;Genera_Stiles
;;Genera mapa de SuperTiles
;;----------------------------------------------
;;Genera_Mapa
;;Genera mapa de pantallas
;;----------------------------------------------

;cuando se ejecuten estas subrutinas se podrá
;reutilizar el espacio con buffers intermedios
BUFFER 
start   ; AQUI  EMPIEZA LA EJECUCION

        ;posiciono la pila. De momento debajo de la pantalla
        DI
        LD      SP,#C000
        LD      HL,#C9FB
        LD      (#38),HL

        ld      a,1
        ld      (HAY_MUSICA),A
        ;modo pantalla juego
        LD      BC,#7F8C + MODO_JUEGO
        OUT     (C),C
        ; cambia a pantalla con split
        CALL    toSplitScreen
        ;cambia las tintas del juego
        CALL    Borra_Pantalla
        LD      HL,TINTAS_JUEGO
        CALL    Cambia_Tintas_Juego
        LD      HL,TINTAS_NEGRO
        CALL    Cambia_Tintas_Marcador
        ;Para Loader quitar las 4 CALL
        ;genera tabla de ScanLines
        ;LOADER
        CALL    Genera_ScanLines
        ;genera mapa de pantallas
        ;LOADER
        CALL    Genera_Mapa
        ;genera mapa de SuperTiles
        ;LOADER
        CALL    Genera_Stiles
        ;genera tabla de mascaras
        ;LOADER
        CALL    Genera_Tabla_Mascaras
        ;inicializa la musica
        ;LD      DE,SNG_FX
        ;CALL    PLY_SFX_Init
;         LD      DE,SNG_MENU
;         CALL    PLY_Init

        JP      inicio_menu
;;
;;Genera tabla de scanlines
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye A,BC,DE,HL,IX
;;
Genera_ScanLines
        LD      IX,TABLA_SCANLINES
        LD      HL,DIRECCION_JUEGO
        LD      DE,#800
        LD      BC,#C050
        LD      A,193
loop_gs
        LD      (IX+0),L
        inc     ixh
        LD      (IX+0),H
        dec     ixh
        INC     IX
        ADD     HL,DE
        JR      NC,siguiente_scanline_gs
        ADD     HL,BC
siguiente_scanline_gs
        DEC     A
        JR      NZ,loop_gs
        RET


;genero la tabla de bytes con sus mascaras
;de esta manera no tengo que guardar mascaras
;pues las tengo precalculadas
;rutina de cesar nicolas (se nota en los comentarios)
Genera_Tabla_Mascaras
        LD   HL,TABLA_MASCARAS  
PRECALCULAR: 
        LD   A,L                                        ; como TABLADEBYTES esta alineada a 256, en su primera iteracion vale 0 - esto nos ahorra un registro que vaya de 0 a 255
        AND  #AA
        JR   Z,PRECALCULAR1
        LD   A,#AA                                      ; mascara del primer pixel
PRECALCULAR1:
        LD   C,A                                        ; primer pixel final
  
        LD   A,L
        AND  #55
        JR   Z,PRECALCULAR2
        LD   A,#55
        OR   C
        LD   C,A                                        ; segundo pixel final
  
PRECALCULAR2:
        OR   C                                          ; ya tenemos los cuatro pixeles del sprite...
        CPL                                             ; ...y los negamos binariamente, porque lo que queremos es la mascara para respetar el fondo.
        LD   (HL),A
        INC  L                                          ; gracias a la alineaci?n tambi?n nos ahorramos un contador de vueltas de 255 a 0.
        JR   NZ,PRECALCULAR
        

        LD   HL,TABLA_ROTACIONES
PRECALCULAR_BYTESR: 
        LD   A,L
        AND  %01010101
        RLA
        LD   C,A
        LD   A,L
        AND  %10101010
        RRA
        OR   C
        LD   (HL),A
        INC  L                                          ; gracias a la alineaci?n tambi?n nos ahorramos un contador de vueltas de 255 a 0.
        JR   NZ,PRECALCULAR_BYTESR

        RET
;write direct -1,-1,#c0

        ; Cambia del modo de pantalla standar a modo split

toSplitScreen
        DI
        LD      HL,#C9FB
        LD      (#38),HL

        ; DIMENSIONES Y POSICION DEL AREA DE JUEGO

        CALL    wVb

        LD      HL,#2E28        ; H = X, L = W
        LD      DE,#1e19        ; D = Y, E = H
        CALL    redim_screen

        ; interrupcion

        LD      A,#C3
        LD      (#38),A
        LD      HL,myInt0
        LD      (#39),HL

        CALL    wVb

        ;SET_CRTC_REG    7,48    ; se puede sacar fuera porque no cambia

        LD      A,48
        LD      (currentR7+1),A

        EI
        RET


; Redimensiona el tamanyo y posicion de la pantalla manteniendo los 50hz
; h = x, l = w
; d = y, e = h

redim_screen
        LD      BC,#BC01        ; W
        OUT     (C),C
        INC     B
        OUT     (C),L

        LD      BC,#BC02        ; X
        OUT     (C),C
        INC     B
        OUT     (C),H

        LD      BC,#BC06        ; H
        OUT     (C),C
        INC     B
        OUT     (C),E

currentR7
        LD      A,CURRENT_R7_VALUE
        SUB     D
        JR      Z,screen_ok

        ADD     38              ; A = R4 VALUE

        LD      BC,#BC04
        OUT     (C),C
        INC     B
        OUT     (C),A           ; R4 = A

        EI

        LD      A,D
        LD      C,2
        CP      33
        JR      NC,wait_halts
        INC     C
        CP      27
        JR      NC,wait_halts
        INC     C
        CP      21
        JR      NC,wait_halts
        INC     C
        CP      14
        JR      NC,wait_halts
        INC     C
wait_halts
        HALT
        DEC     C
        JR      NZ,wait_halts

        DI

        LD      C,38
        OUT     (C),C           ; R4 = 38
        LD      BC,#BC07
        OUT     (C),C
        INC     B
        OUT     (C),D           ; R7 = D
        LD      A,D
        LD      (currentR7+1),A
screen_ok
        RET
;;
;;Genera mapa de SuperTiles
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye HL
;;
Genera_Stiles
        LD      E,0
        LD      HL,dstile_0
        LD      IX,MAPA_STILES
sigue_stiles
        LD      (IX+00),L
        LD      (IX+01),H
        INC     IX
        INC     IX
        LD      A,(HL)
        AND     %01110000
        RRA
        RRA
        RRA
        RRA
        inc     a
        LD      B,A
        LD      A,(HL)
        AND     %00001111
        LD      C,A
        XOR     A
multiplica_stile
        ADD     C
        DJNZ    multiplica_stile
        LD      C,A
        inc     HL
        add     hl,bc
        INC     E
        LD      A,E
        CP      228
        RET     Z
        JR      sigue_stiles

;;
;;Genera mapa de pantallas
;;
;;ENTRADA
;;nada
;;SALIDA
;;Nada
;;destruye HL
;;
Genera_Mapa
        LD      HL,PANTALLA_00
        LD      (MAPA_PANTALLAS+00),HL
        LD      HL,PANTALLA_01
        LD      (MAPA_PANTALLAS+02),HL
        LD      HL,PANTALLA_02
        LD      (MAPA_PANTALLAS+04),HL
        LD      HL,PANTALLA_03
        LD      (MAPA_PANTALLAS+06),HL
        LD      HL,PANTALLA_04
        LD      (MAPA_PANTALLAS+08),HL
        LD      HL,PANTALLA_05
        LD      (MAPA_PANTALLAS+10),HL
        LD      HL,PANTALLA_06
        LD      (MAPA_PANTALLAS+12),HL
        LD      HL,PANTALLA_07
        LD      (MAPA_PANTALLAS+14),HL
        LD      HL,PANTALLA_08
        LD      (MAPA_PANTALLAS+16),HL
        LD      HL,PANTALLA_09
        LD      (MAPA_PANTALLAS+18),HL
        LD      HL,PANTALLA_10
        LD      (MAPA_PANTALLAS+20),HL
        LD      HL,PANTALLA_11
        LD      (MAPA_PANTALLAS+22),HL
        LD      HL,PANTALLA_12
        LD      (MAPA_PANTALLAS+24),HL
        LD      HL,PANTALLA_13
        LD      (MAPA_PANTALLAS+26),HL
        LD      HL,PANTALLA_14
        LD      (MAPA_PANTALLAS+28),HL
        LD      HL,PANTALLA_15
        LD      (MAPA_PANTALLAS+30),HL
        LD      HL,PANTALLA_16
        LD      (MAPA_PANTALLAS+32),HL
        LD      HL,PANTALLA_17
        LD      (MAPA_PANTALLAS+34),HL
        LD      HL,PANTALLA_18
        LD      (MAPA_PANTALLAS+36),HL
        LD      HL,PANTALLA_19
        LD      (MAPA_PANTALLAS+38),HL
        LD      HL,PANTALLA_20
        LD      (MAPA_PANTALLAS+40),HL
        LD      HL,PANTALLA_21
        LD      (MAPA_PANTALLAS+42),HL
        LD      HL,PANTALLA_22
        LD      (MAPA_PANTALLAS+44),HL
        LD      HL,PANTALLA_23
        LD      (MAPA_PANTALLAS+46),HL
        LD      HL,PANTALLA_24
        LD      (MAPA_PANTALLAS+48),HL
        LD      HL,PANTALLA_25
        LD      (MAPA_PANTALLAS+50),HL
        LD      HL,PANTALLA_26
        LD      (MAPA_PANTALLAS+52),HL
        LD      HL,PANTALLA_27
        LD      (MAPA_PANTALLAS+54),HL
        LD      HL,PANTALLA_28
        LD      (MAPA_PANTALLAS+56),HL
        LD      HL,PANTALLA_29
        LD      (MAPA_PANTALLAS+58),HL
        LD      HL,PANTALLA_30
        LD      (MAPA_PANTALLAS+60),HL
        LD      HL,PANTALLA_31
        LD      (MAPA_PANTALLAS+62),HL
        LD      HL,PANTALLA_32
        LD      (MAPA_PANTALLAS+64),HL
        LD      HL,PANTALLA_33
        LD      (MAPA_PANTALLAS+66),HL
        LD      HL,PANTALLA_34
        LD      (MAPA_PANTALLAS+68),HL
        LD      HL,PANTALLA_35
        LD      (MAPA_PANTALLAS+70),HL
        LD      HL,PANTALLA_36
        LD      (MAPA_PANTALLAS+72),HL
        LD      HL,PANTALLA_37
        LD      (MAPA_PANTALLAS+74),HL
        LD      HL,PANTALLA_38
        LD      (MAPA_PANTALLAS+76),HL
        LD      HL,PANTALLA_39
        LD      (MAPA_PANTALLAS+78),HL
        LD      HL,PANTALLA_40
        LD      (MAPA_PANTALLAS+80),HL
        LD      HL,PANTALLA_41
        LD      (MAPA_PANTALLAS+82),HL
        LD      HL,PANTALLA_42
        LD      (MAPA_PANTALLAS+84),HL
        LD      HL,PANTALLA_43
        LD      (MAPA_PANTALLAS+86),HL
        LD      HL,PANTALLA_44
        LD      (MAPA_PANTALLAS+88),HL
        LD      HL,PANTALLA_45
        LD      (MAPA_PANTALLAS+90),HL
        LD      HL,PANTALLA_46
        LD      (MAPA_PANTALLAS+92),HL
        LD      HL,PANTALLA_47
        LD      (MAPA_PANTALLAS+94),HL
        LD      HL,PANTALLA_48
        LD      (MAPA_PANTALLAS+96),HL
        LD      HL,PANTALLA_49
        LD      (MAPA_PANTALLAS+98),HL
        LD      HL,PANTALLA_50
        LD      (MAPA_PANTALLAS+100),HL
        RET

