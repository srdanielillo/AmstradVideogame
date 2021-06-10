#pragma once
#include "cpctelera.h"

#define e_type_invalid 0x00
#define e_type_player 0x02
#define e_type_enemy 0x03
#define e_type_shot 0x04
#define e_type_default 0x7F
#define e_type_dead 0x80

#define MAX_ENTITIES_NON_PLAYER 10

#define RIGHT_DIRECTION 1
#define LEFT_DIRECTION 2

// 15
typedef struct te
{
   u8 type;
   u8 x, y;
   i8 vx, vy;
   u8 sprite_W, sprite_H;
   u8 *sprite;
   u8 *prevptr;
   u8 jump_info;
   /*
         7  6  5  4  3    [1]        [0]
                          Has_moved  Should_render
   */
   u8 messages_re_ph;
   u8 patrol_info;
   u8 direction;
} Entity_t;

void man_entitiy_init();
void man_entity_create_player(Entity_t *init_player_ptr);

Entity_t *man_entitiy_create();
void man_entity_populate_entity_data(Entity_t *e);
void man_entity_set4destruction(Entity_t *dead_e);

void man_entity_for_all(void (*ptrfunc)(Entity_t *));
void man_entity_for_entities(void (*ptrfunc)(Entity_t *));
void man_entity_for_player(void (*ptrfunc)(Entity_t *));

u8 man_entity_freeSpace();

void man_entity_update();
