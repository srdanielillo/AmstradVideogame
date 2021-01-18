#pragma once
#include <cpctelera.h>
//TO-DO Crear una función init que asigne la tabla de salto, así toda la responsabilidad de la tabla de salto queda en el sistema de físicas

#define STEPS_PER_JUMP_TABLE  4
#define e_state_not_jumping   0x00

/*JUMP_TABLE VALUES*/
#define e_jump_step_up           0x01
#define e_jump_step_down         0x08
#define e_jump_step_up_right     0x11
#define e_jump_step_down_right   0x18
#define e_jump_step_up_left      0x81
#define e_jump_step_down_left    0x88

u8 jump_table_in_site[STEPS_PER_JUMP_TABLE];// = {e_jump_step_down, e_jump_step_down, e_jump_step_down, e_jump_step_down};

void sys_phyisics_update();

