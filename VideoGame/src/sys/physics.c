#include "physics.h"

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

      if (newvx)
      {
         if (newvx > 0)
         {
            e->direction = RIGHT_DIRECTION;
         }

         if (newvx & PHYSICS_IS_NEGATIVE)
         {
            e->direction = LEFT_DIRECTION;
         }
      }

      e->x = newx;
      e->y = newy;

      e->messages_re_ph |= PHYSICS_HAS_MOVED;

      //Resets speed
      e->vx = 0;
      e->vy = 0;
   }
   else
   {
      e->messages_re_ph &= PHYSICS_NOT_MOVED;
   }
}

void sys_physics_update_player(Entity_t *e)
{
   u8 newx, newy, newvx, newvy;

   newvx = e->vx;
   newvy = e->vy;

   if (newvx | newvy)
   {

      newx = e->x;
      newy = e->y;

      newx += newvx;
      newy += newvy;

      if (newvx)
      {
         if (newvx > 0)
         {
            e->direction = RIGHT_DIRECTION;
         }

         if (newvx & PHYSICS_IS_NEGATIVE)
         {
            e->direction = LEFT_DIRECTION;
         }
      }

      // Checks if newx is less than 0
      if ((newx & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
      {
         newx = 0;
      }
      else if (newx > SCR_W - e->sprite_W)
      {
         newx = SCR_W - e->sprite_W;
      }

      // Checks if newy is less than 0
      if ((newy & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
      {
         newy = 0;
      }
      else if (newy > SCR_H - e->sprite_H)
      {
         man_entity_set4destruction(e);
      }

      e->x = newx;
      e->y = newy;

      //Activates the active_movement flag
      e->messages_re_ph |= PHYSICS_HAS_MOVED;

      //Resets speed
      e->vx = 0;
      e->vy = 0;
   }
   else
   {
      e->messages_re_ph &= PHYSICS_NOT_MOVED;
   }
}

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