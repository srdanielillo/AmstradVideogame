#pragma once
#include "cpctelera.h"
#include "man/entity.h"

// Number to check if the entity has moved
#define sys_render_moved 0x02

// Number to check if the entity should be rendered this cicle
#define sys_render_should_render 0x01

// Number used to desactivate the render flag so the next cicle the entity wont be rendered
#define sys_render_not_render 0xFE

void sys_render_first_time();
void sys_render_update();
