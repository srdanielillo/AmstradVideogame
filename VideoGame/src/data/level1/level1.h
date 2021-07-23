#pragma once
#include <cpctelera.h>
#include <sprites/agent.h>
#include <sprites/bullet.h>
#include <map/tiles_level1.h>
#include <map/bg_level1.h>

#define PALETTE_LEVEL1 agent_pal

#define PLAYER_START_X_LEVEL1 4
#define PLAYER_START_Y_LEVEL1 176
#define PLAYER_START_SPRITE_LEVEL1 agent_sp_0
#define PLAYER_NEXT_SPRITE_LEVEL1 agent_sp_1
#define PLAYER_SPRITE_W_LEVEL1 8
#define PLAYER_SPRITE_H_LEVEL1 16

#define BULLET_SPRITE_LEVEL1 bullet_sp_0

#define JUMP_TABLE_IN_SITE_PLAYER_LEVEL1                                                                                        \
    {                                                                                                                           \
        {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, { 0, 1 } \
    }

#define JUMP_TABLE_RIGHT_PLAYER_LEVEL1                                                                                          \
    {                                                                                                                           \
        {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, { 1, 1 } \
    }

#define JUMP_TABLE_LEFT_PLAYER_LEVEL1                                                                                                         \
    {                                                                                                                                         \
        {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, { -1, 1 } \
    }