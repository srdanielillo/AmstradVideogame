#include "physics.h"
#include "man/entity.h"

void sys_physics_update_one_entity(Entity_t *e){
    u8 newx = e->x + e->vx;
    //TODO marcar para destruir
    if(newx > e -> x){
        man_entity_destroy(e);
    }
    else{
        e->x = newx;
    }
}

void sys_phyisics_update(){
    man_entity_forall( sys_physics_update_one_entity );
}