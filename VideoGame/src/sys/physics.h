#pragma once
#include <cpctelera.h>
//TO-DO Crear una función init que asigne la tabla de salto, así toda la responsabilidad de la tabla de salto queda en el sistema de físicas

#define STEPS_PER_JUMP_TABLE  5
#define JUMP_TABLES           3
#define e_state_not_jumping   0x00

/*JUMP_TABLE VALUES*/
#define js_x_right         0x08
#define js_x_left          -0x08
#define js_y_up            -0x08
#define js_y_down            0x08
#define js_no_movement     0x00

typedef struct js {
    i8 x_step;
    i8 y_step;
} JumpStep_t;

typedef struct jt {
    //TO-DO si la jumptable cambia entre niveles quitarle el const
    const JumpStep_t steps[STEPS_PER_JUMP_TABLE];
    u8 index;    
} JumpTable_t;

void sys_phyisics_init();
void sys_phyisics_update();

