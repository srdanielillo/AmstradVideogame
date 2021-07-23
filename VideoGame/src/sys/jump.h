#pragma once
#include <cpctelera.h>
#include "man/entity.h"

#define STEPS_PER_JUMP_TABLE 14
#define JUMP_TABLES_NUMBER 3

typedef struct js
{
    i8 x;
    i8 y;

} Jump_step_t;

void sys_jump_init_jump_tables(Jump_step_t *ptr);
void sys_jump_update();
