#include "entity.h"

Entity_t  m_entities[10];
Entity_t* m_next_free_entity;
u8 m_reserved_entities;

void man_entitiy_init(){
   cpct_memset(m_entities, 0, sizeof(m_entities));
   m_next_free_entity = &m_entities[0];
}

Entity_t* man_entitiy_create() {
   Entity_t* e = m_next_free_entity;
   m_next_free_entity = e +1;
   return e;
}