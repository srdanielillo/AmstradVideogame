#include "man/level.h"

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
   man_entity_create_player();
   sys_render_init();
   sys_jump_init();
   man_level_gameLoop();
}

