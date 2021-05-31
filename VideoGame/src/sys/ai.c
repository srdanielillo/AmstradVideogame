#include "utils/bit.operators.constants.h"
#include "ai.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO] Array of pointers that point to the corresponding patrol table
*/
Patrol_step_t *sys_ai_ptable_ptrs[PATROL_TABLES_NUMBER];

/*
   [INFO]            Applies the corresponding patrol step
                           
   [PREREQUISITES]   
*/
void sys_ai_update_patrol(Entity_t *e)
{
    u8 patrol_info = e->patrol_info;

    if (patrol_info != PATROL_NOT_MOVE)
    {
        u8 actual_x = e->x;
        u8 actual_y = e->y;
        u8 destination_x, destination_y;

        u8 patrol_table_number = patrol_info >> 4;
        u8 patrol_step_index = patrol_info & 0x0F;

        Patrol_step_t *patrol_table = sys_ai_ptable_ptrs[patrol_table_number];
        patrol_table += patrol_step_index;

        destination_x = patrol_table->x;
        destination_y = patrol_table->y;

        if (actual_x == destination_x && actual_y == destination_y)
        {
            if (++patrol_step_index == STEPS_PER_PATROL_TABLE)
            {
                e->patrol_info &= PATROL_CLEAN_STEP;
            }
            else
            {
                e->patrol_info++;
            }
        }
        else
        {
            if (actual_x < destination_x)
            {
                e->vx++;
            }
            else if (actual_x > destination_x)
            {
                e->vx--;
            }

            if (actual_y < destination_y)
            {
                e->vy++;
            }
            else if (actual_y > destination_y)
            {
                e->vy--;
            }
        }
    }
}

/*
   [INFO]            Applies the corresponding ai in function of the entity type
                           
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_ai_update_entitie(Entity_t *e)
{
    u8 type = e->type;

    if (type == e_type_enemy)
    {
        sys_ai_update_patrol(e);
    }
}

/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Initializes the sys_ai_ptable_ptrs
                     
   [PREREQUISITES]   
*/
void sys_ai_init_patrol_tables(Patrol_step_t *ptr)
{
    cpct_memset(sys_ai_ptable_ptrs, 0, sizeof(sys_ai_ptable_ptrs));
    for (u8 i = 0; i < PATROL_TABLES_NUMBER; ++i)
    {
        sys_ai_ptable_ptrs[i] = ptr;
        ptr += STEPS_PER_PATROL_TABLE;
    }
}

/*
   [INFO]            Calls sys_ai_update_entitie
                     
   [PREREQUISITES]   
*/
void sys_ai_update()
{
    man_entity_for_entities(sys_ai_update_entitie);
}
