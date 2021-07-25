#include "animation.h"

void sys_animation_update_player(Entity_t *e)
{
    u8 direction, last_direction, animation_counter;

    if (!(e->type & e_type_dead))
    {
        direction = e->direction;
        last_direction = e->last_direction;
        animation_counter = e->animation_counter;
        e->prevsprite = e->sprite;

        if (e->messages_re_ph & RENDER_HAS_MOVED)
        {
            if (direction != last_direction)
            {
                if (direction == RIGHT_DIRECTION)
                {
                    e->sprite = e->sprites_array[SPRITE_R0];
                    e->animation_counter = 0;
                }
                else
                {
                    e->sprite = e->sprites_array[SPRITE_L0];
                    e->animation_counter = 0;
                }
            }
            else
            {
                if (direction == RIGHT_DIRECTION)
                {
                    if (animation_counter)
                    {
                        e->sprite = e->sprites_array[SPRITE_R0];
                        e->animation_counter = 0;
                    }
                    else
                    {
                        e->sprite = e->sprites_array[SPRITE_R1];
                        e->animation_counter = 1;
                    }
                }
                else
                {
                    if (animation_counter)
                    {
                        e->sprite = e->sprites_array[SPRITE_L0];
                        e->animation_counter = 0;
                    }
                    else
                    {
                        e->sprite = e->sprites_array[SPRITE_L1];
                        e->animation_counter = 1;
                    }
                }
            }
        }
        else
        {
            if (direction == RIGHT_DIRECTION)
            {
                if (animation_counter)
                {
                    e->sprite = e->sprites_array[SPRITE_IR0];
                    e->animation_counter = 0;
                }
                else
                {
                    e->sprite = e->sprites_array[SPRITE_IR1];
                    e->animation_counter = 1;
                }
            }
            else
            {
                if (animation_counter)
                {
                    e->sprite = e->sprites_array[SPRITE_IL0];
                    e->animation_counter = 0;
                }
                else
                {
                    e->sprite = e->sprites_array[SPRITE_IL1];
                    e->animation_counter = 1;
                }
            }
        }
    }
}

void sys_animantion_update_entitie(Entity_t *e)
{
    u8 direction, last_direction, animation_counter, type;

    if (!(e->type & e_type_dead) && (e->messages_re_ph & RENDER_SHOULD_RENDER))
    {
        type = e->type;
        direction = e->direction;
        last_direction = e->last_direction;
        animation_counter = e->animation_counter;
        e->prevsprite = e->sprite;

        if (type == e_type_enemy)
        {

            if (e->messages_re_ph & RENDER_HAS_MOVED)
            {
                if (direction != last_direction)
                {
                    if (direction == RIGHT_DIRECTION)
                    {
                        e->sprite = e->sprites_array[SPRITE_R0];
                        e->animation_counter = 0;
                    }
                    else
                    {
                        e->sprite = e->sprites_array[SPRITE_L0];
                        e->animation_counter = 0;
                    }
                }
                else
                {
                    if (direction == RIGHT_DIRECTION)
                    {
                        if (animation_counter)
                        {
                            e->sprite = e->sprites_array[SPRITE_R0];
                            e->animation_counter = 0;
                        }
                        else
                        {
                            e->sprite = e->sprites_array[SPRITE_R1];
                            e->animation_counter = 1;
                        }
                    }
                    else
                    {
                        if (animation_counter)
                        {
                            e->sprite = e->sprites_array[SPRITE_L0];
                            e->animation_counter = 0;
                        }
                        else
                        {
                            e->sprite = e->sprites_array[SPRITE_L1];
                            e->animation_counter = 1;
                        }
                    }
                }
            }
        }
        else if (e->type == e_type_shot)
        {
            if (direction == RIGHT_DIRECTION)
            {
                e->sprite = e->sprites_array[SPRITE_R0];
            }
            else
            {
                e->sprite = e->sprites_array[SPRITE_L0];
            }
        }
    }
}

void sys_animation_init()
{
}

void sys_animation_update()
{
    man_entity_for_player(sys_animation_update_player);
    man_entity_for_entities(sys_animantion_update_entitie);
}