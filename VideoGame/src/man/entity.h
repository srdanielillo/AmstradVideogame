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

typedef struct js
{
      i8 x;
      i8 y;

} Jump_step_t;

// 15
typedef struct te
{
      u8 type;
      u8 x, y;
      i8 vx, vy;
      u8 sprite_W, sprite_H;
      u8 *sprite;
      u8 *prevptr;
      Jump_step_t *jump_table;
      u8 jump_step;
      /*
         [7]                 6  5  4  3    [1]        [0]
         Render_first_time                 Has_moved  Should_render
   */
      u8 messages_re_ph;
      u8 patrol_info;
      u8 direction;
      u8 **sprites_array;
      u8 last_direction;
      u8 animation_counter;
      u8 *prevsprite;
} Entity_t;

void man_entitiy_init();
void man_entity_create_player(Entity_t *init_player_ptr);

Entity_t *man_entitiy_create();
void man_entity_populate_entity_data(Entity_t *e);
void man_entity_set4destruction(Entity_t *dead_e);

void man_entity_for_all(void (*ptrfunc)(Entity_t *));
void man_entity_for_entities(void (*ptrfunc)(Entity_t *));
void man_entity_for_player(void (*ptrfunc)(Entity_t *));

void man_entity_one_against_others(void (*ptrfunc)(Entity_t *, Entity_t *));
void man_entity_player_against_others(void (*ptrfunc)(Entity_t *, Entity_t *));

u8 man_entity_freeSpace();
u8 man_entity_player_dead();
u8 man_entity_enemies_left();

void man_entity_update();
