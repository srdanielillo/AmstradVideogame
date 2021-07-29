//-----------------------------LICENSE NOTICE------------------------------------
//  This file is part of CPCtelera: An Amstrad CPC Game Engine
//  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//------------------------------------------------------------------------------

#include <cpctelera.h>
#include "man/level.h"

#define TILEMAP_VMEM cpctm_screenPtr(CPCT_VMEM_START, 0, 0)

void load_intermediate_screen()
{
   // Draw map
   cpct_etm_setDrawTilemap4x8_ag(intermediate_screen_W, intermediate_screen_H, intermediate_screen_W, g_tiles_level1_00);
   cpct_etm_drawTilemap4x8_ag(TILEMAP_VMEM, intermediate_screen);
   while (1)
   {
      cpct_scanKeyboard_f();
      if (cpct_isAnyKeyPressed_f())
      {
         break;
      }
   }
}

void main(void)
{
   u8 level_state = LEVEL_STATE_CONTINUE;
   man_level_init();

   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level5();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level2();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level3();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level4();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level5();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level6();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level7();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level8();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level9();
   }

   level_state = LEVEL_STATE_CONTINUE;
   load_intermediate_screen();
   while (level_state != LEVEL_STATE_FINISHED)
   {
      load_intermediate_screen();
      level_state = man_level_level10();
   }
}
