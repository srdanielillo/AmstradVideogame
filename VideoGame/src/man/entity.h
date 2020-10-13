#pragma once
#include "cpctelera.h"

typedef struct te {
   u8 tipo;
   u8 x, y;
   i8 vx;
   u8 color;
} Entity_t;

void man_entitiy_init();
Entity_t* man_entitiy_create();