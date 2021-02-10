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


u8 jump_step;


void main(void) {
               
   jump_step = 0x10; // 0001 0000
   i8 y_step = 0x00;
   i8 x_step = 0x00;

   // //Obtener y Negativo
   if(jump_step & 0x80){
      
      y_step = (((jump_step & 0x70) >> 4) ^0xFF)+1;
      
   }
   else{
      y_step = (jump_step & 0xF0) >> 4;
   }
    
                     
      
   

   

   
   while (1);
}
