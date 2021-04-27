#include "ai.h"

/*
*******************************************************
* PRIVATE SECTION
*******************************************************
*/


/*
   [INFO] Array of pointers that point to the corresponding jump_table
*/
Patrol_step_t* sys_ai_ptable_ptrs[PATROL_TABLES_NUMBER];

/*
   [INFO]            Applies the corresponding patrol step
                           
   [PREREQUISITES]   
*/
void sys_ai_update_patrol(Entity_t* e){

}

/*
   [INFO]            Applies the corresponding ai in function of the entity type
                           
   [PREREQUISITES]   The entity manager must be initialized before calling this function
*/
void sys_ai_update_entitie(Entity_t* e){
    u8 type = e -> type;

    if(type == e_type_enemy){
        sys_ai_update_patrol(e);
    }

}

/*
*******************************************************
* PUBLIC SECTION
*******************************************************
*/

/*
   [INFO]            Initializes the sys_ai_ptable_ptrs
                     
   [PREREQUISITES]   
*/
void sys_ai_init_patrol_tables(Patrol_step_t *ptr){
    cpct_memset(sys_ai_ptable_ptrs, 0, sizeof(sys_ai_ptable_ptrs));
    for(u8 i = 0; i < PATROL_TABLES_NUMBER; ++i){
        sys_ai_ptable_ptrs[i] = ptr;
        ptr += STEPS_PER_PATROL_TABLE;
    }
}


/*
   [INFO]            Calls sys_ai_update_entitie
                     
   [PREREQUISITES]   
*/
void sys_ai_update(){
    man_entity_for_entities( sys_ai_update_entitie );
}

