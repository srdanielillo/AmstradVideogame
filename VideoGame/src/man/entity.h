#pragma once
#include "cpctelera.h"

#define e_type_invalid  0x00
#define e_type_player   0x02
#define e_type_default  0x7F
#define e_type_dead     0x80

#define MAX_ENTITIES_NON_PLAYER 2

typedef struct te {
   u8    type;
   u8    x, y;
   i8    vx, vy;
   u8*   sprite;
   u8    sprite_W, sprite_H;
   u8*   prevptr;
   u8    jump_table;
   u8    jump_index;
} Entity_t;

void man_entitiy_init();
void man_entity_create_player(Entity_t* init_player_ptr);

Entity_t* man_entitiy_create();
void man_entity_set4destruction(Entity_t* dead_e);

void man_entity_forall( void (*ptrfunc)(Entity_t*) );
void man_entity_forplayer( void (*ptrfunc)(Entity_t*) ); 

u8 man_entity_freeSpace();

void man_entity_update();  

