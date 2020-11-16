#include "input.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO]            Updates the position of the player depending on the pressed keys
                     -  CursorRight x++ || CursorLeft x--
                     
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_input_update_player(Entity_t *e){
   //TO-DO Cambiar cuando este listo el scroll horizontal
   u8 newx = e -> x;
   u8 sprite_W = e -> sprite_W;
   cpct_scanKeyboard_f();
   if( cpct_isKeyPressed(Key_CursorRight) && newx < (SCR_W - sprite_W) ){
       e -> x = ++newx;
   }
   else if(cpct_isKeyPressed(Key_CursorLeft) && newx > 0){
       e -> x = --newx;
   }
}


/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Calls sys_input_update_one_entity
                     
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_input_update(){
    man_entity_forplayer( sys_input_update_player );
}
