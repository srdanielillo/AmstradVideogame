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

const Entity_t init_e = {
   e_type_star,   // type
   79, 1,         // x, y
   -1,            // vx
   0xFF           // color
};

void createEntity(){
   Entity_t* e = man_entitiy_create();
   cpct_memcpy (e, &init_e, sizeof(Entity_t));
}

void main(void) {
   cpct_disableFirmware();
   cpct_setVideoMode(0);
   cpct_setBorder(HW_BLACK);
   cpct_setPALColour(0, HW_BLACK);
   
   man_entitiy_init();
   for(u8 i = 5; i > 0 ; --i){
      createEntity();
   }
   sys_phyisics_update();
   sys_render_update();
  
   while(1);
}