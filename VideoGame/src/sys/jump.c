//TODO Cambiarlo y hacer que se parezca a patrol system
#include "jump.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO] Array of pointers that point to the corresponding jump_table
*/
Jump_step_t *sys_jump_player_jtable_ptrs[JUMP_TABLES_NUMBER];

/*
   [INFO]            Updates the velocity attributes of the player depending on the values stored in the jump tables
                     - Extracts the number of actual jump table from the entity.
                     - Decreases it because is an index.
                     - Extracts the correct jump index that will point to the correct value of vx and vy
                            Each 4 bits represent the value to increment on each direction
                            The first 4 bits are the X increment value and the follow 4 are the Y increment value
                            If the first bit of the group is activated (More on the left) the number is negative if not it's positive.
                              XY
                              --
                            0x00

   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_jump_update_entitie(Entity_t *e)
{
    Jump_step_t *jump_table;
    u8 jump_step;

    jump_table = e->jump_table;
    jump_step = e->jump_step;

    if ((u16)jump_table != 0xFFFF)
    {
        if (jump_step == STEPS_PER_JUMP_TABLE)
        {
            e->jump_table = (Jump_step_t *)0xFFFF;
            e->jump_step = 0x00;
        }
        else
        {
            jump_table += jump_step;

            e->vx += jump_table->x;
            e->vy += jump_table->y;

            e->jump_step++;
        }
    }
}

/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Initializes the sys_jump_player_jtable_ptrs
                     
   [PREREQUISITES]   
*/
void sys_jump_init_jump_tables(Jump_step_t *ptr)
{
    cpct_memset(sys_jump_player_jtable_ptrs, 0, sizeof(sys_jump_player_jtable_ptrs));
    for (u8 i = 0; i < JUMP_TABLES_NUMBER; ++i)
    {
        sys_jump_player_jtable_ptrs[i] = ptr;
        ptr += STEPS_PER_JUMP_TABLE;
    }
}

Jump_step_t *sys_jump_get_jt_pointer(u8 index)
{
    return sys_jump_player_jtable_ptrs[index];
}

/*
   [INFO]            Calls sys_jump_update_player
                     
   [PREREQUISITES]   
*/
void sys_jump_update()
{
    man_entity_for_player(sys_jump_update_entitie);
}