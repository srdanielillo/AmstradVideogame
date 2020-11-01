#include "render.h"
#include "man/entity.h"

void sys_render_init(){
   cpct_setVideoMode(0);
   cpct_setBorder(HW_BLACK);
   cpct_setPALColour(0, HW_BLACK);
}

void sys_render_one_entity(Entity_t* e) {
    if(e->prevptr != 0) *(e->prevptr) = 0;
    if(!(e->type & e_type_dead)){
        u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
        *pvmem = e->color;
        e->prevptr = pvmem;
    }
}

void sys_render_update() {
    man_entity_forall ( sys_render_one_entity );
}