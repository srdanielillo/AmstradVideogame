#include "entity.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/

/*
   [INFO] Entity that represents the player
*/
Entity_t*  m_player;

/*
   [INFO] Array of entities that are non-player
*/
Entity_t  m_entities[MAX_ENTITIES_NON_PLAYER];

/*
   [INFO] byte in memory to break the loop of man_entity_for_all
*/
u8 m_zero_type_at_the_end; 

/*
   [INFO] Pointer to the next free entity in the non-player entities array
*/
Entity_t* m_next_free_entity;

/*
   [INFO] Total number of non-player entitities
*/
u8 m_num_entities_non_player;

/*
   [INFO] Struct that represents the default values of the player
*/
const Entity_t init_player = {
   e_type_player,                // type
   50, 50,                       // x, y
   0,                            // vx
   agent_sp_0,                   // sprite
   AGENT_SP_0_W, AGENT_SP_0_H,   // sprite_size
   0,                            // prevm
   0,                            // jumping_index
   jump_table_in_site            // ptr to jump_table
};

/*
   [INFO]            Deletes an entity
                     -  Copies the data of the last entity into the entity to be deleted if they are different 
                     -  Puts the invalid type in the last entity of the non-player entities array
                     -  Repoints m_next_fre_entity
                     -  Decreases m_num_entities_non_player

   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
void man_entity_destroy(Entity_t* dead_e){
   Entity_t* de = dead_e;
   Entity_t* last = m_next_free_entity;
   --last;
   if(de != last){
      cpct_memcpy(de, last, sizeof(Entity_t));
   }
   last -> type = e_type_invalid;
   m_next_free_entity = last;
   --m_num_entities_non_player;
}


/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Initialize the manager of entities
                     -  Reserve memory to the player and non-players entities (MAX_ENTITIES_NON_PLAYER + 1)
                     -  Set m_num_entities_non_player to 0
                     -  Puts the value e_type_invalid in the m_zero_type_at_the_end to break the man_entity_for_all loop
   
   [PREREQUISITES]   This function has no prerequisites
*/
void man_entitiy_init(){
   //TO-DO Comprobar si es mas eficiente con 2 memset o 1 calculando los parametros
   cpct_memset(m_player, 0, sizeof(Entity_t));
   cpct_memset(m_entities, 0, sizeof(m_entities));
   m_next_free_entity = m_entities;
   m_num_entities_non_player = 0;
   m_zero_type_at_the_end = e_type_invalid;
}

/*
   [INFO]            Initialize the player entitie with default values
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
void man_entity_create_player(){
   Entity_t* e = m_player;
   cpct_memcpy (e, &init_player, sizeof(Entity_t));
   //TO-DO Cargar tabla de saltos al comienzo de cada nivel   
}

/*
   [INFO]            Gets the pointer to the player entity
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function

Entity_t* man_entity_get_player(){
   //TO-DO Comprobar si es mas eficiente con copia
   return m_player;
}
*/

/*
   [INFO]            Creates and entity in the non-player entitie array
                     -  Moves the m_next_free_entity pointer to the next empty non-player entity position
                     -  Puts the e_type_default value into the type atribute of the entity
                     -  Increases the m_num_entities_non_player counter
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
Entity_t* man_entitiy_create() {
   Entity_t* e = m_next_free_entity;
   m_next_free_entity = e +1;
   e -> type = e_type_default;
   ++m_num_entities_non_player;
   return e;
}

/*
   [INFO]            Applies the function passed as paremeter to all the non-player entities if they don't have an invalid type
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
void man_entity_forall( void (*ptrfunc)(Entity_t*) ) {
   Entity_t* e = m_entities;
   while(e -> type != e_type_invalid){
      ptrfunc(e);
      ++e;
   }
}

/*
   [INFO]            Applies the function passed as paremeter to the player entitie
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
void man_entity_forplayer( void (*ptrfunc)(Entity_t*) ) {
   Entity_t* e = m_player;
   ptrfunc(e);
}

/*
   [INFO]            Marks an entity to be deleted 
                     - Uses an OR logic door to activate the biggest bit of the type attribute  
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
void man_entity_set4destruction(Entity_t* dead_e){
   dead_e -> type |=  e_type_dead;
}

/*
   [INFO]            Deletes the entities that are marked as e_type_dead entities
                     - Uses and AND logic door to get > 0 if the entitie must be destroyed and 0 in other case
                     - Calls man_entity_destroy_function   
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
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

/*
   [INFO]            Returns the number of free entities left  
                     - Returns MAX_ENTITIES_NON_PLAYER - m_num_entities_non_player   
   
   [PREREQUISITES]   The function man_entity_init should be called before calling this function
*/
u8 man_entity_freeSpace(){
   return MAX_ENTITIES_NON_PLAYER - m_num_entities_non_player;
}