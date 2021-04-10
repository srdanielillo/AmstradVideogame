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
   //TO-DO Comprobar si declarandolas antes y usandolas despues utiliza mas tiempo
   u8 newx, newy, newvx, newvy, message;

   message = e -> messages_re_ph; 
   newvx = e -> vx; newvy = e -> vy;
   
   if(newvx | newvy){
      newx = e -> x; newy = e -> y;
      newx += newvx; newy += newvy;
      e -> x = newx; e -> y = newy;
      e -> vx = 0; e -> vy = 0;
      //Activates the last bit of the message
      e -> messages_re_ph = message | sys_physics_active_movement;
      e -> vx = 0; e -> vy = 0;   
   }
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