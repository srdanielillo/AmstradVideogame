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
    {e_jump_step_up, e_jump_step_up, e_jump_step_down, e_jump_step_down, e_no_jump},
    0x00
};

const JumpTable_t jumpTableRight = {
    {e_jump_step_up_right, e_jump_step_up_right, e_jump_step_down_right, e_jump_step_down_right, e_no_jump},
    0x00
};

const JumpTable_t jumpTableLeft = {
    {e_jump_step_up_left, e_jump_step_up_left, e_jump_step_down_left, e_jump_step_down_left, e_no_jump},
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
    u8 jumping = e -> jumping;
    //En jumping vendra el indice para obtener la JumpTable correcta
    //TO-DO Que los pasos del salto vayan en bloques de dos (Cambiar a i8)
    if(jumping){
        u8 jumping_aux = jumping - 1;
        u8 index = s_jumpTables[jumping_aux].index;
        u8 step = s_jumpTables[jumping_aux].steps[index];
        if(step){
            u8 x_movement = (step & left_four_bits) >> 4;
            u8 y_movement = step & right_four_bits;
            i8 newx = e -> x;
            i8 newy = e -> y;
            newx = newx + x_movement;
            newy = newy + y_movement;
            e -> x = newx;
            e -> y = newy;
            ++index;
            s_jumpTables[jumping_aux].index = index;
        }
        else{
            e -> jumping = e_no_jump;
            s_jumpTables[jumping_aux].index = e_no_jump;
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