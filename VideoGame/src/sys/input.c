#include "input.h"
#include "man/entity.h"

void sys_input_update(){
   Entity_t* player = man_entity_get_player();
   cpct_scanKeyboard_f();
   //MOVE RIGHT
   if(cpct_isKeyPressed(Key_CursorRight)){
       player -> x++;
   }
   else if(cpct_isKeyPressed(Key_CursorLeft)){
       player -> x--;
   } 
}
