#include "man/level.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
   In this module the use of const word might not be strict
   At each level start the values of the container maybe would change
*/

/*
   [INFO] Containers to store the different sprites of the entities

*/
u8 *player_sprites[SPRITES_NUMBER];
u8 *enemy1_sprites[SPRITES_NUMBER]; // Brujo limoncin
u8 *enemy2_sprites[SPRITES_NUMBER]; // Robot asesino
u8 *enemy3_sprites[SPRITES_NUMBER]; // SamuraiPulpo
u8 *bullet_sprites[SPRITES_NUMBER];

/*
   [INFO] Const data to initialize the shot manager
*/
const Entity_t man_level_init_shot_template = {
    e_type_shot,          // type
    0xFA,                 // x
    0xFA,                 // y
    0x00, 0x00,           // vx, vy
    1,                    // sprite_W
    1,                    // sprite_H
    BULLET_SPRITE_LEVEL1, // sprite
    0,                    // prevptr
    0xFFFF,               // jump_table
    0x00,                 // jump_step
    0x80,                 // messages_re_ph
    0xFF,                 // patrol_info
    RIGHT_DIRECTION,      // direction
    bullet_sprites,       // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,       // last direction
    1,                    // animation counter
    BULLET_SPRITE_LEVEL1  // Prev sprite
};

/*
   [INFO] Container to copy the player data on each level
*/
const Entity_t man_level_init_player = {
    e_type_player,              // type
    PLAYER_START_X_LEVEL1,      // x
    PLAYER_START_Y_LEVEL1,      // y
    0, 0,                       // vx, vy
    PLAYER_SPRITE_W_LEVEL1,     // sprite_W
    PLAYER_SPRITE_H_LEVEL1,     // sprite_H
    PLAYER_START_SPRITE_LEVEL1, // sprite
    0,                          // prevptr
    0xFFFF,                     // jump_table
    0x00,                       // jump_step
    0x00,                       // messages_re_ph
    0x00,                       // patrol_info
    LEFT_DIRECTION,             // direction
    player_sprites,             // pointer to the array of pointers to the entity sprite
    RIGHT_DIRECTION,            // last direction
    1,                          // animation counter
    PLAYER_START_SPRITE_LEVEL1  // prevsprite
};

/*
   [INFO] Container to copy the enemies data on each level
*/
const Entity_t man_level_init_enemy = {
    e_type_enemy,               // type
    0,                          // x
    150,                        // y
    0, 0,                       // vx, vy
    PLAYER_SPRITE_W_LEVEL1,     // sprite_W
    PLAYER_SPRITE_H_LEVEL1,     // sprite_H
    ENEMY1_START_SPRITE_LEVEL1, // sprite
    0,                          // prevptr
    0xFFFF,                     // jump_table
    0xFF,                       // jump_step
    0x00,                       // messages_re_ph
    0x00,                       // patrol_info
    RIGHT_DIRECTION,            // direction
    enemy1_sprites,             // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,             // last direction
    1,                          // animation counter
    ENEMY1_START_SPRITE_LEVEL1, // prevsprite
};

const Entity_t man_level_init_enemy_2 = {
    e_type_enemy,           // type
    0,                      // x
    180,                    // y
    0, 0,                   // vx, vy
    PLAYER_SPRITE_W_LEVEL1, // sprite_W
    PLAYER_SPRITE_H_LEVEL1, // sprite_H
    enemy2_sp_0,            // sprite
    0,                      // prevptr
    0xFFFF,                 // jump_table
    0xFF,                   // jump_step
    0x01,                   // messages_re_ph
    0x10,                   // patrol_info
    RIGHT_DIRECTION,        // direction
    enemy2_sprites,         // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,         // last direction
    1,                      // animation counter
    enemy2_sp_0,            // prevsprite
};

const Entity_t man_level_init_enemy_3 = {
    e_type_enemy,           // type
    0,                      // x
    80,                     // y
    0, 0,                   // vx, vy
    PLAYER_SPRITE_W_LEVEL1, // sprite_W
    PLAYER_SPRITE_H_LEVEL1, // sprite_H
    enemy3_sp_4,            // sprite
    0,                      // prevptr
    0xFFFF,                 // jump_table
    0xFF,                   // jump_step
    0x00,                   // messages_re_ph
    0x20,                   // patrol_info
    RIGHT_DIRECTION,        // direction
    enemy3_sprites,         // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,         // last direction
    1,                      // animation counter
    enemy3_sp_4,            // prevsprite
};

const Entity_t man_level_init_enemy_4 = {
    e_type_enemy,               // type
    22,                         // x
    100,                        // y
    0, 0,                       // vx, vy
    PLAYER_SPRITE_W_LEVEL1,     // sprite_W
    PLAYER_SPRITE_H_LEVEL1,     // sprite_H
    PLAYER_START_SPRITE_LEVEL1, // sprite
    0,                          // prevptr
    0xFFFF,                     // jump_table
    0xFF,                       // jump_step
    0x01,                       // messages_re_ph
    0x00,                       // patrol_info
    RIGHT_DIRECTION,            // direction
    enemy1_sprites,             // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,             // last direction
    1,                          // animation counter
    ENEMY1_START_SPRITE_LEVEL1, // prevsprite
};

const Entity_t man_level_init_enemy_5 = {
    e_type_enemy,               // type
    0,                          // x
    80,                         // y
    0, 0,                       // vx, vy
    PLAYER_SPRITE_W_LEVEL1,     // sprite_W
    PLAYER_SPRITE_H_LEVEL1,     // sprite_H
    PLAYER_START_SPRITE_LEVEL1, // sprite
    0,                          // prevptr
    0xFFFF,                     // jump_table
    0xFF,                       // jump_step
    0x00,                       // messages_re_ph
    0x00,                       // patrol_info
    RIGHT_DIRECTION,            // direction
    enemy1_sprites,             // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,             // last direction
    1,                          // animation counter
    ENEMY1_START_SPRITE_LEVEL1, // prevsprite
};

const Entity_t man_level_init_enemy_6 = {
    e_type_enemy,               // type
    22,                         // x
    100,                        // y
    0, 0,                       // vx, vy
    PLAYER_SPRITE_W_LEVEL1,     // sprite_W
    PLAYER_SPRITE_H_LEVEL1,     // sprite_H
    PLAYER_START_SPRITE_LEVEL1, // sprite
    0,                          // prevptr
    0xFFFF,                     // jump_table
    0xFF,                       // jump_step
    0x01,                       // messages_re_ph
    0x00,                       // patrol_info
    RIGHT_DIRECTION,            // direction
    enemy1_sprites,             // pointer to the array of pointers to the entity sprite
    LEFT_DIRECTION,             // last direction
    1,                          // animation counter
    ENEMY1_START_SPRITE_LEVEL1, // prevsprite
};

/*
   [INFO] Container to store the jump tables of the player
          The jump system points to these containers
          The sys_jump_init_player should only be called once.
          This is beacuse the values that these system points are here and are managed by this system   
*/
const Jump_step_t man_level_jtable_site_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_IN_SITE_PLAYER_LEVEL1;
const Jump_step_t man_level_jtable_right_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_RIGHT_PLAYER_LEVEL1;
const Jump_step_t man_level_jtable_left_p_level1[STEPS_PER_JUMP_TABLE] = JUMP_TABLE_LEFT_PLAYER_LEVEL1;

/*
   [INFO] Containers to store the patrol tables

*/
const Patrol_step_t man_level_patrol_table_1[STEPS_PER_PATROL_TABLE] = {{0, 0}, {70, 0}, {70, 184}, {0, 184}};
const Patrol_step_t man_level_patrol_table_2[STEPS_PER_PATROL_TABLE] = {{0, 180}, {60, 180}, {30, 180}, {0, 180}};
const Patrol_step_t man_level_patrol_table_3[STEPS_PER_PATROL_TABLE] = {{30, 80}, {60, 80}, {30, 80}, {0, 80}};

u8 get_level_state()
{
   if (man_entity_player_dead())
   {
      return LEVEL_STATE_PLAYER_DEAD;
   }

   if (sys_physics_door_collision() && man_entity_enemies_left() == 0)
   {
      return LEVEL_STATE_FINISHED;
   }

   return LEVEL_STATE_CONTINUE;
}

/*
   [INFO] Method to group the call to the update methods of each system
            //TO-DO
            - Loop while condition victory of the level is accomplished
            - On each iteration call the update method of each system
            
   
   [PREREQUISITES]   Any function with the signature man_level_levelX should be called before this one.
   
*/
u8 man_level_gameLoop()
{

   //TO-DO Comprobar condición de cambio de nivel (Puntuación enemigos...)
   while (get_level_state() == LEVEL_STATE_CONTINUE)
   {

      sys_input_update();
      sys_jump_update();
      sys_ai_update();
      sys_phyisics_update();
      sys_collision_update();
      sys_animation_update();
      man_entity_update();
      cpct_waitVSYNC();
      sys_render_update();
   }

   return get_level_state();
}

void init_player_sprites()
{
   player_sprites[0] = player_sp_0;
   player_sprites[1] = player_sp_1;
   player_sprites[2] = player_sp_2;
   player_sprites[3] = player_sp_3;
   player_sprites[4] = player_sp_4;
   player_sprites[5] = player_sp_5;
   player_sprites[6] = player_sp_6;
   player_sprites[7] = player_sp_7;
}

void init_enemy1_sprites()
{
   enemy1_sprites[0] = enemy1_sp_0;
   enemy1_sprites[1] = enemy1_sp_1;
   enemy1_sprites[2] = enemy1_sp_2;
   enemy1_sprites[3] = enemy1_sp_3;
   enemy1_sprites[4] = enemy1_sp_4;
   enemy1_sprites[5] = enemy1_sp_5;
   enemy1_sprites[6] = enemy1_sp_6;
   enemy1_sprites[7] = enemy1_sp_7;
}

void init_enemy2_sprites()
{
   enemy2_sprites[0] = enemy2_sp_0;
   enemy2_sprites[1] = enemy2_sp_1;
   enemy2_sprites[2] = enemy2_sp_2;
   enemy2_sprites[3] = enemy2_sp_3;
   enemy2_sprites[4] = enemy2_sp_4;
   enemy2_sprites[5] = enemy2_sp_5;
   enemy2_sprites[6] = enemy2_sp_6;
   enemy2_sprites[7] = enemy2_sp_7;
}

void init_enemy3_sprites()
{
   enemy3_sprites[0] = enemy3_sp_0;
   enemy3_sprites[1] = enemy3_sp_1;
   enemy3_sprites[2] = enemy3_sp_2;
   enemy3_sprites[3] = enemy3_sp_3;
   enemy3_sprites[4] = enemy3_sp_4;
   enemy3_sprites[5] = enemy3_sp_5;
   enemy3_sprites[6] = enemy3_sp_6;
   enemy3_sprites[7] = enemy3_sp_7;
}

void init_bullet_sprites()
{
   bullet_sprites[0] = bullet_sp_0;
   bullet_sprites[1] = bullet_sp_1;
   bullet_sprites[2] = bullet_sp_2;
   bullet_sprites[3] = bullet_sp_3;
   bullet_sprites[4] = bullet_sp_4;
   bullet_sprites[5] = bullet_sp_5;
   bullet_sprites[6] = bullet_sp_6;
   bullet_sprites[7] = bullet_sp_7;
}

/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO] Method to initialize the common data between levels
            -Initialize the jumptable pointers of the jump system
            -Initialize the patroltable pointers of the ai system
            -Initialize the shot_template used to create new shots in the shot manager
            -Initialize the shot_info template in input_init 
   
   [PREREQUISITES]   
*/
void man_level_init()
{
   cpct_disableFirmware();
   cpct_setVideoMode(0);
   sys_jump_init_jump_tables(man_level_jtable_site_p_level1);
   man_shot_init(&man_level_init_shot_template);
   sys_input_init();
   init_player_sprites();
   init_enemy1_sprites();
   init_enemy2_sprites();
   init_enemy3_sprites();
   init_bullet_sprites();
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
#define TILEMAP_VMEM cpctm_screenPtr(CPCT_VMEM_START, 0, 0)
u8 man_level_level1()
{
   cpct_setPalette(PALETTE_LEVEL1, 16);

   // Draw map
   cpct_etm_setDrawTilemap4x8_ag(g_bg_level1_W, g_bg_level1_H, g_bg_level1_W, g_tiles_level1_00);
   cpct_etm_drawTilemap4x8_ag(TILEMAP_VMEM, g_bg_level1);

   // Set the tilemap of the level so the physics system can check collisions
   sys_phyisics_set_tilemap(g_bg_level1);

   // Init patrol system
   sys_ai_init_patrol_tables(man_level_patrol_table_1);

   man_entitiy_init();
   sys_phyisics_init();
   man_entity_create_player(&man_level_init_player);
   man_entity_populate_entity_data(&man_level_init_enemy);
   man_entity_populate_entity_data(&man_level_init_enemy_2);
   man_entity_populate_entity_data(&man_level_init_enemy_3);
   //man_entity_populate_entity_data(&man_level_init_enemy_4);
   //man_entity_populate_entity_data(&man_level_init_enemy_5);
   //man_entity_populate_entity_data(&man_level_init_enemy_6);

   // Draws the whole level before doing any system update
   cpct_waitVSYNC();
   sys_render_first_time();
   return man_level_gameLoop();
}

u8 man_level_level2()
{
   cpct_setPalette(PALETTE_LEVEL1, 16);

   // Draw map
   cpct_etm_setDrawTilemap4x8_ag(g_bg_level2_W, g_bg_level2_H, g_bg_level2_W, g_tiles_level1_00);
   cpct_etm_drawTilemap4x8_ag(TILEMAP_VMEM, g_bg_level2);

   // Set the tilemap of the level so the physics system can check collisions
   sys_phyisics_set_tilemap(g_bg_level2);

   // Init patrol system
   sys_ai_init_patrol_tables(man_level_patrol_table_1);

   man_entitiy_init();
   sys_phyisics_init();
   man_entity_create_player(&man_level_init_player);
   man_entity_populate_entity_data(&man_level_init_enemy);
   //man_entity_populate_entity_data(&man_level_init_enemy_2);
   //man_entity_populate_entity_data(&man_level_init_enemy_3);
   //man_entity_populate_entity_data(&man_level_init_enemy_4);
   //man_entity_populate_entity_data(&man_level_init_enemy_5);
   //man_entity_populate_entity_data(&man_level_init_enemy_6);

   // Draws the whole level before doing any system update
   cpct_waitVSYNC();
   sys_render_first_time();
   return man_level_gameLoop();
}

u8 man_level_level3()
{
   cpct_setPalette(PALETTE_LEVEL1, 16);

   // Draw map
   cpct_etm_setDrawTilemap4x8_ag(g_bg_level2_W, g_bg_level2_H, g_bg_level2_W, g_tiles_level1_00);
   cpct_etm_drawTilemap4x8_ag(TILEMAP_VMEM, g_bg_level2);

   // Set the tilemap of the level so the physics system can check collisions
   sys_phyisics_set_tilemap(g_bg_level2);

   // Init patrol system
   sys_ai_init_patrol_tables(man_level_patrol_table_1);

   man_entitiy_init();
   sys_phyisics_init();
   man_entity_create_player(&man_level_init_player);
   man_entity_populate_entity_data(&man_level_init_enemy);
   //man_entity_populate_entity_data(&man_level_init_enemy_2);
   //man_entity_populate_entity_data(&man_level_init_enemy_3);
   //man_entity_populate_entity_data(&man_level_init_enemy_4);
   //man_entity_populate_entity_data(&man_level_init_enemy_5);
   //man_entity_populate_entity_data(&man_level_init_enemy_6);

   // Draws the whole level before doing any system update
   cpct_waitVSYNC();
   sys_render_first_time();
   return man_level_gameLoop();
}
