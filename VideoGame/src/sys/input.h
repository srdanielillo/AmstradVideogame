#pragma once
#include <cpctelera.h>
#include "man/entity.h"
#include "man/shot.h"
#include "sys/jump.h"

#define CYCLES_TO_RESET_SHOT 10

void sys_input_init();
void sys_input_update();