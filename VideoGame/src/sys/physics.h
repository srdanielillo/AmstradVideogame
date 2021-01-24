#pragma once
#include <cpctelera.h>
//TO-DO Crear una función init que asigne la tabla de salto, así toda la responsabilidad de la tabla de salto queda en el sistema de físicas

#define STEPS_PER_JUMP_TABLE  5
#define JUMP_TABLES           3
#define e_state_not_jumping   0x00

/*JUMP_TABLE VALUES                xy   */
#define e_jump_step_up           0x08
#define e_jump_step_down         0x01
#define e_jump_step_up_right     0x18
#define e_jump_step_down_right   0x11
#define e_jump_step_up_left      0x88
#define e_jump_step_down_left    0x81
#define e_no_jump                0x00

#define left_four_bits           0xF0
#define right_four_bits          0x0F

typedef struct jt {
    u8 steps[STEPS_PER_JUMP_TABLE];
    u8 index;    
} JumpTable_t;

void sys_phyisics_init();
void sys_phyisics_update();

