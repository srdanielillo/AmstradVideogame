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
   u8 newx, newy, newvx, newvy, message, type, scr_w;

   newvx = e->vx;
   newvy = e->vy;
   message = e->messages_re_ph;
   type = e->type;

   if (newvx | newvy)
   {
      scr_w = e->sprite_W;

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

         if ((newvx & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
         {
            e->direction = LEFT_DIRECTION;
         }
      }

      if (newx > SCR_W) // || (newx & PHYSICS_IS_NEGATIVE == PHYSICS_IS_NEGATIVE))
      {
         man_entity_set4destruction(e);
      }
      else
      {
         e->x = newx;
         e->y = newy;

         e->messages_re_ph |= PHYSICS_HAS_MOVED;

         //Resets speed
         e->vx = 0;
         e->vy = 0;
      }
   }
   else
   {
      e->messages_re_ph &= PHYSICS_NOT_MOVED;
   }
}

u8 sys_physics_check_tile_colision(u8 x, u8 y)
{
   u8 x_tile_index, y_tile_index;

   x_tile_index = x >> 2;
   // Multiply 20 times (The width of the map)
   y_tile_index = ((y >> 3) << 4) + ((y >> 3) << 2);

   // Almacenar nivel en el que estamos
   if (g_bg_level1[x_tile_index + y_tile_index] == 1)
   {
      return 0x01;
   }

   return 0x00;
}

void sys_physics_update_player(Entity_t *e)
{
   u8 newx, newy, newvx, newvy;

   // Sprite size stuff
   u8 sprite_W, sprite_H, half_sprite_H;

   newvx = e->vx;
   newvy = e->vy;

   if (newvx | newvy)
   {

      newx = e->x;
      newy = e->y;

      newx += newvx;
      newy += newvy;

      // CHANGE DIRECTION
      if (newvx)
      {
         if (newvx > 0)
         {
            e->direction = RIGHT_DIRECTION;
         }

         if ((newvx & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
         {
            e->direction = LEFT_DIRECTION;
         }
      }

      sprite_W = e->sprite_W;
      sprite_H = e->sprite_H;
      half_sprite_H = sprite_H >> 1;

      // Checks if under the player are no tiles collisionables and keep falling
      // If there are no collisionables tiles and y > 200 the player has fall outside the map

      // Checks if one of the collision points is going to collide with a tile

      if (!sys_physics_check_tile_colision(newx, newy) && !sys_physics_check_tile_colision(newx + sprite_W, newy) && !sys_physics_check_tile_colision(newx, newy + half_sprite_H) && !sys_physics_check_tile_colision(newx + sprite_W, newy + half_sprite_H))
      {
         e->x = newx;
         e->y = newy;

         //Activates the active_movement flag
         e->messages_re_ph |= PHYSICS_HAS_MOVED;
      }

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