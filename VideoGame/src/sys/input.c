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
   u8 jumping = e -> jumping;
   if(!jumping){
       cpct_scanKeyboard_f();
       if(cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorRight)){
           e -> jumping = jump_table_right; 
       }
       else if(cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorLeft)){
           e -> jumping = jump_table_left;  
       }
       else if(cpct_isKeyPressed(Key_CursorUp)){
           e -> jumping = jump_table_in_site; 
       }
       else if( cpct_isKeyPressed(Key_CursorRight)){
           e -> vx = 1;
       }
       else if(cpct_isKeyPressed(Key_CursorLeft)){
           e -> vx = -1;
       }
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
