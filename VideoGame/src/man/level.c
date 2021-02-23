#include "man/level.h"

const Entity_t init_player = {
   e_type_player,                // type
   PLAYER_START_X_LEVEL1,        // x 
   PLAYER_START_Y_LEVEL1,        // y
   0, 0,                         // vx, vy
   PLAYER_START_SPRITE_LEVEL1,   // sprite
   PLAYER_SPRITE_W_LEVEL1,       // sprite_W
   PLAYER_SPRITE_H_LEVEL1,       // sprite_H
   0,                            // prevm
   0                             // jumping
};

void man_level_gameLoop(){
   //TO-DO Comprobar condición de cambio de nivel (Puntuación enemigos...) 
   while(1){
      sys_input_update();
      sys_jump_update();
      sys_phyisics_update();
      sys_render_update();
      man_entity_update();
      cpct_waitVSYNC();
   }
}

void man_level_level1(){
   man_entitiy_init();
   sys_render_init_palette(PALETTE_LEVEL1);
   man_entity_create_player(&init_player);
   sys_jump_init();
   man_level_gameLoop();
}

