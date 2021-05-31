#pragma once
#include <cpctelera.h>
#include <sprites/agent.h>

#define PALETTE_LEVEL1 agent_pal

#define PLAYER_START_X_LEVEL1 70
#define PLAYER_START_Y_LEVEL1 184
#define PLAYER_START_SPRITE_LEVEL1 agent_sp_0
#define PLAYER_NEXT_SPRITE_LEVEL1 agent_sp_1
#define PLAYER_SPRITE_W_LEVEL1 8
#define PLAYER_SPRITE_H_LEVEL1 16

#define JUMP_TABLE_IN_SITE_PLAYER_LEVEL1 \
    {                                    \
        js_up, js_up, js_down, js_down   \
    }
#define JUMP_TABLE_RIGHT_PLAYER_LEVEL1                         \
    {                                                          \
        js_up_right, js_up_right, js_down_right, js_down_right \
    }
#define JUMP_TABLE_LEFT_PLAYER_LEVEL1                      \
    {                                                      \
        js_up_left, js_up_left, js_down_left, js_down_left \
    }