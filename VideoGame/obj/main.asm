;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.8 #9946 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _wait
	.globl _sys_generator_update
	.globl _sys_render_update
	.globl _sys_render_init
	.globl _sys_phyisics_update
	.globl _man_entity_update
	.globl _man_entitiy_init
	.globl _cpct_waitVSYNC
	.globl _cpct_waitHalts
	.globl _cpct_disableFirmware
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:27: void wait(u8 n){
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
;src/main.c:28: do{
	ld	hl, #2+0
	add	hl, sp
	ld	c, (hl)
00101$:
;src/main.c:29: cpct_waitHalts(2);
	push	bc
	ld	l, #0x02
	call	_cpct_waitHalts
	call	_cpct_waitVSYNC
	pop	bc
;src/main.c:31: } while(--n);
	dec c
	jr	NZ,00101$
	ret
;src/main.c:34: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:35: cpct_disableFirmware();
	call	_cpct_disableFirmware
;src/main.c:37: man_entitiy_init();
	call	_man_entitiy_init
;src/main.c:38: sys_render_init();
	call	_sys_render_init
;src/main.c:39: while(1){
00102$:
;src/main.c:40: sys_phyisics_update();
	call	_sys_phyisics_update
;src/main.c:41: sys_generator_update();
	call	_sys_generator_update
;src/main.c:42: sys_render_update();
	call	_sys_render_update
;src/main.c:44: man_entity_update();
	call	_man_entity_update
;src/main.c:45: cpct_waitVSYNC();
	call	_cpct_waitVSYNC
	jr	00102$
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
