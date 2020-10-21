#pragma once
#include "cpctelera.h"

#define e_type_invalid  0x00
#define e_type_star     0x01
#define e_type_dead     0x80
#define e_type_default  0x7F

typedef struct te {
   u8 type;
   u8 x, y;
   i8 vx;
   u8 color;
} Entity_t;


void man_entitiy_init();
Entity_t* man_entitiy_create();
void man_entity_destroy(Entity_t* dead_e);
void man_entity_forall( void (*ptrfunc)(Entity_t*) ); 