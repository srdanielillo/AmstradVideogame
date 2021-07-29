#pragma once
#include <cpctelera.h>
#include <sprites/bullet.h>
#include <sprites/player.h>
#include <sprites/enemy1.h>
#include <sprites/enemy2.h>
#include <sprites/enemy3.h>
#include <map/tiles_level1.h>
#include <map/intermediate_screen.h>
#include <map/bg_level1.h>
#include <map/bg_level2.h>
#include <map/bg_level3.h>
#include <map/bg_level4.h>
#include <map/bg_level5.h>
#include <map/bg_level6.h>
#include <map/bg_level7.h>
#include <map/bg_level8.h>
#include <map/bg_level9.h>
#include <map/bg_level10.h>

#define PALETTE_LEVEL1 player_pal

#define PLAYER_START_X_LEVEL1 4
#define PLAYER_START_Y_LEVEL1 15
#define PLAYER_START_SPRITE_LEVEL1 player_sp_0
#define ENEMY1_START_SPRITE_LEVEL1 enemy1_sp_1
#define PLAYER_SPRITE_W_LEVEL1 4
#define PLAYER_SPRITE_H_LEVEL1 16

#define BULLET_SPRITE_LEVEL1 bullet_sp_0

#define JUMP_TABLE_IN_SITE_PLAYER_LEVEL1                                                                                                                                                                                                               \
    {                                                                                                                                                                                                                                                  \
        {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, -1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, {0, 1}, { 0, 1 } \
    }

#define JUMP_TABLE_RIGHT_PLAYER_LEVEL1                                                                                                                                                                                                                 \
    {                                                                                                                                                                                                                                                  \
        {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, -1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, {1, 1}, { 1, 1 } \
    }

#define JUMP_TABLE_LEFT_PLAYER_LEVEL1                                                                                                                                                                                                                                              \
    {                                                                                                                                                                                                                                                                              \
        {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, -1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, {-1, 1}, { -1, 1 } \
    }