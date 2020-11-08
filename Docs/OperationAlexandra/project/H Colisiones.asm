rectangles_collide
;IX rectangle a
;IY rectangle b
;Retorno C si hay colisión
    LD   B,(IX+_ANCHO)
    LD   A,(IX+_X)
    ADD  A,B
    LD   B,A                                ;aRight

    LD   A,(IY+_X)                  ;bLeft
    
    CP   B
    RET  NC                                 ;bLeft<=aRight

    LD   A,(IY+_X)
    LD   B,(IY+_ANCHO)
    ADD  A,B
    LD   B,A                                ;bRight
    
    LD   A,(IX+_X)                  ;aLeft
    
    CP   B
    RET   NC                                ;aLeft<=bRight
rectangles_collide_hor
    LD   A,(IX+_Y)
    LD   B,(IX+_ALTO)
    ADD  A,B
    LD   B,A                                ;aTop
    
    LD   A,(IY+_Y)                  ;bBottom
    
    CP   B
    RET  NC                                 ;bTottom<=aTop
    
    LD   A,(IY+_Y)
    LD   B,(IY+_ALTO)
    ADD  A,B
    LD   B,A                                ;bTop
    
    LD   A,(IX+_Y)                  ;aBottom
    
    CP   B
    RET


; rectangles_collide_sp0
; ;IX rectangle a
; ;IY rectangle b
; ;Retorno C si hay colisión
;     LD   B,(IX+_ANCHO)
;     LD   A,(SPRITE0_X)
;     ADD  A,B
;     LD   B,A                                ;aRight

;     LD   A,(IY+_X)                  ;bLeft
    
;     CP   B
;     RET  NC                                 ;bLeft<=aRight

;     LD   A,(IY+_X)
;     LD   B,(IY+_ANCHO)
;     ADD  A,B
;     LD   B,A                                ;bRight
    
;     LD   A,(SPRITE0_X)                  ;aLeft
    
;     CP   B
;     RET   NC                                ;aLeft<=bRight
; rectangles_collide_sp0_hor
;     LD   A,(SPRITE0_Y)
;     LD   B,(iX+_ALTO)
;     ADD  A,B
;     LD   B,A                                ;aTop
    
;     LD   A,(IY+_Y)                  ;bBottom
    
;     CP   B
;     RET  NC                                 ;bTottom<=aTop
    
;     LD   A,(IY+_Y)
;     LD   B,(IY+_ALTO)
;     ADD  A,B
;     LD   B,A                                ;bTop
    
;     LD   A,(SPRITE0_Y)                  ;aBottom
    
;     CP   B
;     RET

;hacer bucle de 5
choque_malos
    	;;NC:no hay colision
    	;;C:hay colision
    	;compruebo choques con demás sprites
        LD  HL,Choq_MALOS
choque_malos_comun
        XOR A
        LD  (HL),A
        LD	A,(SPRITE0_INT+1)
        OR	A
        JR	Z,mueve_prota_snUP1
        LD  IY,SPRITE1
        CALL rectangles_collide
        JR  NC,mueve_prota_snUP1
        SET 0,(HL)
mueve_prota_snUP1
        LD	A,(SPRITE0_INT+2)
        OR	A
        JR	Z,mueve_prota_snUP2
        LD  IY,SPRITE2
        CALL    rectangles_collide
        JR  NC,mueve_prota_snUP2
        SET 1,(HL)
mueve_prota_snUP2
        LD	A,(SPRITE0_INT+3)
        OR	A
        JR	Z,mueve_prota_snUP3
        LD  IY,SPRITE3
        CALL    rectangles_collide
        JR  NC,mueve_prota_snUP3
        SET 2,(HL)
mueve_prota_snUP3
        LD	A,(SPRITE0_INT+4)
        OR	A
        JR	Z,mueve_prota_snUP4
        LD  IY,SPRITE4
        CALL    rectangles_collide
        JR  NC,mueve_prota_snUP4
        SET 3,(HL)
mueve_prota_snUP4
        LD	A,(SPRITE0_INT+5)
        OR	A
        JR	Z,mueve_prota_snUP5
        LD  IY,SPRITE5
        CALL rectangles_collide
        JR  NC,mueve_prota_snUP5
        SET 4,(HL)
mueve_prota_snUP5
;         LD	A,(SPRITE0_INT+6)
;         OR	A
;         JR  Z,sal_snUP
;         LD  IY,SPRITE6
;         CALL	rectangles_collide
;         JR  NC,sal_snUP
;         SET 5,(HL)
sal_snUP
        LD  A,(HL)
        OR  A
        JR  NZ,setcarry_sn
        XOR A
        RET
setcarry_sn
        SCF
        RET

choque_malos_desde_disp
        LD  HL,Choq_MALOS_desde_DISP
        JR  choque_malos_comun
;         XOR A
;         LD  (HL),A
;         LD  A,(SPRITE0_INT+1)
;         OR  A
;         JR  Z,mueve_prota_snUP11
;         LD  IY,SPRITE1
;         CALL rectangles_collide
;         JR  NC,mueve_prota_snUP11
;         SET 0,(HL)
;         JR  sal_snUP1
; mueve_prota_snUP11
;         LD  A,(SPRITE0_INT+2)
;         OR  A
;         JR  Z,mueve_prota_snUP21
;         LD  IY,SPRITE2
;         CALL    rectangles_collide
;         JR  NC,mueve_prota_snUP21
;         SET 1,(HL)
;         JR  sal_snUP1
; mueve_prota_snUP21
;         LD  A,(SPRITE0_INT+3)
;         OR  A
;         JR  Z,mueve_prota_snUP31
;         LD  IY,SPRITE3
;         CALL    rectangles_collide
;         JR  NC,mueve_prota_snUP31
;         SET 2,(HL)
;         JR  sal_snUP1
; mueve_prota_snUP31
;         LD  A,(SPRITE0_INT+4)
;         OR  A
;         JR  Z,mueve_prota_snUP41
;         LD  IY,SPRITE4
;         CALL    rectangles_collide
;         JR  NC,mueve_prota_snUP41
;         SET 3,(HL)
;         JR  sal_snUP1
; mueve_prota_snUP41
;         LD  A,(SPRITE0_INT+5)
;         OR  A
;         JR  Z,mueve_prota_snUP51
;         LD  IY,SPRITE5
;         CALL    rectangles_collide
;         JR  NC,mueve_prota_snUP51
;         SET 4,(HL)
;         JR  sal_snUP1
; mueve_prota_snUP51
; ;         LD  A,(SPRITE0_INT+6)
; ;         OR  A
; ;         JR  Z,sal_snUP1
; ;         LD  IY,SPRITE6
; ;         CALL    rectangles_collide
; ;         JR  NC,sal_snUP1
; ;         SET 5,(HL)
; sal_snUP1
;         LD  A,(HL)
;         OR  A
;         JR  NZ,setcarry_sn1
;         XOR A
;         RET
; setcarry_sn1
;         SCF
;         RET

; ;rutina para controlar el choque vertical con algún malo o disparo enemigo del prota
; choque_malos_disparos_ver
;         exx
;         OR   A
;         JR   nz,abajo_ver
;         LD   C,3
;         JR   sigue_ver
; abajo_ver
;         LD   C,0
; sigue_ver
;         ld   b,(ix+_x)
;         add  b
;         sub  c
;         ld   (newx),a
;         CALL choque_malos_ver
;         CALL choque_disparos_ver
;         ld   a,e
;         ld   (Choq_DISP),a
;         LD   A,D
;         ld   (Choq_MALOS),a
;         or   e
;         JR   NZ,setcarry_smdv
;         XOR  A
;         jr   salir_cmpv
; setcarry_smdv
;         SCF
; salir_cmpv
;         exx
;         RET

; ;subrutina para controlar el choque vertical con algún malo del prota
; choque_malos_ver
;     ;;NC-no hay colision
;     ;;C-hay colision
;     ;compruebo choques con demás sprites
;         LD  D,0     ;inicializa bits
;         LD  E,0     ;6 sprites HASTA 5
;         LD  IY,SPRITE1
;         LD  HL,SPRITE0_INT+1
; bucle_cmv
;         PUSH HL
;         LD   A,(HL)
;         OR   A
;         JR   Z,mueve_prota_snUP1v
;         ld   hl,newy
;         ld   a,(iy+_y)
;         cp   (hl)
;         jr   c,mueve_prota_snUP1v
;         ld   b,(iy+_alto)
;         add  b
;         cp   (hl)
;         jr   nc,mueve_prota_snUP1v
;         CALL rectangles_collide_ver         ;jode a y b
;         JR   NC,mueve_prota_snUP1v
;         xor  a
;         LD   A,E
;         RLA
;         RLA
;         RLA
;         OR   %11000010
;         ld   (sm_bit_cmh+1),A
; sm_bit_cmv
;         SET  0,d
; mueve_prota_snUP1v
;         ld   a,c
;         ld   bc,LONG_SPRITES
;         add  iy,bc
;         ld   c,a
;         pop  HL
;         INC  HL
;         LD   A,D
;         or   a
;         ret  NZ             ;solo puede haber una colision con malos
;         inc  e
;         ld   a,e
;         CP   6
;         jr   nz,bucle_cmv
;         RET


;rutina para controlar el choque con algún malo o disparo enemigo del prota
choque_malos_disparos
    ld a,(sprite0_checks)
    bit CHECK_CAMBIO,A
    jr  nz,setcarry_smd
        exx
        ex   af,af'
        CALL choque_malos
        CALL choque_disparos
        LD   A,(Choq_MALOS)
        LD   HL,Choq_DISP
        OR   (HL)
        OR   A
        JR   NZ,setcarry_smd
        XOR  A
        jr   salir_cmp
setcarry_smd
        SCF
salir_cmp
        exx
        RET

; ;rutina para controlar el choque horizontal con algún malo o disparo enemigo del prota
; choque_malos_disparos_hor
;         exx
;         OR   A
;         JR   nz,izquierda_hor
;         LD   C,3
;         JR   sigue_hor
; izquierda_hor
;         LD   C,0
; sigue_hor
;         ld   b,(ix+_x)
;         add  b
;         sub  c
;         ld   (newx),a
;         CALL choque_malos_hor
;         CALL choque_disparos_hor
;         ld   a,e
;         ld   (Choq_DISP),a
;         LD   A,D
;         ld   (Choq_MALOS),a
;         or   e
;         JR   NZ,setcarry_smdh
;         XOR  A
;         jr   salir_cmph
; setcarry_smdh
;         SCF
; salir_cmph
;         exx
;         RET

; ;subrutina para controlar el choque con algún malo del prota
; choque_malos_hor
     ;;NC:no hay colision
     ;;C:hay colision
;     ;compruebo choques con demás sprites
;         LD  D,0     ;inicializa bits
;         LD  E,0     ;6 sprites HASTA 5
;         LD  IY,SPRITE1
;         LD  HL,SPRITE0_INT+1
; bucle_cmh
;         PUSH HL
;         LD   A,(HL)
;         OR   A
;         JR   Z,mueve_prota_snUP1h
;         ld   hl,newx
;         ld   a,(iy+_x)
;         cp   (hl)
;         jr   nz,mueve_prota_snUP1h
;         CALL rectangles_collide_hor         ;jode a y b
;         JR   NC,mueve_prota_snUP1h
;         xor  a
;         LD   A,E
;         RLA
;         RLA
;         RLA
;         OR   %11000010
;         ld   (sm_bit_cmh+1),A
; sm_bit_cmh
;         SET  0,d
; mueve_prota_snUP1h
;         ld   bc,LONG_SPRITES
;         add  iy,bc
;         pop  HL
;         INC  HL
;         LD   A,D
;         or   a
;         ret  NZ             ;solo puede haber una colision con malos
;         inc  e
;         ld   a,e
;         CP   5
;         jr   nz,bucle_cmh
;         RET

; ;subrutina para controlar el choque con algún disparo del prota
; choque_disparos_hor
     ;;NC:no hay colision
     ;;C:hay colision
;     ;compruebo choques con demás sprites
;         LD  E,0     ;inicializa bits
;         LD  A,0     ;4 disparos HASTA 3
;         LD  IY,DISPARO2
; bucle_CDH
;         ex   af,af'
;         LD   A,(IY+_SESTADO)
;         OR   A
;         JR   Z,mueve_prota_snUPD3h
;         ld   hl,newx
;         ld   a,(iy+_x)
;         cp   (hl)
;         jr   nz,mueve_prota_snUPD3h
;         CALL rectangles_collide_hor
;         JR   NC,mueve_prota_snUPD3h
;         LD   (IY+_SESTADO),#FE
;         LD   A,(IY+_SID)
;         push bc
;         call Actualiza_Tabla_INT_ibp
;         pop  bc
;         ex   af,af'
;         and  a
;         RLA
;         RLA
;         RLA
;         OR   %11000011
;         ld   (sm_bit_cdh+1),A
;         AND  %00111000
;         rra
;         rra
;         rra
;         ex   af,af'
; sm_bit_cdh
;         SET 0,e
; mueve_prota_snUPD3h
;         ld   bc,LONG_DISPAROS
;         add  iy,bc
;         LD   A,e
;         or   a
;         ret  NZ             ;solo puede haber una colision con malos
;         ex   af,af'
;         inc  a
;         CP   3
;         jr   nz,bucle_CDH
;         RET

choque_propio_disparo
        LD   A,(DISPARO0_ESTADO)
        OR   A
        JR   Z,cpd1
        LD   IY,DISPARO0
        CALL rectangles_collide
        RET  C
cpd1
        LD   A,(DISPARO1_ESTADO)
        OR   A
        JR   Z,cpd2
        LD   IY,DISPARO1
        CALL rectangles_collide
        RET  C
cpd2
        XOR  A
        RET


;hacer bucle de 4
choque_disparos
        XOR A
        LD  HL,Choq_DISP
        LD  (HL),A
        LD  A,(DISPARO2_ESTADO)
        OR  A
        JR  Z,mueve_prota_snUPD3
        LD  IY,DISPARO2
        CALL rectangles_collide
        JR  NC,mueve_prota_snUPD3
        LD  (IY+_SESTADO),#FE
        LD   A,(DISPARO2_ID)
        call Actualiza_Tabla_INT_ibp
        LD  HL,Choq_DISP
        SET 0,(HL)
mueve_prota_snUPD3
        LD  A,(DISPARO3_ESTADO)
        OR  A
        JR  Z,mueve_prota_snUPD4
        LD  IY,DISPARO3
        CALL    rectangles_collide
        JR  NC,mueve_prota_snUPD4
        LD  (IY+_SESTADO),#FE
        LD   A,(DISPARO3_ID)
        call Actualiza_Tabla_INT_ibp
        LD  HL,Choq_DISP
        SET 1,(HL)
mueve_prota_snUPD4
        LD  A,(DISPARO4_ESTADO)
        OR  A
        JR  Z,mueve_prota_snUPD5
        LD  IY,DISPARO4
        CALL    rectangles_collide
        JR  NC,mueve_prota_snUPD5
        LD  (IY+_SESTADO),#FE
        LD   A,(DISPARO4_ID)
        call Actualiza_Tabla_INT_ibp
        LD  HL,Choq_DISP
        SET 2,(HL)
mueve_prota_snUPD5
;         LD  A,(DISPARO5_ESTADO)
;         OR  A
;         JR  Z,sal_snUPD
;         LD  IY,DISPARO5
;         CALL    rectangles_collide
;         JR  NC,sal_snUPD
;         LD  (IY+_SESTADO),#FE
;         LD   A,(DISPARO5_ID)
;         call Actualiza_Tabla_INT_ibp
;         LD  HL,Choq_DISP
;         SET 3,(HL)
sal_snUPD
        LD  HL,Choq_DISP
        LD   A,(HL)
        OR   A
        JR   NZ,setcarry_snd
        XOR  A
        RET
setcarry_snd
        SCF
        RET

Statics_collide
;IX rectangle a
;IY static b
;Retorno C si hay colisión
    LD   A,(IY+S_ID)
    CP   #ff
    RET  Z
    CALL    Lee_Estado_Objeto_A
    CP  0
    RET Z

    LD   A,(IX+_X)
;     SLA  A
;     SLA  A
    LD   B,(IX+_ANCHO)
;     SLA  B
;     SLA  B
    ADD  A,B
    LD   B,A                                ;aRight

    LD   A,(IY+S_X)                 ;bLeft
    SLA  A
    DEC  A  ;amplio zona de choque
    DEC  A

    CP   B
    RET  NC                                 ;bLeft<=aRight

    ;LD   A,(IY+S_X)
    ADD  A,8
    LD   B,A                                ;bRight
    
    LD   A,(IX+_X)                  ;aLeft
;     SLA  A
;     SLA  A
    
    CP   B
    RET   NC                                ;aLeft<=bRight


    LD   A,(IX+_Y)
    LD   B,(IX+_ALTO)
    ADD  A,B
    LD   B,A                                ;aTop
    
    LD   A,(IY+S_Y)                 ;bBottom
    sla  a
    sla  a
    sla  a
    DEC  A
    
    CP   B
    RET  NC                                 ;bTottom<=aTop
    
    ;LD   A,(IY+S_Y)
    ADD  A,16
    LD   B,A                                ;bRight
    
    LD   A,(IX+_Y)                  ;aBottom
    
    CP   B
    RET

