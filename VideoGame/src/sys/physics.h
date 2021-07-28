#pragma once
#include <cpctelera.h>
#include "man/entity.h"
#include "map/bg_level1.h"
#include "map/bg_level2.h"
#include "utils/bit.operators.constants.h"

void sys_phyisics_init();
void sys_phyisics_update();

void sys_phyisics_set_tilemap(u8 *tilemap);
u8 sys_physics_door_collision();

#define SCR_W 80
#define SCR_H 200
