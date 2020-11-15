#pragma once
#include "cpctelera.h"
#include "sprites/agent.h"

#define e_type_invalid  0x00
#define e_type_star     0x01
#define e_type_dead     0x80
#define e_type_default  0x7F

#define e_type_player   0x02

#define MAX_ENTITIES 50

typedef struct te {
   u8    type;
   i8    x, y;
   i8    vx;
   u8*   sprite;
   u8    sprite_W, sprite_H;
   u8*   prevptr;
} Entity_t;


void man_entitiy_init();
void man_entity_create_player();
Entity_t* man_entitiy_create();
Entity_t* man_entity_get_player();
void man_entity_destroy(Entity_t* dead_e);
void man_entity_forall( void (*ptrfunc)(Entity_t*) );
void man_entity_set4destruction(Entity_t* dead_e);
void man_entity_update();  
u8 man_entity_freeSpace();
