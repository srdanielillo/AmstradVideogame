//TO-DO Unify 
#include "physics.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/


/*
   [INFO]            Applies physics to the player entity and mark it to destroy when it meet one of this conditions
                     -  The player gets out the screen after applying vy      
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_phyisics_update_player(Entity_t *e){
    u8 newx = e -> x; u8 newy = e -> y;
    u8 newvx = e -> vx; u8 newvy = e -> vy;
    
    newx = newx + newvx; newy = newy + newvy;
    e -> x = newx; e -> y = newy;
    e -> vx = 0; e -> vy = 0;
}

/*
   [INFO]            Applies physics to the non-player entity and mark it to destroy when it meet one of this conditions
                     -  The new x position after applying vx is bigger than 80 or smaller than 40     
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
// void sys_physics_update_one_entity(Entity_t *e){
//     u8 newx = e->x + e->vx;
//     e->x = newx;
//     if(newx > 80 || newx < 0){
//         man_entity_set4destruction(e);
//     }
//     //e->x = newx;
// }


/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/
/*
    
   [INFO]            
   
   [PREREQUISITES]   
*/
void sys_phyisics_init(){
    
}

/*
   [INFO]            Calls sys_phyisics_update_player and sys_physics_update_one_entity
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_phyisics_update(){
    man_entity_forplayer( sys_phyisics_update_player );
    man_entity_forall( sys_phyisics_update_player );
}