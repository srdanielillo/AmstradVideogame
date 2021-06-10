#pragma once
#include <cpctelera.h>
#include "man/entity.h"
#include "man/shot.h"

#define CYCLES_TO_RESET_SHOT 5

#define jump_table_in_site 0x00
#define jump_table_right 0x10
#define jump_table_left 0x20

void sys_input_init();
void sys_input_update();