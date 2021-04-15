#pragma once
#include <cpctelera.h>

void sys_phyisics_init();
void sys_phyisics_update();

#define sys_physics_active_movement 0x01
#define sys_phyisics_move_sentinel  0x04

#define SCR_W 80
#define SCR_H 200

#define sys_physics_check_negative 0xF0