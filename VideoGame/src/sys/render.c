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
    // Change to use the macro
    u8 *ptr = cpct_getScreenPtr(CPCT_VMEM_START, e->x, e->y);

    cpct_drawSpriteBlended(ptr, e->sprite_H, e->sprite_W, e->sprite);
    e->prevptr = ptr;
    e->messages_re_ph &= 0x7F;
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
    u8 *ptr;

    // Animation stuff
    u8 last_direction, direction, animation_counter;

    message = e->messages_re_ph;
    sprite_H = e->sprite_H;
    sprite_W = e->sprite_W;
    x = e->x;
    y = e->y;

    direction = e->direction;
    last_direction = e->last_direction;
    animation_counter = e->animation_counter;

    if (!(e->type & e_type_dead))
    {
        ptr = cpct_getScreenPtr(CPCT_VMEM_START, e->x, e->y);

        cpct_drawSpriteBlended(e->prevptr, sprite_H, sprite_W, e->prevsprite);
        cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, e->sprite);

        e->prevptr = ptr;
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
    u8 *ptr;

    message = e->messages_re_ph;
    sprite_H = e->sprite_H;
    sprite_W = e->sprite_W;
    x = e->x;
    y = e->y;

    if (message & 0x80)
    {
        sys_render_entitie_first_time(e);
    }
    else if ((message & RENDER_SHOULD_RENDER) && (message & RENDER_HAS_MOVED))
    {

        ptr = cpct_getScreenPtr(CPCT_VMEM_START, e->x, e->y);

        cpct_drawSpriteBlended(e->prevptr, sprite_H, sprite_W, e->prevsprite);
        cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, e->sprite);

        e->prevptr = ptr;
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

void sys_render_last_time(Entity_t *e)
{
    u8 sprite_H, sprite_W;
    u8 *sprite, *prevptr;

    sprite = e->sprite;
    prevptr = e->prevptr;

    sprite_H = e->sprite_H;
    sprite_W = e->sprite_W;

    cpct_drawSpriteBlended(prevptr, sprite_H, sprite_W, sprite);
}