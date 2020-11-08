#include "entity.h"

Entity_t  m_entities[MAX_ENTITIES];
u8 m_zero_type_at_the_end; 
Entity_t* m_next_free_entity;
u8 m_num_entities;

const Entity_t init_player = {
   e_type_player, // type
   50, 50,        // x, y
   0,             // vx
   0xFF,          // color
   0              // prevm
};

void man_entitiy_init(){
   cpct_memset(m_entities, 0, sizeof(m_entities));
   m_next_free_entity = m_entities;
   m_num_entities = 0;
   m_zero_type_at_the_end = e_type_invalid;
}

void man_entity_create_player(){
   Entity_t* e = man_entitiy_create();
   cpct_memcpy (e, &init_player, sizeof(Entity_t));    
}

Entity_t* man_entity_get_player(){
   return m_entities;
}

Entity_t* man_entitiy_create() {
   Entity_t* e = m_next_free_entity;
   m_next_free_entity = e +1;
   e -> type = e_type_default;
   ++m_num_entities;
   return e;
}

void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
   Entity_t* e = m_entities;
   while(e -> type != e_type_invalid){
      ptrfunc(e);
      ++e;
   }
}

void man_entity_destroy(Entity_t* dead_e){
   Entity_t* de = dead_e;
   Entity_t* last = m_next_free_entity;
   --last;
   if(de != last){
      cpct_memcpy(de, last, sizeof(Entity_t));
   }
   last -> type = e_type_invalid;
   m_next_free_entity = last;
   --m_num_entities;
}

void man_entity_set4destruction(Entity_t* dead_e){
   dead_e -> type |=  e_type_dead;
}

void man_entity_update() {
   Entity_t* e = m_entities;
   while(e -> type != e_type_invalid){
      if(e -> type & e_type_dead ){
         man_entity_destroy(e);
      }
      else{
         ++e;
      }
   }
}

u8 man_entity_freeSpace(){
   return MAX_ENTITIES - m_num_entities;
}