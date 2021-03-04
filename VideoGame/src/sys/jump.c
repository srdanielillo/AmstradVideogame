#include "jump.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/
//TO-DO Aumentar rendimiento
//TO-DO Moverlo a level 
JumpTable s_jump_tables[JUMP_TABLES];

const JumpTable jump_table_in_site = {js_up, js_up, js_down, js_down};
const JumpTable jump_table_right = {js_up_right, js_up_right, js_down_right, js_down_right};
const JumpTable jump_table_left = {js_up_left, js_up_left, js_down_left,js_down_left};

void sys_jump_update_player(Entity_t *e){
    u8 jump_table = e -> jump_table;
    
    u8 newvx = e -> vx;
    u8 newvy = e -> vy;
    
    if(jump_table){
        u8 jump_table_aux = jump_table - 1;
        u8 jump_index = e -> jump_index;
        if(jump_index == STEPS_PER_JUMP_TABLE){
            e -> jump_index = 0;
            e -> jump_table = 0;
        }
        else{
            u8 jump_table_step = s_jump_tables[jump_table_aux][jump_index];
            
            u8 x_movement = 0x00;
            u8 y_movement = 0x00;
            
            //Determine if x is positive or negative
            //Negative
            if(jump_table_step & 0x80){
                x_movement = (((jump_table_step & 0x70) >> 4) ^ 0xFF) + 1;
            }
            //Positive
            else{
                x_movement = (jump_table_step & 0x70) >> 4;
            }

            //Determine if y is positive or negative
            //Negative
            if(jump_table_step & 0x08){
                y_movement = ((jump_table_step & 0x07) ^ 0xFF) + 1;
            }
            //Positive
            else{
                y_movement = jump_table_step & 0x07;
            }

            e->jump_index = ++jump_index;
            newvx = newvx + x_movement;
            newvy = newvy + y_movement;
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
//TO-DO Cargar tablas de salto desde un fichero a parte cuando existe el manager de niveles
void sys_jump_init(){
    cpct_memset(s_jump_tables, 0, sizeof(s_jump_tables));
    cpct_memcpy (s_jump_tables, &jump_table_in_site, sizeof(JumpTable));
    cpct_memcpy (s_jump_tables+1, &jump_table_right, sizeof(JumpTable));
    cpct_memcpy (s_jump_tables+2, &jump_table_left, sizeof(JumpTable));
}

void sys_jump_update(){
    man_entity_forplayer( sys_jump_update_player );
}