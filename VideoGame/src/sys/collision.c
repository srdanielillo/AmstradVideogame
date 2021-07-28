#include "collision.h"

void sys_collision_check_collision_shots(Entity_t *shot, Entity_t *enemy)
{
    u8 shot_x, shot_y, shot_scr_W, shot_scr_H;
    u8 enemy_x, enemy_y, enemy_scr_W, enemy_scr_H;

    shot_x = shot->x;
    shot_y = shot->y;
    shot_scr_W = shot->sprite_W;
    shot_scr_H = shot->sprite_H;

    enemy_x = enemy->x;
    enemy_y = enemy->y;
    enemy_scr_W = enemy->sprite_W;
    enemy_scr_H = enemy->sprite_H;

    if (shot_x < enemy_x + enemy_scr_W &&
        shot_x + shot_scr_W > enemy_x &&
        shot_y < enemy_y + enemy_scr_H &&
        shot_y + shot_scr_H > enemy_y)
    {
        man_entity_set4destruction(shot);
    }
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
        }
    }
}

void sys_collision_update()
{
    man_entity_player_against_others(sys_collision_check_collision_player);
    man_entity_one_against_others(sys_collision_check_collision_shots);
}
