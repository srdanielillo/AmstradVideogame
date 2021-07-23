#include "physics.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

u8 gravity_on;

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

u8 check_tile_collision(u8 x, u8 y)
{
   u16 x_tile_index, y_tile_index, tile_number, linear_tile_index;

   x_tile_index = x >> 2;
   // Multiply 20 times (The width of the map)
   y_tile_index = ((y >> 3) << 4) + ((y >> 3) << 2);

   linear_tile_index = x_tile_index + y_tile_index;

   tile_number = g_bg_level1[linear_tile_index];

   // Almacenar nivel en el que estamos
   if (tile_number == 1 || tile_number == 2)
   {
      return 0x01;
   }

   return 0x00;
}

void sys_physics_update_player(Entity_t *e)
{
   u8 oldx, oldy, newx, newy, vx, vy;

   // Sprite size stuff
   u8 sprite_W, sprite_H, half_sprite_H;

   // Collision stuff
   u8 gravity_on, x_collision, y_collision;

   gravity_on = 0;
   x_collision = 0;
   y_collision = 0;

   vx = e->vx;
   vy = e->vy;

   if (vx | vy)
   {

      oldx = e->x;
      oldy = e->y;

      newx = oldx + vx;
      newy = oldy + vy;

      // CHANGE DIRECTION
      if (vx)
      {
         if (vx > 0)
         {
            e->direction = RIGHT_DIRECTION;
         }

         if ((vx & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
         {
            e->direction = LEFT_DIRECTION;
         }
      }

      sprite_W = e->sprite_W;
      sprite_H = e->sprite_H;
      half_sprite_H = sprite_H >> 1;

      // Check for gravity
      if (e->jump_info == 0xFF)
      {
         if (!check_tile_collision(newx, newy - 1 + sprite_H) && !check_tile_collision(newx + sprite_W, newy - 1 + sprite_H))
         {
            gravity_on = 1;
         }
         else
         {
            y_collision = 1;
            gravity_on = 0;
         }
      }

      // Check collisions in y axis
      if (vy && !gravity_on)
      {
         // Check collisions up
         if ((vy & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
         {
            if (check_tile_collision(newx, newy) || check_tile_collision(newx + sprite_W, newy))
            {
               y_collision = 1;
               e->jump_info = 0xFF;
            }
         }
         // Check collisions down
         else
         {
            if (check_tile_collision(newx, newy - 1 + sprite_H) || check_tile_collision(newx + sprite_W, newy - 1 + sprite_H))
            {
               y_collision = 1;
               e->jump_info = 0xFF;
            }
         }
      }

      // Check collisions in x axis only if there are not in the y axis
      if (vx)
      {

         // Check collisions to the left
         if ((vx & PHYSICS_IS_NEGATIVE) == PHYSICS_IS_NEGATIVE)
         {
            if (check_tile_collision(newx, newy) || check_tile_collision(newx, newy + half_sprite_H))
            {
               x_collision = 1;
            }
         }
         // Check collisions to the right
         else
         {
            if (check_tile_collision(newx - 1 + sprite_W, newy) || check_tile_collision(newx - 1 + sprite_W, newy + half_sprite_H))
            {
               x_collision = 1;
            }
         }
      }

      if (!x_collision)
      {
         e->x = newx;
      }

      if (!y_collision)
      {
         e->y = newy;
      }

      //Activates the active_movement flag
      e->messages_re_ph |= PHYSICS_HAS_MOVED;

      //Resets speed
      e->vx = 0;
      e->vy = gravity_on;
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
   gravity_on = 0;
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