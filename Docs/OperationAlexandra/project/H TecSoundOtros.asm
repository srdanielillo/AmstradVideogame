;;----------------------------------------------
;;Read_Keys
;;Lee el estado del teclado, devolviéndolo en DE
;;----------------------------------------------
;;Cambia_Tintas_Juego
;;Pone el borde y las tintas del juego
;;Las coge de HL
;;----------------------------------------------
;;Cambia_Tintas_Marcador        
;;Pone las tintas del marcador (el borde NO)
;;Las coge de HL
;;----------------------------------------------

;;
;;Lee el estado del teclado, devolviéndolo en DE
;;
;;ENTRADA
;;nada
;;SALIDA
;;DE con las teclas pulsadas
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
;;destruye BC,A
;;
Read_Keys
        LD      BC,PPI_A + PSG_REG_0E          	; (3) Registro
        OUT     (C),C                          	; (4)
        LD      BC,PPI_C + PPI_PSG_SELECT      	; (3)
        OUT     (C),C                          	; (4)

        DEFB    #ED,#71                        	; (4) PSG Inactivo (CPC+) / OUT (C),0
 
        LD      BC,PPI_CONTROL + %10010010     	; (3) Valor
        OUT     (C),C                         	; (4)
 
        LD      A,%01001001            		; 5є Lнnea de la matriz del teclado a comprobar (bits 3-0 del PPI Port C)
        DEC     B                      
        OUT     (C),A                  		; 6є Operaciуn- Leer registro del PSG
    
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						;7є Leemos la linea de la matriz del teclado desde el PPI Port A
    
        ;XOR     A
        LD      D,0
        ;LD      E,A

        ; Comprobamos la línea 9
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE9
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
test_joy0_up
        RRA
        JR      C,test_joy0_down
        SET     JOY_UP,D
test_joy0_down
        RRA
        JR      C,test_joy0_left
        SET     JOY_DOWN,D
test_joy0_left
        RRA
        JR      C,test_joy0_right
        SET     JOY_LEFT,D
test_joy0_right
        RRA
        JR      C,test_joy0_fire2
        SET     JOY_RIGHT,D
test_joy0_fire2
        RRA
        JR      C,test_joy0_fire1
        SET     JOY_UP,D
test_joy0_fire1
        RRA
        JR      C,test_keyboard
        SET     JOY_FIRE1,D
test_keyboard

        ; Comprobamos la línea 0
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE0
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
        					; A contiene el valor de la lнnea
test_cursor_up
        RRA
        JR      C,test_cursor_right
        SET     JOY_UP,D
test_cursor_right
        RRA
        JR      C,test_cursor_down
        SET     JOY_RIGHT,D
test_cursor_down
        RRA
        JR      C,test_f6
        SET     JOY_DOWN,D
test_f6
;         RRA
;         RRA
;         JR      C,test_cursor_left_and_copy
;         SET     KEY_F6,E    

        ; Comprobamos la linea 1
test_cursor_left_and_copy
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE1
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                  ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
                                                ; A contiene el valor de la lнnea
test_cursor_left
        RRA
        JR      C,test_copy
        SET     JOY_LEFT,D
test_copy
;         RRA
;         JR      C,test_F8
;         SET     JOY_FIRE1,D
; test_F8
;         RRA
;         RRA
;         JR      C,test_F2
;         SET     KEY_F8,E
; test_F2
;         RRA
;         RRA
;         RRA
;         JR      C,test_F4d
;         SET     KEY_F2,D

        ; Comprobamos la línea 2
test_F4d
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE2
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
	               				; A contiene el valor de la lнnea
test_enter
;         RRA
;         RRA
;         RRA
;         ;JR      C,test_f4
;         ;SET     KEY_ENTER,E
; test_f4
;         RRA
;         RRA
        RLA
        RLA
        RLA
        JR      C,test_f4
        SET     JOY_FIRE1,D
test_f4
;         RLA
;         JR      C,test_5
;         SET     KEY_F4,E

        ; Comprobamos la línea 6
; test_5
;         LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE6
;         OUT     (C),C                  
;         LD      B,#F4				;>PPI_A                   ; (2)
;         IN      A,(C)                          	; (4) Leemos el registro del PSG
; 						; A contiene el valor de la lнnea
;         RRA
;         RRA
;         JR      C,test_p
;         SET     KEY_5,E

        ; Comprobamos la línea 3
test_p
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE3
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RRA
        RRA
        RRA
        RRA
        JR      C,test_o
        SET     JOY_RIGHT,D

        ; Comprobamos la línea 4
test_o
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE4
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   ; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RRA
        RRA
        RRA
        JR      C,test_x
        SET     JOY_LEFT,D

        ; Comprobamos la línea 7
test_x
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE7
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A          			; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
        RLA
        JR      C,test_4
        SET     JOY_UP,D
test_4
;         RRA
;         RRA
;         JR      C,test_3
;         SET     KEY_4,E
; test_3
;         RRA
;         JR      C,test_space
;         SET     KEY_3,E
    
        ; Comprobamos la línea 5
test_space
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE5
        OUT     (C),C                  
        LD      B,#F4               ;>PPI_A                   ; (2)
        IN      A,(C)                           ; (4) Leemos el registro del PSG
                        ; A contiene el valor de la lнnea
        RLA
        JR      C,test_8
        SET     JOY_FIRE1,D

        ; Comprobamos la línea 8
test_8
        LD      BC,PPI_C + PPI_PSG_READ + KEY_LINE8
        OUT     (C),C                  
        LD      B,#F4				;>PPI_A                   	; (2)
        IN      A,(C)                          	; (4) Leemos el registro del PSG
						; A contiene el valor de la lнnea
  	RRA										;1
;         JR      C,test_2
;         SET     KEY_1,E
; test_2
  	RRA										;2
;         JR      C,test_esc
;         SET     KEY_2,E
; test_esc
  	RRA										;ESC
  	JR      C,test_q
  	SET     KEY_ESCAPE,D
test_q
  	RRA										;Q
  	JR      C,test_a
  	SET     JOY_UP,D
test_a
    RRA                                                                             ;Tab
  	RRA										;A
  	JR      C,test_z
  	SET     JOY_DOWN,D
test_z
    RRA
    RRA
    JR      C,fin_lee_teclado
    SET     JOY_FIRE1,D

fin_lee_teclado
        LD      BC,PPI_CONTROL + %10000010     	; (3) Valor
        OUT     (C),C                          	; (4)
        DEC     B                             	; (1) PPI_CONTROL - 1 => PPI_C
        DEFB    #ED,#71                       	; (4) PSG Inactivo (CPC+) / OUT (C),0
											; 9є y 10є (Destruye BC)
        bit   JOY_UP,D
        ret   z
        bit   JOY_DOWN,D
        ret   z
        res   JOY_DOWN,D
        RET

;;
;;Pone el borde y las tintas del juego
;;Las coge de HL
;;
;;ENTRADA
;;HL: border, tintas del juego (según modo)
;;DE: inicio de zona de tintas
;;SALIDA
;;Nada
;;destruye BC,DE,A
;;
Cambia_Tintas_Zona
        PUSH    HL
        ;primera tinta es el border
        INC     DE
        LDI

        ;siguiente tintas según modo
        EX      DE,HL
        LD      BC,9
        ADD     HL,BC
        EX      DE,HL
        LD      A,NUMERO_DE_TINTAS
siguiente_tinta_CTJ
        LDI
        EX      HL,DE
        LD      BC,6
        ADD     HL,BC
        EX      HL,DE
        DEC     A
        JR      NZ,siguiente_tinta_CTJ
        POP     HL
        RET

Cambia_Tintas_Todas
        CALL    Cambia_Tintas_Juego
        JR      Cambia_Tintas_Marcador

Cambia_Tintas_Juego
        LD      DE,sm_border2
        CALL    Cambia_Tintas_Zona
        LD      DE,sm_border3
        CALL    Cambia_Tintas_Zona
        LD      DE,sm_border4
        JR      Cambia_Tintas_Zona

Cambia_Tintas_Marcador
        LD      DE,sm_borderm
        JR      Cambia_Tintas_Zona

;         LD      B,NUMERO_DE_TINTAS
;         XOR     A
;         LD      DE,sm_tinta0_m+1
;         INC     HL  ;salto el border
; siguiente_tinta1_CTJ
;         PUSH    BC
;         LDI
;         EX      HL,DE
;         LD      BC,7
;         ADD     HL,BC
;         POP     BC
;         EX      HL,DE
;         DJNZ    siguiente_tinta1_CTJ

;         RET
        
; Alterna_Musica
;         LD      B,10
;         CALL    muchisimo_STEC
;         LD      DE,SNG_FX
;         CALL    PLY_SFX_Init
;         LD      A,(Hay_Musica)
;         XOR     #FF
;         LD      (Hay_Musica),A
;         OR      A
;         JR      NZ,menu_AM
;         LD      DE,SNG_FX
;         JR      sigue_AM
; menu_AM
;         LD      DE,SNG_MENU
; sigue_AM
;         JP      PLY_Init

;;
;;Pone las tintas del marcador (el borde NO)
;;Las coge de HL
;;
;;ENTRADA
;;L-FX nº
;;E-Nota
;;SALIDA
;;Nada
;;destruye HL,BC,D,A,A'
;;
;A = No Channel (0,1,2)
;L = SFX Number (>0)
;H = Volume (0...F)
;E = Note (0...143)
;D = Speed (0 = As original, 1...255 = new Speed (1 is fastest))
;BC = Inverted Pitch (-#FFFF -> FFFF). 0 is no pitch. The higher the pitch, the lower the sound.
Toca_FX_Pos
        LD      HL,SONIDOS
        LD      B,0
        LD      C,A
        SLA     C
        ADD     HL,BC
        LD      E,(HL)
        INC     HL
        LD      A,(HL)
        RLCA
        RLCA
        AND     %00000011
        LD      L,(HL)
        RES     7,L
        RES     6,L
Toca_FX_Alea
        LD      H,#F
        LD      D,0
        LD      BC,0
        PUSH    IX
        CALL    PLY_SFX_Play 
        POP     IX
        RET

; Espera el vertical blank -----------------

; completo
.wVb
    call    wVb1

    ; normal

.wVb2
    ld     b,#f5
.vbLoop2
    IN     A,(C)
        RRA
        JR     NC,vbLoop2
    ret

    ; inicial
.wVb1
    ld     b,#f5
.vbLoop1
    IN     A,(C)
        RRA
        JR     C,vbLoop1
    ret

Random
   ;; INPUT:
   ;;  DE:HL == xz yw  (32 bits state)
   ;;  xz yw -> yw zt ==> x'z' = yw, y' = z, w' = t
   ;;  
   ;; OUTPUT:
   ;;  DE:HL == x'z' y'w' (new 32 bits state, L = w' = 8 random bits generated) 

   ;; Move old bytes of the state. DE:HL is now xz yw
   ;; Interchanging it makes DE:HL be yw xz, leaving x' and z' in DE 
   ld  hl,(seed1)
   ld  de,(seed2)
   ex  de, hl  ;; [1]  x' = y, z' = w
 
   ;; Calculate t = x ^ (x << 3)
   ld   a, h   ;; [1] A = x
   add  a      ;; [1]
   add  a      ;; [1]
   add  a      ;; [1] A = (x << 3)
   xor  h      ;; [1] A = t = x ^ (x << 3)
   ld   h, a   ;; [1] H = t
   
   ;; Calculate t = t ^ (t >> 1)
   rra         ;; [1] A = (t >> 1)  (A already contained t)
   xor  h      ;; [1] A = t' = t ^ (t >> 1)

   ;; Calculate w' = w ^ (w << 1) ^ t'
   ld   h, a   ;; [1] H = t'
   ld   a, e   ;; [1] A = w
   add  a      ;; [1] A = (w << 1)
   xor  e      ;; [1] A = w ^ (w << 1)
   xor  h      ;; [1] A = w' = w ^ (w << 1) ^ t'

   ;; Store y' and w' and return
   ld   h, l   ;; [1] H = y' = z
   ld   l, a   ;; [1] L = w'

   ld  (seed1),hl
   ld  (seed2),de
   ret         ;; [3] New state is returned in DE:HL, being L the 8 random bits generated

Random_B_C
    call Random
    cp   b
    jr   c,Random_B_C
    cp   c
    jr   nc,Random_B_C
    ret


;The following routine divides bc by de and places the quotient in bc and the remainder in hl
; Cociente queda en BC, se puede hacer ld b,a para que quede en BC
; Resto queda en HL (realmente en L, ya que H siempre serб cero) 
div_bc_de:
    LD   HL,0
    LD   A,B                                    ; dividendo es ac en lugar de bc para optimizar cуdigo y liberar b como contador
    LD   B,16
    defb #cb,#31;SLL  C esta instrucciуn es indocumentada, algunos ensambladores no la reconocen, se puede sustituir por defb #cb,#31
    RLA
    ADC  HL,HL
    SBC  HL,DE
    JR   NC,$+4
    ADD  HL,DE
    DEC  C
    DJNZ $-11
    LD   B,A
    RET

espera_fs
    LD      A,(Pas_Interrupcion)
    ADD     B
    LD      B,A
espera_efs
    ld a,(semaforo_ia_prota)
    cp  1
    jr  nz,sig_efs
    push bc
    ld ix,sprite0
    call explota_morir
    pop bc
sig_efs
    LD      A,(Pas_Interrupcion)    
    CP      B
    JR      NZ,espera_efs
    RET


TINTAS_FLASH
  DB  #54
  DB  #4a,#44,#55,#57,#5d,#5f,#5e,#4e,#5e,#5e,#5f,#47,#4a,#4a,#4b,#4b


DSPR_PULPO_ABA          DW PULPO_ABA,PULPO_ABA+64,PULPO_ABA+128,PULPO_ABA+192,PULPO_ABA+192+64,PULPO_ABA+192+128,PULPO_ABA+192+192  ;7
DSPR_ALMEJA_CERRAR      DW ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA,ALMEJA+64,ALMEJA+128,ALMEJA+128,ALMEJA+192,ALMEJA+192  ;16
