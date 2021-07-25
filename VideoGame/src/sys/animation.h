#pragma once
#include <cpctelera.h>
#include "man/entity.h"
#include "utils/bit.operators.constants.h"

#define SPRITE_I0 0
#define SPRITE_I1 1
#define SPRITE_R0 2
#define SPRITE_R1 3
#define SPRITE_L0 4
#define SPRITE_L1 5

void sys_animation_init();
void sys_animation_update();