#include "input.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO]            Updates the velocity attributes of the player depending on the pressed keys
                     - CursorRight x++ || CursorLeft x--
                     
                     Assign the number of the correct jump table depending on the keys pressed
                     - CursorUp               jump_table = 1
                     - CursorUp + CurosrRight jump_table = 2
                     - CursorUp + CursorLeft  jump_table = 3
                     
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_input_update_player(Entity_t *e)
{
    u8 jump_table = e->jump_table;
    if (!jump_table)
    {
        cpct_scanKeyboard_f();
        //if(cpct_isAnyKeyPressed_f()){
        if (cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorRight))
        {
            e->jump_table = jump_table_right;
        }
        else if (cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorLeft))
        {
            e->jump_table = jump_table_left;
        }
        else if (cpct_isKeyPressed(Key_CursorUp))
        {
            e->jump_table = jump_table_in_site;
        }
        else if (cpct_isKeyPressed(Key_CursorRight))
        {
            e->vx = 1;
        }
        else if (cpct_isKeyPressed(Key_CursorLeft))
        {
            e->vx = -1;
        }
        //}
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
void sys_input_update()
{
    man_entity_for_player(sys_input_update_player);
}
