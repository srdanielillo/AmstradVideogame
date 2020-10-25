#include "render.h"
#include "man/entity.h"

void sys_render_one_entity(Entity_t* e) {
    u8* pvmem = cpct_getScreenPtr (CPCT_VMEM_START, e-> x, e->y);
    *pvmem = e->color;
}

void sys_render_update() {
    man_entity_forall ( sys_render_one_entity );
}