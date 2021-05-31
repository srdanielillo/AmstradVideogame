#pragma once
#include <cpctelera.h>

void sys_phyisics_init();
void sys_phyisics_update();

#define sys_physics_moved 0x02
#define sys_physics_not_moved 0xFD

#define SCR_W 80
#define SCR_H 200

#define sys_physics_check_negative 0xF0