//TO-DO diferenciar entidad jugador del resto de entidades
#pragma once
#include "cpctelera.h"
#include "sprites/agent.h"

#define e_type_invalid  0x00
#define e_type_star     0x01
#define e_type_player   0x02
#define e_type_dead     0x80
#define e_type_default  0x7F

#define MAX_ENTITIES_NON_PLAYER 2

#define STEPS_PER_JUMP_TABLE  4
#define e_state_not_jumping   0x00

/*JUMP_TABLES*/
#define e_jump_step_up           0x01
#define e_jump_step_down         0x08
#define e_jump_step_up_right     0x11
#define e_jump_step_down_right   0x18
#define e_jump_step_up_left      0x81
#define e_jump_step_down_left    0x88

//TO_DO MOVER A SISTEMA DE FISICAS
u8 jump_table_in_site[STEPS_PER_JUMP_TABLE] = {e_jump_step_down, e_jump_step_down, e_jump_step_down, e_jump_step_down};

#define SCR_W  80
#define SCR_H  200

typedef struct te {
   u8    type;
   u8    x, y;
   i8    vx;
   u8*   sprite;
   u8    sprite_W, sprite_H;
   u8*   prevptr;
   u8    jump_table_index;
   u8*   jump_table;
} Entity_t;

void man_entitiy_init();
void man_entity_create_player();

Entity_t* man_entitiy_create();
void man_entity_set4destruction(Entity_t* dead_e);

void man_entity_forall( void (*ptrfunc)(Entity_t*) );
void man_entity_forplayer( void (*ptrfunc)(Entity_t*) ); 

u8 man_entity_freeSpace();

void man_entity_update();  

