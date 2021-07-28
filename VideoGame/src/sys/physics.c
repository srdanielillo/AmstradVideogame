#include "physics.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

u8 gravity_on;
/* Activated when the player collisions with a door to enter the next level*/
u8 door_collision;

/* Actual tilemap to check colisions with */
u8 *level_tilemap;

/*
   [INFO]            Applies physics to the player entity and mark it to destroy when it meet one of this conditions
                     -  The player gets out the screen after applying vy      
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/

void sys_phyisics_update_entitie(Entity_t *e)
{
   u8 newx, newy, newvx, newvy, scr_w;

   newvx = e->vx;
   newvy = e->vy;

   if (newvx | newvy)
   {
      scr_w = e->sprite_W;

      newx = e->x;
      newy = e->y;

      newx += newvx;
      newy += newvy;

      if (newvx)
      {
         e->last_direction = e->direction;
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

   if (linear_tile_index > 499)
   {
      return 0x00;
   }

   tile_number = level_tilemap[linear_tile_index];

   if (tile_number > 0 && tile_number < 8)
   {
      return 0x01;
   }
   else if (tile_number == 15)
   {
      door_collision = 1;
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

   cpct_setBorder(HW_BLACK);
   gravity_on = 0;
   door_collision = 0;
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
         e->last_direction = e->direction;
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

      if (newy + sprite_H > 216)
      {
         man_entity_set4destruction(e);
      }

      // Check for gravity
      if ((u16)e->jump_table == 0xFFFF)
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
               e->jump_table = (Jump_step_t *)0xFFFF;
            }
         }
         // Check collisions down
         else
         {
            if (check_tile_collision(newx, newy - 1 + sprite_H) || check_tile_collision(newx + sprite_W, newy - 1 + sprite_H))
            {
               y_collision = 1;
               e->jump_table = (Jump_step_t *)0xFFFF;
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
   door_collision = 0;
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

void sys_phyisics_set_tilemap(u8 *tilemap)
{
   level_tilemap = tilemap;
}

u8 sys_physics_door_collision()
{
   return door_collision;
}