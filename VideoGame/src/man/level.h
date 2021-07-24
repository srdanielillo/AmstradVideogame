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

#define LEVEL_STATE_CONTINUE 0
#define LEVEL_STATE_PLAYER_DEAD 1
#define LEVEL_STATE_FINISHED 10

void man_level_init();
u8 man_level_level1();