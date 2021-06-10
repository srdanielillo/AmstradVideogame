#pragma once
#include <cpctelera.h>
#include "man/entity.h"

#define RIGHT_SHOT_VELOCITY 0x02
#define LEFT_SHOT_VELOCITY -2

typedef struct sd
{
    u8 x, y;
    u8 direction;
} Shot_data_t;

void man_shot_init(Entity_t *initializer);
void man_shot_create_shot(Shot_data_t *shot_info);