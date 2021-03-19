#include "man/level.h"

const Entity_t man_level_init_player = {
   e_type_player,                // type
   PLAYER_START_X_LEVEL1,        // x 
   PLAYER_START_Y_LEVEL1,        // y
   0, 0,                         // vx, vy
   PLAYER_START_SPRITE_LEVEL1,   // sprite
   PLAYER_SPRITE_W_LEVEL1,       // sprite_W
   PLAYER_SPRITE_H_LEVEL1,       // sprite_H
   0,                            // prevm
   0,                            // jump_table
   0                             // jump_index
};

const u8 man_level_jtable_site_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_IN_SITE_PLAYER_LEVEL1;
const u8 man_level_jtable_right_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_RIGHT_PLAYER_LEVEL1;
const u8 man_level_jtable_left_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_LEFT_PLAYER_LEVEL1;

u8* man_level_jump_table_ptrs[JUMP_TABLES_NUMBER];

void man_level_load_array_jtable_pointers(){
   man_level_jump_table_ptrs[0] = man_level_jtable_site_p_level1;
   man_level_jump_table_ptrs[1] = man_level_jtable_right_p_level1;
   man_level_jump_table_ptrs[2] = man_level_jtable_left_p_level1; 
}

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
   man_entity_create_player(&man_level_init_player);
   man_level_load_array_jtable_pointers();
   sys_jump_init_player(man_level_jump_table_ptrs);
   man_level_gameLoop();
}


