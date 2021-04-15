#include "jump.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO] Array of pointers that point to the corresponding jump_table
*/
u8* sys_jump_player_jtable_ptrs[JUMP_TABLES_NUMBER];


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
void sys_jump_update_entitie(Entity_t *e){
    u8 jump_table = e -> jump_table;
    
    if(jump_table){
        u8 newvx = e -> vx;
        u8 newvy = e -> vy;
        /*  - Line to force the compiler does the -- operator on jump_table variable */
        u8 jump_table_aux = jump_table--;
        u8 jump_index = e -> jump_index;
        if(jump_index == STEPS_PER_JUMP_TABLE){
            e -> jump_index = 0;
            e -> jump_table = 0;
        }
        else{
            u8* jump_table_ptr = sys_jump_player_jtable_ptrs[jump_table];
            u8 jump_table_step = jump_table_ptr[jump_index];

            //Determine if x is positive or negative
            //Negative
            if(jump_table_step & 0x80){
                newvx += (((jump_table_step & 0x70) >> 4) ^ 0xFF) + 1;
            }
            //Positive
            else{
                newvx += (jump_table_step & 0x70) >> 4;
            }

            //Determine if y is positive or negative
            //Negative
            if(jump_table_step & 0x08){
                newvy += ((jump_table_step & 0x07) ^ 0xFF) + 1;
            }
            //Positive
            else{
                newvy += jump_table_step & 0x07;
            }

            e->jump_index = ++jump_index;
            e -> vx = newvx;
            e -> vy = newvy;
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
void sys_jump_init_player(u8 *ptr){
    cpct_memset(sys_jump_player_jtable_ptrs, 0, sizeof(sys_jump_player_jtable_ptrs));
    for(u8 i = 0; i < JUMP_TABLES_NUMBER; ++i){
        sys_jump_player_jtable_ptrs[i] = ptr;
        ptr += STEPS_PER_JUMP_TABLE;
    }
}

/*
   [INFO]            Calls sys_jump_update_player
                     
   [PREREQUISITES]   
*/
void sys_jump_update(){
    man_entity_forplayer( sys_jump_update_entitie );
}