#pragma once
#include <cpctelera.h>
#include "man/shot.h"
#include "man/entity.h"
#include "data/level1/level1.h"
#include "sys/physics.h"
#include "sys/render.h"
#include "sys/input.h"
#include "sys/jump.h"
#include "sys/ai.h"
#include "sys/collision.h"
#include "sys/animation.h"

#define LEVEL_STATE_CONTINUE 0
#define LEVEL_STATE_PLAYER_DEAD 1
#define LEVEL_STATE_FINISHED 10

#define SPRITES_NUMBER 8

void man_level_init();
u8 man_level_level1();
u8 man_level_level2();
u8 man_level_level3();
u8 man_level_level4();
u8 man_level_level5();
u8 man_level_level6();
u8 man_level_level7();
u8 man_level_level8();
u8 man_level_level9();
u8 man_level_level10();