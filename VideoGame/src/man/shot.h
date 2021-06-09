#pragma once
#include <cpctelera.h>
#include "man/entity.h"

typedef struct sd
{
    u8 type;
    u8 x, y;
    u8 vx, vy;
    u8 direction;
} Shot_data_t;

void man_shot_init(Entity_t *initializer);
void man_shot_create_shot(Shot_data_t *shot_info);