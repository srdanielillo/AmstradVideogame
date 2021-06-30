#include "collision.h"

void sys_collision_check_collision_entities(Entity_t *first_e, Entity_t *second_e)
{
}

void sys_collision_check_collision_player(Entity_t *player, Entity_t *entitie)
{
    if (entitie->type != e_type_shot && (player->messages_re_ph & PHYSICS_HAS_MOVED || entitie->messages_re_ph & PHYSICS_HAS_MOVED))
    {
        u8 player_x, player_y, player_scr_W, player_scr_H;
        u8 entitie_x, entitie_y, entitie_scr_W, entitie_scr_H;

        player_x = player->x;
        player_y = player->y;
        player_scr_W = player->sprite_W;
        player_scr_H = player->sprite_H;

        entitie_x = entitie->x;
        entitie_y = entitie->y;
        entitie_scr_W = entitie->sprite_W;
        entitie_scr_H = entitie->sprite_H;

        if (player_x < entitie_x + entitie_scr_W &&
            player_x + player_scr_W > entitie_x &&
            player_y < entitie_y + entitie_scr_H &&
            player_y + player_scr_H > entitie_y)
        {
            man_entity_set4destruction(player);
            cpct_setBorder(HW_BRIGHT_GREEN);
        }
    }
}

void sys_collision_update()
{
    man_entity_player_against_others(sys_collision_check_collision_player);
    man_entity_one_against_others(sys_collision_check_collision_entities);
}
