#pragma once
#include "cpctelera.h"
#include "man/entity.h"

#define SCR_W 80
#define SCR_H 200

void sys_render_init();
void sys_render_one_entity(Entity_t* e);
void sys_render_update();

