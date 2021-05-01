#include "man/level.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
   In this module the use of const word might not be strict
   At each level start the values of the container maybe would change
*/



/*
   [INFO] Container to copy the player data on each level
*/
const Entity_t man_level_init_player = {
   e_type_player,                // type
   PLAYER_START_X_LEVEL1,        // x 
   PLAYER_START_Y_LEVEL1,        // y
   0, 0,                         // vx, vy
   PLAYER_SPRITE_W_LEVEL1,       // sprite_W
   PLAYER_SPRITE_H_LEVEL1,       // sprite_H
   PLAYER_START_SPRITE_LEVEL1,   // sprite
   0,                            // ptr
   0,                            // prevptr
   0,                            // jump_table
   0,                            // jump_index
   0x02,                         // messages_re_ph
   0x00                          // patrol_info
};

/*
   [INFO] Container to copy the enemies data on each level
*/
const Entity_t man_level_init_enemy = {
   e_type_enemy,                 // type
   0,                           // x 
   50,                           // y
   0, 0,                         // vx, vy
   PLAYER_SPRITE_W_LEVEL1,       // sprite_W
   PLAYER_SPRITE_H_LEVEL1,       // sprite_H
   PLAYER_START_SPRITE_LEVEL1,   // sprite
   0,                            // ptr
   0,                            // prevptr
   0,                            // jump_table
   0,                            // jump_index
   0x06,                         // messages_re_ph
   0x00                          // patrol_info
};

// const Entity_t man_level_init_enemy_2 = {
//    e_type_enemy,                 // type
//    60,                           // x 
//    32,                           // y
//    0, 0,                         // vx, vy
//    PLAYER_SPRITE_W_LEVEL1,       // sprite_W
//    PLAYER_SPRITE_H_LEVEL1,       // sprite_H
//    PLAYER_START_SPRITE_LEVEL1,   // sprite
//    0,                            // ptr
//    0,                            // prevptr
//    0,                            // jump_table
//    0,                            // jump_index
//    0x02                          // messages_re_ph
// };

// const Entity_t man_level_init_enemy_3 = {
//    e_type_enemy,                 // type
//    45,                           // x 
//    80,                           // y
//    0, 0,                         // vx, vy
//    PLAYER_SPRITE_W_LEVEL1,       // sprite_W
//    PLAYER_SPRITE_H_LEVEL1,       // sprite_H
//    PLAYER_START_SPRITE_LEVEL1,   // sprite
//    0,                            // ptr
//    0,                            // prevptr
//    0,                            // jump_table
//    0,                            // jump_index
//    0x02                          // messages_re_ph
// };

// const Entity_t man_level_init_enemy_4 = {
//    e_type_enemy,                 // type
//    22,                           // x 
//    100,                           // y
//    0, 0,                         // vx, vy
//    PLAYER_SPRITE_W_LEVEL1,       // sprite_W
//    PLAYER_SPRITE_H_LEVEL1,       // sprite_H
//    PLAYER_START_SPRITE_LEVEL1,   // sprite
//    0,                            // ptr
//    0,                            // prevptr
//    0,                            // jump_table
//    0,                            // jump_index
//    0x02                          // messages_re_ph
// };


/*
   [INFO] Container to store the jump tables of the player
          The jump system points to these containers
          The sys_jump_init_player should only be called once.
          This is beacuse the values that these system points are here and are managed by this system   
*/
const u8 man_level_jtable_site_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_IN_SITE_PLAYER_LEVEL1;
const u8 man_level_jtable_right_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_RIGHT_PLAYER_LEVEL1;
const u8 man_level_jtable_left_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_LEFT_PLAYER_LEVEL1;

/*
   [INFO] Containers to store the patrol tables

*/
//TODO Poner nombre consistente
const Patrol_step_t man_level_patrol_table_1[STEPS_PER_PATROL_TABLE] = {{30, 50}, {60, 50}, {30, 50}, {0, 50}};
const Patrol_step_t man_level_patrol_table_2[STEPS_PER_PATROL_TABLE] = {{0xFA, 0xFA}, {0xFA, 0xFA}, {0xFA, 0xFA}, {0xFA, 0xFA}};

/*
   [INFO] Method to group the call to the update methods of each system
            //TO-DO
            - Loop while condition victory of the level is accomplished
            - On each iteration call the update method of each system
            - Waits VSYNC to to start next iterations
   
   [PREREQUISITES]   Any function with the signature man_level_levelX should be called before this one.
   
*/
void man_level_gameLoop(){
   //TO-DO Comprobar condición de cambio de nivel (Puntuación enemigos...) 
   while(1){
      sys_input_update();
      sys_jump_update();
      sys_ai_update();
      cpct_setBorder(HW_BRIGHT_BLUE);
      sys_phyisics_update();
      cpct_setBorder(HW_BRIGHT_RED);
      man_entity_update();
      cpct_waitVSYNC();
      sys_render_update();
   }
}



/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO] Method to initialize the common data between levels
            - -Initialize the jumptable pointers of the jump system 
   
   [PREREQUISITES]   
*/
void man_level_init(){
   cpct_disableFirmware();
   cpct_setVideoMode(0);
   sys_jump_init_player(man_level_jtable_site_p_level1);
   sys_ai_init_patrol_tables(man_level_patrol_table_1);
}

/*
   [INFO] Method to initialize the data of each level
            -Calls man_entity init to reset the entities array
            -Initialize the palette through parameter
            -Initialize the player with the values stored at the man_level_init_player container
            -Initialize the jumptable pointers of the jump system
            -Calls man_level_gameLoop to start the level.  
   
   [PREREQUISITES] The method man_level_init should be called before this function is called  
*/
void man_level_level1(){
   cpct_setPalette(PALETTE_LEVEL1, 16);
   man_entitiy_init();
   man_entity_create_player(&man_level_init_player);
   man_entity_populate_entity_data(&man_level_init_enemy);
   man_level_gameLoop();
}




