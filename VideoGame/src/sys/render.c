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
    //TO-DO Hacerlo con un memcopy
    u8 message, sprite_H, sprite_W; 
    u8* ptr = e->ptr;
    u8* prevptr = e->prevptr;
    u8* sprite = e->sprite;
    
    message = e -> messages_re_ph;
    sprite_H = e -> sprite_H;
    sprite_W = e -> sprite_W;
    
    if(message & render_first_time){
        cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);
        //Desactivate first_time_render flag in message attribute 
        e -> messages_re_ph = message - render_first_time;
    }
    if(message & render_has_moved){
        if(!(e->type & e_type_dead)){
            cpct_drawSpriteBlended(prevptr, sprite_H, sprite_W, sprite);
            cpct_drawSpriteBlended(ptr, sprite_H, sprite_W, sprite);
            //Desactivate first_time_render flag in message attribute 
            e -> messages_re_ph = message - render_has_moved;
        }
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