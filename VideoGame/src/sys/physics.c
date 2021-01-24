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
    { {js_no_movement, js_y_up}, {js_no_movement, js_y_up}, {js_no_movement, js_y_down}, {js_no_movement, js_y_down}, {js_no_movement, js_no_movement}},
    0x00
};

const JumpTable_t jumpTableRight = {
    {{js_x_right, js_y_up}, {js_x_right, js_y_up}, {js_x_right, js_y_down}, {js_x_right, js_y_down}, {js_no_movement, js_no_movement}},
    0x00
};

const JumpTable_t jumpTableLeft = {
    {{js_x_left, js_y_up}, {js_x_left, js_y_up}, {js_x_left, js_y_down}, {js_x_left, js_y_down}, {js_no_movement, js_no_movement}},
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
    u8 jumping_original = e -> jumping;
    u8 jumping = jumping_original - 1;
    
    if(jumping_original){
        u8 index = s_jumpTables[jumping].index;
        JumpStep_t step = {s_jumpTables[jumping].steps[index].x_step, s_jumpTables[jumping].steps[index].y_step};
        if(((step.x_step | step.y_step) | 0x00)){
            u8 newx = e -> x;
            u8 newy = e -> y;
            newx = newx + step.x_step;
            newy = newy + step.y_step;
            e -> x = newx;
            e -> y = newy;
            ++index;
            s_jumpTables[jumping].index = index;
        }
        else{
            e -> jumping = js_no_movement;
            s_jumpTables[jumping].index = js_no_movement;
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