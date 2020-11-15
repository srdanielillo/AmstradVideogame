#include "render.h"
#include "man/entity.h"
#include "sprites/agent.h"


void sys_render_init(){
   cpct_setVideoMode(0);
   cpct_setBorder(HW_BLACK);
   cpct_setPalette(agent_pal, 16);
}

void sys_render_one_entity(Entity_t* e) {
    if(e->prevptr != 0) *(e->prevptr) = 0;
    if(!(e->type & e_type_dead)){
        u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
        cpct_drawSprite(e->sprite, pvmem, e->sprite_W, e->sprite_H);
    }
}

void sys_render_update() {
    man_entity_forall ( sys_render_one_entity );
}