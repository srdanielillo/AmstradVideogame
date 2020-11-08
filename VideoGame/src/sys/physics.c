#include "physics.h"
#include "man/entity.h"

void sys_physics_update_one_entity(Entity_t *e){
    i8 newx = e->x + e->vx;
    e->x = newx;
    if(newx > 80 || newx < 0){
        man_entity_set4destruction(e);
    }
    //e->x = newx;
}

void sys_phyisics_update(){
    man_entity_forall( sys_physics_update_one_entity );
}