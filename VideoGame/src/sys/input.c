#include "input.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

Shot_data_t shot_data_template;
Shot_data_t *shot_data_template_ptr;

u8 cycle_reset_shot_counter;

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
    u8 jump_info, direction, x, y, sprite_W;

    if (cycle_reset_shot_counter > 0)
    {
        --cycle_reset_shot_counter;
    }

    jump_info = e->jump_info;
    if (jump_info == 0xFF)
    {
        x = e->x;
        y = e->y;
        sprite_W = e->sprite_W;
        cpct_scanKeyboard_f();
        if (cpct_isKeyPressed(Key_Space) && cycle_reset_shot_counter == 0 && (x + sprite_W < 78) && x)
        {
            direction = e->direction;
            if (direction == RIGHT_DIRECTION)
            {
                shot_data_template_ptr->x = e->x + e->sprite_W;
            }
            else if (direction == LEFT_DIRECTION)
            {
                shot_data_template_ptr->x = e->x;
            }

            shot_data_template_ptr->y = e->y + 4;
            shot_data_template_ptr->direction = direction;
            man_shot_create_shot(shot_data_template_ptr);
            cycle_reset_shot_counter = CYCLES_TO_RESET_SHOT;
        }
        else if (cpct_isKeyPressed(Key_CursorUp) && cpct_isKeyPressed(Key_CursorRight))
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

void sys_input_init()
{
    shot_data_template_ptr = &shot_data_template;
    cpct_memset(shot_data_template_ptr, 0, sizeof(Shot_data_t));
    cycle_reset_shot_counter = 0;
}

/*
   [INFO]            Calls sys_input_update_one_entity
                     
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_input_update()
{
    man_entity_for_player(sys_input_update_player);
}
