#include "generator.h"
#include "man/entity.h"

const Entity_t init_e = {
   e_type_star,   // type
   79, 1,         // x, y
   -1,            // vx
   0xFF,          // color
   0              // prevm
};

void generateNewStar(){
   Entity_t* e = man_entitiy_create();
   cpct_memcpy (e, &init_e, sizeof(Entity_t));
   //TODO optimize module function
   e -> y   = cpct_rand() % 200;
   // Same as % 4
   e -> vx  = -1-(cpct_rand() & 0x03);
}

void sys_generator_update(){
    u8 free = man_entity_freeSpace();
    if(free){
        generateNewStar();
    }
}