#include "jump.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

u8* sys_jump_player_jtable_ptrs[JUMP_TABLES_NUMBER];
 
void sys_jump_update_player(Entity_t *e){
    u8 jump_table = e -> jump_table;
    
    u8 newvx = e -> vx;
    u8 newvy = e -> vy;
    
    if(jump_table){
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

            // u8 x_movement = 0x00;
            // u8 y_movement = 0x00;
            
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

void sys_jump_init_player(u8 *ptr){
    u8* ptr_aux = ptr;
    cpct_memset(sys_jump_player_jtable_ptrs, 0, sizeof(sys_jump_player_jtable_ptrs));
    for(u8 i = 0; i < JUMP_TABLES_NUMBER; ++i){
        sys_jump_player_jtable_ptrs[i] = ptr_aux;
        ptr_aux = ptr_aux + STEPS_PER_JUMP_TABLE;
    }
}

void sys_jump_update(){
    man_entity_forplayer( sys_jump_update_player );
}