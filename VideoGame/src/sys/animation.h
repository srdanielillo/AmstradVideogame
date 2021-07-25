#pragma once
#include <cpctelera.h>
#include "man/entity.h"
#include "utils/bit.operators.constants.h"

#define SPRITE_IR0 0
#define SPRITE_IR1 1
#define SPRITE_IL0 2
#define SPRITE_IL1 3
#define SPRITE_R0 4
#define SPRITE_R1 5
#define SPRITE_L0 6
#define SPRITE_L1 7

void sys_animation_init();
void sys_animation_update();