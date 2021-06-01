//TO-DO Incluir repintado en entidades que no sean el jugador
#include "render.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO]            Renders for first time an entity
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_entitie_first_time(Entity_t *e)
{
    u8 sprite_H = e->sprite_H;
    u8 sprite_W = e->sprite_W;
    u8 x = e->x, y = e->y;
    u8 *ptr = cpct_getScreenPtr(CPCT_VMEM_START, e->x, e->y);
    u8 *sprite = e->sprite;

    cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);
    e->prevptr = ptr;
}

/*
   [INFO]            Renders player 
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_update_player(Entity_t *e)
{
    u8 message, sprite_H, sprite_W, x, y;
    u8 *ptr, *sprite;

    message = e->messages_re_ph;
    sprite_H = e->sprite_H;
    sprite_W = e->sprite_W;
    x = e->x;
    y = e->y;

    if (message & RENDER_HAS_MOVED)
    {
        if (!(e->type & e_type_dead))
        {
            ptr = cpct_getScreenPtr(CPCT_VMEM_START, e->x, e->y);
            sprite = e->sprite;

            cpct_drawSpriteBlended(e->prevptr, sprite_H, sprite_W, sprite);
            cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);

            e->prevptr = ptr;
        }
    }

    // Changes the state of the render (If rendered last cycle the next cycle must not be rendered)
    if (e->messages_re_ph & RENDER_SHOULD_RENDER)
    {
        e->messages_re_ph &= RENDER_NOT_RENDER;
    }
    else
    {
        e->messages_re_ph |= RENDER_SHOULD_RENDER;
    }
}

/*
   [INFO]            Renders entity 
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_update_entitie(Entity_t *e)
{
    u8 message, sprite_H, sprite_W, x, y;
    u8 *ptr, *sprite;

    message = e->messages_re_ph;
    sprite_H = e->sprite_H;
    sprite_W = e->sprite_W;
    x = e->x;
    y = e->y;

    if ((message & RENDER_SHOULD_RENDER) && (message & RENDER_HAS_MOVED))
    {
        if (!(e->type & e_type_dead))
        {
            ptr = cpct_getScreenPtr(CPCT_VMEM_START, e->x, e->y);
            sprite = e->sprite;

            cpct_drawSpriteBlended(e->prevptr, sprite_H, sprite_W, sprite);
            cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);

            e->prevptr = ptr;
        }
    }

    // Changes the state of the render (If rendered last cycle the next cycle must not be rendered)
    if (e->messages_re_ph & RENDER_SHOULD_RENDER)
    {
        e->messages_re_ph &= RENDER_NOT_RENDER;
    }
    else
    {
        e->messages_re_ph |= RENDER_SHOULD_RENDER;
    }
}

/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Calls sys_render_player and sys_render_one_entity
                      
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_update()
{
    man_entity_for_player(sys_render_update_player);
    man_entity_for_entities(sys_render_update_entitie);
}

/*
   [INFO]            Calls sys_render_entitie_first_time for each entitie
                      
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_first_time()
{
    man_entity_for_all(sys_render_entitie_first_time);
}
