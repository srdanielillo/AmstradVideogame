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
#include "man/entity.h"
#include "sys/physics.h"
#include "sys/render.h"
#include "sys/generator.h"
#include "sys/input.h"

void main(void) {
   cpct_disableFirmware();
  
   man_entitiy_init();
   man_entity_create_player();
   sys_render_init();
   while(1){
      sys_input_update();
      sys_phyisics_update();
      sys_generator_update();
      sys_render_update();
      man_entity_update();
      cpct_waitVSYNC();
   }
}
