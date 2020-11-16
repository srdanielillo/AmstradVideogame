#include "render.h"
#include "man/entity.h"
#include "sprites/agent.h"

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
    //TO-DO Realizar el borrado de pantalla conforme se muevan las entidades
    if(e->prevptr != 0) *(e->prevptr) = 0;
    if(!(e->type & e_type_dead)){
        u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
        cpct_drawSprite(e->sprite, pvmem, e->sprite_W, e->sprite_H);
    }
}

/*
   [INFO]            Renders an entity if it isn't dead
                     -  Gets the screen pointer that corresponds to the entity
                     -  Puts the sprite of the entitie in the place pointed by the screen pointer
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_one_entity(Entity_t* e) {
    //TO-DO Realizar el borrado de pantalla conforme se muevan las entidades
    if(e->prevptr != 0) *(e->prevptr) = 0;
    if(!(e->type & e_type_dead)){
        u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
        cpct_drawSprite(e->sprite, pvmem, e->sprite_W, e->sprite_H);
    }
}


/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Initialize the render system
                     -  Set's video mode to 0
                     -  Set border to HW_BLACK
                     -  Set the palette to the agent sprites palette  
   
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_init(){
   //TO-DO desacoplar tamanyo de la paleta y la paleta
   //TO-DO definir paleta en este fichero 
   cpct_setVideoMode(0);
   cpct_setBorder(HW_BLACK);
   cpct_setPalette(agent_pal, 16);
}


/*
   [INFO]            Calls sys_render_player and sys_render_one_entity
                      
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_render_update() {
    man_entity_forplayer ( sys_render_player );
    man_entity_forall ( sys_render_one_entity );
}