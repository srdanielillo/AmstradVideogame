#pragma once
#include <cpctelera.h>
#include "man/entity.h"

typedef struct tpt {
    u8 x;
    u8 y;
} Patrol_step_t;

#define STEPS_PER_PATROL_TABLE 4
#define PATROL_TABLES_NUMBER 2
 
void sys_ai_init_patrol_tables(Patrol_step_t *ptr);
void sys_ai_update();