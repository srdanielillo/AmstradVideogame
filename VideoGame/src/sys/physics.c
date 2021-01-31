#include "physics.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

//TO-DO Inicializar este array con las tablas directamente, no se puede hacer const porque se va a modificar el campo index
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

/*
   [INFO]            Applies physics to the player entity and mark it to destroy when it meet one of this conditions
                     -  The player gets out the screen after applying vy      
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_phyisics_update_player(Entity_t *e){
    //TO-DO Hacer game over si nos salimos del juego hacía abajo
    //TO-DO Pensar si va a haber cosas que nos muevan hacia los laterales
    //TO-DO Comprobar si se encuentra saltando y si lo esta actualizar posición e índice de la tabla de salto
    //TO_DO !!!!!!RENDIMIENTO!!!!!!
    u8 jumping = e -> jumping;
    if(jumping){
        u8 jump_table_number = jumping - 1;
        u8 jump_table_index = s_jumpTables[jump_table_number].index;
        if(jump_table_index == STEPS_PER_JUMP_TABLE){
            s_jumpTables[jump_table_number].index = 0x00;
            e -> jumping = js_no_movement;
        }
        else{
            u8 jump_table_step = s_jumpTables[jump_table_number].steps[jump_table_index];
            
            u8 newx = e -> x;
            u8 newy = e -> y;

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
            newx = newx + x_movement;
            newy = newy + y_movement;
            e -> x = newx;
            e -> y = newy;
        }
    }
}

/*
   [INFO]            Applies physics to the non-player entity and mark it to destroy when it meet one of this conditions
                     -  The new x position after applying vx is bigger than 80 or smaller than 40     
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_physics_update_one_entity(Entity_t *e){
    //TO-DO Realizar calculo sobre tamanyo del sprite en caso de salir por la derecha 
    //TO-DO Comprobar si se encuentra saltando y si lo esta actualizar posición e índice de la tabla de salto
    u8 newx = e->x + e->vx;
    e->x = newx;
    if(newx > 80 || newx < 0){
        man_entity_set4destruction(e);
    }
    //e->x = newx;
}


/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/
/*
    TO-DO Actualizar documentacion
   [INFO]            Calls sys_phyisics_update_player and sys_physics_update_one_entity
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_phyisics_init(){
    cpct_memset(s_jumpTables, 0, sizeof(s_jumpTables));
    cpct_memcpy (s_jumpTables, &jumpTableInSite, sizeof(JumpTable_t));
    cpct_memcpy (s_jumpTables+1, &jumpTableRight, sizeof(JumpTable_t));
    cpct_memcpy (s_jumpTables+2, &jumpTableLeft, sizeof(JumpTable_t));
}

/*
   [INFO]            Calls sys_phyisics_update_player and sys_physics_update_one_entity
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_phyisics_update(){
    man_entity_forplayer( sys_phyisics_update_player );
    man_entity_forall( sys_physics_update_one_entity );
}