//TO-DO Incluir repintado en entidades que no sean el jugador
#include "render.h"
#include "man/entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO]            Renders players entity
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_player(Entity_t* e) {
    
    if(!(e->type & e_type_dead)){
        u8* prevpvmem = e -> prevptr;
        u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e->x, e->y);
        if(prevpvmem) cpct_drawSpriteBlended(prevpvmem, e->sprite_H, e->sprite_W, e->sprite);
        cpct_drawSpriteBlended(pvmem, e->sprite_H, e->sprite_W, e->sprite);
        e -> prevptr = pvmem;
    }
    
}

/*
   [INFO]            Renders an entity if it isn't dead
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
// void sys_render_one_entity(Entity_t* e) {
//     //TO-DO Realizar el borrado de pantalla conforme se muevan las entidades
//     if(e->prevptr != 0) *(e->prevptr) = 0;
//     if(!(e->type & e_type_dead)){
//         u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
//         cpct_drawSprite(e->sprite, pvmem, e->sprite_W, e->sprite_H);
//     }
// }


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
    man_entity_forplayer ( sys_render_player );
    man_entity_forall ( sys_render_player );
}