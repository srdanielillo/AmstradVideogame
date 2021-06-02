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
    u8 jump_info = e->jump_info;
    if (jump_info == 0xFF)
    {
        cpct_scanKeyboard_f();
        if (cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorRight))
        {
            e->jump_info = jump_table_right;
        }
        else if (cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorLeft))
        {
            e->jump_info = jump_table_left;
        }
        else if (cpct_isKeyPressed(Key_CursorUp))
        {
            e->jump_info = jump_table_in_site;
        }
        else if (cpct_isKeyPressed(Key_CursorRight))
        {
            e->vx++;
        }
        else if (cpct_isKeyPressed(Key_CursorLeft))
        {
            e->vx--;
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
void sys_input_update()
{
    man_entity_for_player(sys_input_update_player);
}
