#pragma once
#include <cpctelera.h>
#include "man/entity.h"
#include "utils/bit.operators.constants.h"

void sys_render_first_time();
void sys_render_update();
void sys_render_last_time(Entity_t *e);