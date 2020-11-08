; Interrupciones -----------------------------------------------------

; Int 0 ----------------------
; prepara colores y modos del marcador
; frame 0
;   captura fondo del sprite0
; frame 1
;   sprite 5
myInt0
        PUSH    BC
        PUSH    AF
        ;contador de interrupciones
        LD      A,(Pas_Interrupcion)
        INC     A
        LD      (Pas_Interrupcion),A
        ;siguiente interrupcion
        LD      BC,myInt1
        LD      (&39),BC
        ;registro 12
        LD  BC,#BC00+12   ; 3c
        OUT (C),C       ; 4C
        LD  BC,#BD00+16+32 ; 3c
        OUT (C),C       ; 4c
        ;registro 13
        LD  BC,#BC00+13   ; 3c
        OUT (C),C       ; 4C
sm_explosion
        LD  BC,#BD00+0 ; 3c
        OUT (C),C       ; 4c
        ;colores de la zona de marcador
        ;border juego
        ld      bc,#7f10
        out     (c),c
sm_borderm
        ld      c,0
        out     (c),c
        ;tintas juego
        xor a
        ld      bc,#7f40
        out (c),a
sm_tinta0m
        ld   c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta1m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta5m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta6m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta7m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta8m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta9m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta10m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta11m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta12m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta13m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta14m
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta15m
        ld  c,0
        OUT  (C),C
        ;marco por qué interrupcion (+1) voy
        LD      A,1
        LD      (Sig_Interrupcion),A
        ;si pongo el semaforo a FE no hace nada
        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JP      Z,salir_myInt0
        ;FD se utilizar para imprimir el sprite del prota en otro sitio distinto (marcador)
        CP      #FD
        JR      Z,salir_myInt0
        ;salvo todos los registros
        PUSH HL
        PUSH DE
        EXX
        EX   AF,AF'
        PUSH AF
        PUSH HL
        PUSH DE
        PUSH BC
        PUSH IX
        PUSH IY
        ;calculo en qué pasada estoy
        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt0
        ;primera pasada 
        ;capturo el fondo del prota
        LD      A,(SEMAFORO_IA_PROTA)
        CP      2
        JR      NZ,sigue_myInt0
        ;lo capturo si el semaforo está en 2
        LD      IX,SPRITE0
        LD      HL,SPRITE0_INT
        CALL    Ejecuta_CFP
        LD      A,3
        LD      (SEMAFORO_IA_PROTA),A
        JR      sigue_myInt0
segunda_pasada_myInt0
        ;segunda pasada
        ;sprite 5 (eliminar si da problemas de rendimiento)
        LD      IX,SPRITE1
        LD      HL,SPRITE1_INT
        ;imprimo fondo de pantalla
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        CALL    Z,Ejecuta_IBP
        ;ejecuto IA del malo
        LD      HL,SPRITE1_INT
        CALL    Ejecuta_Rutina_Sprite
        ;actualizo los valores ANT
        LD      HL,SPRITE1_INT
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_DESP)
        LD      (IX+_ADESP),A
        ;ejecuto la impresion del sprite
        CALL    Ejecuta_ISP
no_haces_disparos_mi0
sigue_myInt0
        POP  IY
        POP  IX
        POP  BC
        POP  DE
        POP  HL
        POP  AF
        EX   AF,AF'
        EXX
        POP  DE
        POP  HL
salir_myInt01
salir_myInt0
        POP     AF
        POP     BC
        EI
        RETI

; Int 1 ----------------------
myInt1
        PUSH    BC
        LD      BC,myInt2
        LD      (&39),BC
        PUSH    AF
        LD      A,2
        LD      (Sig_Interrupcion),A
        PUSH HL
        PUSH DE
        PUSH IY
        PUSH IX
        EXX
        PUSH BC
        PUSH DE
        PUSH HL

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FD
        JP      Z,imprime_sprite_prota_mi1

        CP      #FE
        JP      Z,no_haces_sprite_mi1

    LD      A,(EFECTO_FLASH)
    OR      A
    JR      Z,sigue2_flash_ub
    DEC     A
    LD      (EFECTO_FLASH),A
    OR      A
    JR      Z,sigue_flash_ub
    LD      HL,TINTAS_FLASH
    JR      sigue1_flash_ub
sigue_flash_ub
    LD      HL,TINTAS_JUEGO
sigue1_flash_ub
    CALL    Cambia_Tintas_Juego
sigue2_flash_ub

        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt1

        LD      A,(SEMAFORO_IA_PROTA)
        CP      3
        JP      NZ,no_haces_sprite_mi1

        LD      IX,SPRITE0
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(Invulnerable)
        rra
        JR      C,no_pintes_sprite_mi1
        LD      A,(IX+_CHECKS)
        BIT     CHECK_CAMBIO,A
        LD      HL,SPRITE0_INT
        CALL    Z,Ejecuta_ISP
no_pintes_sprite_mi1
        LD      A,0
        LD      (SEMAFORO_IA_PROTA),A
        JP     no_haces_sprite_mi1
segunda_pasada_myInt1
        LD      A,(SEMAFORO_IA_DISPAROS0)
        CP      2
        JR      NZ,no_haces_sprite_mi1
        LD      IX,DISPARO0
        LD      HL,DISPARO0_INT
        CALL    Ejecuta_CFPB

        LD      IX,DISPARO1
        LD      HL,DISPARO1_INT
        CALL    Ejecuta_CFPB

        LD      IX,DISPARO2
        LD      HL,DISPARO2_INT
        CALL    Ejecuta_CFPB

        LD      IX,DISPARO3
        LD      HL,DISPARO3_INT
        CALL    Ejecuta_CFPB

        LD      IX,DISPARO4
        LD      HL,DISPARO4_INT
        CALL    Ejecuta_CFPB

;         LD      IX,DISPARO5
;         LD      HL,DISPARO5_INT
;         CALL    Ejecuta_CFPB

        LD      IX,DISPARO0
        LD      HL,DISPARO0_INT
        CALL    Ejecuta_ISPB
        LD      IX,DISPARO1
        LD      HL,DISPARO1_INT
        CALL    Ejecuta_ISPB
        LD      IX,DISPARO2
        LD      HL,DISPARO2_INT
        CALL    Ejecuta_ISPB
        LD      IX,DISPARO3
        LD      HL,DISPARO3_INT
        CALL    Ejecuta_ISPB
        LD      IX,DISPARO4
        LD      HL,DISPARO4_INT
        CALL    Ejecuta_ISPB
;         LD      IX,DISPARO5
;         LD      HL,DISPARO5_INT
;         CALL    Ejecuta_ISPB

        LD      A,0
        LD      (SEMAFORO_IA_DISPAROS0),A

no_haces_sprite_mi1

        POP  HL
        POP  DE
        POP  BC
        EXX
        POP  IX
        POP  IY
        POP  DE
        POP  HL

        POP     AF

        POP     BC

        EI
        RETI

imprime_sprite_prota_mi1
        LD      HL,SPRITE0_INT
        CALL    Ejecuta_ISP
        LD      A,#FE
        LD      (SEMAFORO_SPR_INT),A
        JR      no_haces_sprite_mi1

; Int 2 ----------------------
myInt2
        PUSH    BC

        LD      BC,myInt3
        LD      (&39),BC

        ld      bc,#7f10
        out     (c),c
        ld      c,&54
        out     (c),c

        PUSH    AF

        LD      A,3
        LD      (Sig_Interrupcion),A

        LD   A,(PANTALLA_ACTUAL)
        CP   33
        JR   C,no_hay_beam_i2
        LD   A,(Pas_Interrupcion)   
        RRA
;        JR   C,no_hay_beam_i2
;        RRA
        JR   C,no_hay_beam_i2
        ld   a,(sm_tinta4_8+1)
        CP   &54
        jr   z,no_hay_beam_i2
        cp   &4e
        jr   z,set_4a_int2
set_4e_int2
        LD   a,&4e
        jr   sig_tinta2
set_4a_int2
        LD   a,&4a
sig_tinta2
        ld   (sm_tinta2_8+1),a
no_hay_beam_i2

        CALL tintas_segunda_int

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'    ;A'
        PUSH AF
        PUSH IX
        PUSH IY

        LD   A,(SEMAFORO_SPR_INT)
        CP   #FE
        JP   Z,no_actives_parpadeo_int2

        LD   A,(EFECTO_TINTAS)
        CP   EFECTO_NIEVE1
        JP   Z,efecto_nieve1r
        CP   EFECTO_NIEVE2
        JP   Z,efecto_nieve2r
        CP   EFECTO_PARPADEO
        JR   Z,actives_parpadeo_int2
        CP   EFECTO_RECUPERA
        JR   NZ,no_actives_parpadeo_int2
actives_parpadeo_int2
        LD   A,(SEMAFORO_PARPADEO)
        CP   1
        JR   Z,decrementa_parpadeo_int2
        CP   2
        JR   Z,_50_frames_int2
decrementa_parpadeo_int2
        LD   HL,(siguiente_parpadeo)
        dec  hl
        ld   (siguiente_parpadeo),HL
        ld   a,l
        or   h
        jr   nz,no_actives_parpadeo_int2
        LD   A,2
        LD   (SEMAFORO_PARPADEO),A
        LD   HL,50
        ld   (siguiente_parpadeo),HL
        JR   no_actives_parpadeo_int2
_50_frames_int2
        CALL Random
        CP   176
        jr   nc,tinta_normal_int2
        LD   HL,TINTAS_PENUMBRA
        jr   sigue_tintas_int2
tinta_normal_int2
        LD   HL,TINTAS_JUEGO
sigue_tintas_int2
        CALL Cambia_Tintas_Juego
        LD   HL,(siguiente_parpadeo)
        dec  l
        ld   (siguiente_parpadeo),HL
        jr   nz,no_actives_parpadeo_int2
        call inicializa_parpadeo
        JR   fin_parpadeo_int2
efecto_nieve1r
efecto_nieve2r
        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,fin_parpadeo_int2

        LD   A,(nieve_actual)
        CP   7
        JR   nz,sigue_bucle_eni1
        LD   A,#ff
sigue_bucle_eni1
        INC  A
        LD   (nieve_actual),A
        LD   DE,17
        LD   HL,PALETA0
        OR   A
        JR   Z,fin_nieve1
bucle_paleta_nieve1
        ADD  HL,DE
        DEC  A
        jr   nz,bucle_paleta_nieve1
fin_nieve1
        LD      DE,sm_border2
        CALL    Cambia_Tintas_Zona
        LD      A,(EFECTO_TINTAS)
        CP      EFECTO_NIEVE2
        JR      NZ,fin_parpadeo_int2
        LD      DE,sm_border3
        CALL    Cambia_Tintas_Zona
fin_parpadeo_int2
no_actives_parpadeo_int2
;         LD      A,(Invulnerable)
;         rra
;         JR      C,tintas_siempre_int2

;         LD      A,(SEMAFORO_SPR_INT)
;         CP      #FE
;         JR      Z,tintas_siempre_int2

;         LD      A,(Pas_Interrupcion)
;         RRA
;         JR      C,no_cambies_tinta_int2
; tintas_siempre_int2
;         LD      A,(SEMAFORO_SPR_INT)
;         CP      #FE
;         JP      C,salir_myInt2

        CALL    Read_Keys
        LD      A,D
        LD      (TECLADO0),A
        ;LD      A,E
        ;LD      (TECLADO1),A
        ld   a,(HAY_MUSICA)
        or   a
        CALL z,PLY_Play

; salir_myInt2
        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'   ;A'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

        POP     AF

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&54
;         out     (c),c

        POP     BC

        EI
        RETI

tintas_segunda_int
        ;border juego
        ld      bc,#7f10
        out     (c),c
sm_border2
        ld    c,0
        out     (c),c
        ;tintas juego
        xor a
        ld      bc,#7f40
        out (c),a
sm_tinta2_0
        ld   c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_1
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_2
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_3
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_4
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_5
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_6
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_7
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_8
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_9
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_10
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_11
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_12
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_13
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_14
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta2_15
        ld  c,0
        OUT  (C),C
ret

; Int 3 ----------------------

; no hace nada

myInt3
        PUSH    BC

        LD      BC,myInt4
        LD      (&39),BC

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&52
;         out     (c),c

        PUSH    AF

        LD   A,(PANTALLA_ACTUAL)
        CP   33
        JR   C,no_hay_beam_i3
        LD   A,(Pas_Interrupcion)   
        RRA
;        JR   C,no_hay_beam_i3
;        RRA
        JR   C,no_hay_beam_i3
        ld   a,(sm_tinta4_8+1)
        CP   &54
        jr   z,no_hay_beam_i3
        cp   &4e
        jr   z,set_4a_int3
set_4e_int3
        LD   a,&4e
        jr   sig_tinta3
set_4a_int3
        LD   a,&4a
sig_tinta3
        ld   (sm_tinta3_8+1),a
no_hay_beam_i3
        ;border juego
        ld      bc,#7f10
        out     (c),c
sm_border3
        ld    c,0
        out     (c),c
        ;tintas juego
        xor a
        ld      bc,#7f40
        out (c),a
sm_tinta3_0
        ld   c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_1
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_2
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_3
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_4
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_5
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_6
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_7
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_8
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_9
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_10
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_11
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_12
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_13
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_14
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta3_15
        ld  c,0
        OUT  (C),C

        LD      A,4
        LD      (Sig_Interrupcion),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JR      Z,salir_myInt3
        CP      #FD
        JR      Z,salir_myInt3

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'   ;A'
        PUSH AF
        PUSH IX
        PUSH IY

        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt3
        LD      IX,SPRITE5
        LD      HL,SPRITE5_INT
        JR      primera_pasada_myInt3
segunda_pasada_myInt3
        LD      IX,SPRITE3
        LD      HL,SPRITE3_INT
primera_pasada_myInt3
        PUSH    HL
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        CALL    Z,Ejecuta_IBP
        POP     HL
        PUSH    HL
        CALL    Ejecuta_Rutina_Sprite
        POP     HL
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_DESP)
        LD      (IX+_ADESP),A
        CALL    Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'   ;A'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

salir_myInt3

        POP     AF

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&54
;         out     (c),c

        POP     BC

        EI
        RETI

; Int 4 ----------------------

; prepara la pantalla inferior

myInt4
        PUSH    BC

        LD      BC,myInt5
        LD      (&39),BC

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&53
;         out     (c),c

;modo pantalla inferior
;         LD      BC,#7F8C + MODO_MARCADOR
;         OUT     (C),C           ;MODE 0

        PUSH    AF

        LD   A,(PANTALLA_ACTUAL)
        CP   33
        JR   C,no_hay_beam_i4
        LD   A,(Pas_Interrupcion)   
        RRA
;         JR   C,no_hay_beam_i4
;         RRA
        JR   C,no_hay_beam_i4
        ld   a,(sm_tinta4_8+1)
        CP   &54
        jr   z,no_hay_beam_i4
        cp   &4e
        jr   z,set_4a_int4
set_4e_int4    
        LD   a,&4e
        jr   sig_tinta4
set_4a_int4
        LD   a,&4a
sig_tinta4
        ld   (sm_tinta4_8+1),a

no_hay_beam_i4
        ;border juego
        ld      bc,#7f10
        out     (c),c
sm_border4
        ld    c,0
        out     (c),c
        ;tintas juego
        xor a
        ld      bc,#7f40
        out (c),a
sm_tinta4_0
        ld   c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_1
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_2
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_3
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_4
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_5
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_6
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_7
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_8
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_9
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_10
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_11
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_12
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_13
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_14
        ld  c,0
        OUT  (C),C

        inc a
        out     (c),a
sm_tinta4_15
        ld  c,0
        OUT  (C),C

        LD      A,5
        LD      (Sig_Interrupcion),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JR      Z,salir_myInt4
        CP      #FD
        JR      Z,salir_myInt4

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'   ;A'
        PUSH AF
        PUSH IX
        PUSH IY

        LD      A,(Pas_Interrupcion)
        RRA
        JR      NC,segunda_pasada_myInt4
        LD      IX,SPRITE2
        LD      HL,SPRITE2_INT
        JR      primera_pasada_myInt4
segunda_pasada_myInt4
        LD      IX,SPRITE4
        LD      HL,SPRITE4_INT
primera_pasada_myInt4
        PUSH    HL
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        CALL    Z,Ejecuta_IBP
        POP     HL
        PUSH    HL
        CALL    Ejecuta_Rutina_Sprite
        POP     HL
        LD      A,(IX+_X)
        LD      (IX+_ANTX),A
        LD      A,(IX+_Y)
        LD      (IX+_ANTY),A
        LD      A,(IX+_DESP)
        LD      (IX+_ADESP),A
        CALL    Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'   ;A'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

salir_myInt4
        POP     AF

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&54
;         out     (c),c

        POP     BC

        EI
        RETI

; Int 5 ----------------------

myInt5
        PUSH    BC

        LD      BC,myInt0
        LD      (&39),BC

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&4e
;         out     (c),c

        PUSH    AF
        XOR     A
        LD      (Sig_Interrupcion),A

        LD      A,(SEMAFORO_SPR_INT)
        CP      #FE
        JP      Z,salir_myInt5
        CP      #FD
        JP      Z,salir_myInt5

        PUSH HL
        PUSH DE
        EXX
        PUSH HL
        PUSH DE
        PUSH BC
        EX   AF,AF'   ;A'
        PUSH AF
        PUSH IX
        PUSH IY

        LD      A,(Pas_Interrupcion)
        RRA
        JR      C,segunda_pasada_myInt5
;         LD      IX,SPRITE3
;         LD      HL,SPRITE3_INT
;         LD      A,(SEMAFORO_SPR_INT)

;         PUSH    HL
;         OR      A
;         CALL    Z,Ejecuta_IBP
;         POP     HL
;         PUSH    HL
;         CALL    Ejecuta_Rutina_Sprite
;         POP     HL
;         LD      A,(IX+_X)
;         LD      (IX+_ANTX),A
;         LD      A,(IX+_Y)
;         LD      (IX+_ANTY),A
;         LD      A,(IX+_DESP)
;         LD      (IX+_ADESP),A
;         CALL    Ejecuta_ISP
        LD      A,(SEMAFORO_IA_PROTA)
        OR      A
        JR      NZ,primera_pasada_myInt5
        LD      IX,SPRITE0
        LD      HL,SPRITE0_INT
        CALL    Ejecuta_IBP 
        LD      A,1
        LD      (SEMAFORO_IA_PROTA),A

        JR      primera_pasada_myInt5
segunda_pasada_myInt5
;         LD      IX,SPRITE6
;         LD      HL,SPRITE6_INT

        ;en el frame 1 ejecuta los disparos
        ;imprimo_buffer pantalla de los disparos para evitar solapes
        LD      A,(SEMAFORO_IA_DISPAROS0)
        OR      A
        JR      NZ,activar_CFP_myInt5
;         LD   IX,DISPARO5
;         LD   HL,DISPARO5_INT
;         CALL Ejecuta_IBPB
        LD   IX,DISPARO4
        LD   HL,DISPARO4_INT
        CALL Ejecuta_IBPB
        LD   IX,DISPARO3
        LD   HL,DISPARO3_INT
        CALL Ejecuta_IBPB
        LD   IX,DISPARO2
        LD   HL,DISPARO2_INT
        CALL Ejecuta_IBPB
        LD   IX,DISPARO1
        LD   HL,DISPARO1_INT
        CALL Ejecuta_IBPB
        LD   IX,DISPARO0
        LD   HL,DISPARO0_INT
        CALL Ejecuta_IBPB

        LD   A,1
        LD   (SEMAFORO_IA_DISPAROS0),A

activar_CFP_myInt5
        LD      A,(SEMAFORO_SPR_INT)
        OR      A
        JR      Z,primera_pasada_myInt5

        XOR     A
        LD      (SEMAFORO_SPR_INT),A
;         LD      A,#FE
primera_pasada_myInt5
;         PUSH    HL
;         OR      A
;         CALL    Z,Ejecuta_IBP
;         POP     HL
;         PUSH    HL
;         CALL    Ejecuta_Rutina_Sprite
;         POP     HL
;         LD      A,(IX+_X)
;         LD      (IX+_ANTX),A
;         LD      A,(IX+_Y)
;         LD      (IX+_ANTY),A
;         LD      A,(IX+_DESP)
;         LD      (IX+_ADESP),A
;         CALL    Ejecuta_ISP

        POP  IY
        POP  IX
        POP  AF
        EX   AF,AF'    ;A'
        POP  BC
        POP  DE
        POP  HL
        EXX
        POP  DE
        POP  HL

salir_myInt5
;         LD      A,(SEMAFORO_PAUSA)
;         OR      A
;         JR      Z,sigue_sal_myInt5
;         XOR     A
;         LD      (SEMAFORO_PAUSA),A
;         LD      A,#FE
;         ld      (SEMAFORO_SPR_INT),A
sigue_sal_myInt5
        POP     AF

;         ld      bc,#7f10
;         out     (c),c
;         ld      c,&54
;         out     (c),c

        POP     BC

        EI
        RETI

; set_crtc_screen_address
;         ;fija zona de memoria de la pantalla
;         SET_CRTC_REG 6,#10
;         SET_CRTC_REG #0C,ZONA_JUEGO

;         LD      BC,#BC0D        ; 3c
;         OUT     (C),C           ; 4C
; Offset_Terremoto
;         LD      BC,#BD00        ; 3c
;         OUT     (C),C           ; 4c

;         WAIT_CYCLES  342;384-42;310  ; espera 6 scanlines (el equivalente al +3 que se le da al r4 al final del halt 4)

;         ;caracter de 8 pixeles de alto
;         ;SET_CRTC_REG 9,7
;         RET
