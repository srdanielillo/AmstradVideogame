#include "man/shot.h"

Entity_t shot_entity_template;
Entity_t *ptr_shot_entity_template;

void man_shot_create_shot(Shot_data_t *shot_info)
{
    cpct_memcpy(ptr_shot_entity_template, shot_info, (sizeof(Shot_data_t) - 1));
    man_entity_populate_entity_data(ptr_shot_entity_template);
}

void man_shot_init(Entity_t *initializer)
{
    ptr_shot_entity_template = &shot_entity_template;
    cpct_memcpy(ptr_shot_entity_template, initializer, sizeof(Entity_t));
}