//TO-DO Incluir repintado en entidades que no sean el jugador
#include "render.h"
#include "man/entity.h"

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
void sys_render_entitie_first_time(Entity_t* e) {
    u8* ptr = e -> ptr;
    u8* sprite = e -> sprite;
    u8 sprite_H = e -> sprite_H;
    u8 sprite_W = e -> sprite_W;
    
    cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);
    
}

/*
   [INFO]            Renders entity 
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_update_entitie(Entity_t* e) {
    u8 message, sprite_H, sprite_W; 
    u8* ptr = e->ptr;
    u8* prevptr = e->prevptr;
    u8* sprite = e->sprite;
    
    message = e -> messages_re_ph;
    sprite_H = e -> sprite_H;
    sprite_W = e -> sprite_W;
    
    if((message & sys_render_should_render && message & sys_render_moved) || (e->type == e_type_player && message & sys_render_moved)){
        if(!(e->type & e_type_dead)){
            cpct_drawSpriteBlended(prevptr, sprite_H, sprite_W, sprite);
            cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);
            
            // Desactivate the flag so the next cicle the entity wont be rendered 
            e -> messages_re_ph &= sys_render_not_render;
        }
    }
    else{
        // Activates the flag so the next cicle the entity will be rendered
        e -> messages_re_ph |= sys_render_should_render;
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
void sys_render_update() {
    man_entity_for_all(sys_render_update_entitie);
}

/*
   [INFO]            Calls sys_render_entitie_first_time for each entitie
                      
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_first_time() {
    man_entity_for_all(sys_render_entitie_first_time);
}

