#include "jump.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/
//TO-DO Almacenar el indice de salto en la entidad para poder reutilizar tablas de salto
//TO-DO Aumentar rendimiento
JumpTable_t s_jumpTables[JUMP_TABLES];

const JumpTable_t jumpTableInSite = {
    {js_up, js_up, js_down, js_down},
    0x00
};

const JumpTable_t jumpTableRight = {
    {js_up_right, js_up_right, js_down_right, js_down_right},
    0x00
};

const JumpTable_t jumpTableLeft = {
    {js_up_left, js_up_left, js_down_left,js_down_left},
    0x00
};

void sys_jump_update_player(Entity_t *e){
    //TO-DO Hacer game over si nos salimos del juego hacía abajo
    u8 jumping = e -> jumping;
    
    u8 newvx = e -> vx;
    u8 newvy = e -> vy;
    
    if(jumping){
        u8 jump_table_number = jumping - 1;
        u8 jump_table_index = s_jumpTables[jump_table_number].index;
        if(jump_table_index == STEPS_PER_JUMP_TABLE){
            s_jumpTables[jump_table_number].index = 0x00;
            e -> jumping = js_no_movement;
        }
        else{
            u8 jump_table_step = s_jumpTables[jump_table_number].steps[jump_table_index];
            
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

            s_jumpTables[jump_table_number].index = ++jump_table_index;
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
    cpct_memset(s_jumpTables, 0, sizeof(s_jumpTables));
    cpct_memcpy (s_jumpTables, &jumpTableInSite, sizeof(JumpTable_t));
    cpct_memcpy (s_jumpTables+1, &jumpTableRight, sizeof(JumpTable_t));
    cpct_memcpy (s_jumpTables+2, &jumpTableLeft, sizeof(JumpTable_t));
}

void sys_jump_update(){
    man_entity_forplayer( sys_jump_update_player );
}