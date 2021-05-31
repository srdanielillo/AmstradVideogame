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
//TODO SEPARAR LÓGICA DE JUGADOR DE LA DE LOS ENEMIGOS
void sys_phyisics_update_entitie(Entity_t *e)
{
   u8 newx, newy, newvx, newvy, message, type;

   newvx = e->vx;
   newvy = e->vy;
   message = e->messages_re_ph;
   type = e->type;

   if (newvx | newvy)
   {

      newx = e->x;
      newy = e->y;

      newx += newvx;
      newy += newvy;

      e->x = newx;
      e->y = newy;

      e->messages_re_ph |= sys_physics_moved;

      //Resets speed
      e->vx = 0;
      e->vy = 0;
   }
   else
   {
      e->messages_re_ph &= sys_physics_not_moved;
   }
}

void sys_physics_update_player(Entity_t *e)
{
   //Hacer insitu y no coger variables temporales
   u8 newx, newy, newvx, newvy;

   newvx = e->vx;
   newvy = e->vy;

   if (newvx | newvy)
   {

      newx = e->x;
      newy = e->y;

      newx += newvx;
      newy += newvy;

      // Checks if newx is less than 0
      if ((newx & sys_physics_check_negative) == sys_physics_check_negative)
      {
         newx = 0;
      }
      else if (newx > SCR_W - e->sprite_W)
      {
         newx = SCR_W - e->sprite_W;
      }

      // Checks if newy is less than 0
      if ((newy & sys_physics_check_negative) == sys_physics_check_negative)
      {
         newy = 0;
      }
      else if (newy > SCR_H - e->sprite_H)
      {
         //TO-DO Implementar mecanismo de muerte del jugador
         man_entity_set4destruction(e);
      }

      e->x = newx;
      e->y = newy;

      //Activates the active_movement flag
      e->messages_re_ph |= sys_physics_moved;

      //Resets speed
      e->vx = 0;
      e->vy = 0;
   }
   else
   {
      e->messages_re_ph &= sys_physics_not_moved;
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
void sys_phyisics_init()
{
}

/*
   [INFO]            Calls sys_phyisics_update_player and sys_physics_update_one_entity
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_phyisics_update()
{
   man_entity_for_player(sys_physics_update_player);
   man_entity_for_entities(sys_phyisics_update_entitie);
}