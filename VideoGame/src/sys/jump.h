#pragma once
#include <cpctelera.h>

#define STEPS_PER_JUMP_TABLE  4
#define JUMP_TABLES           3

/*JUMP_TABLE VALUES          xy   */   
#define js_no_movement     0x00
#define js_up              0x0B 
#define js_down            0x03
#define js_up_right        0x3B
#define js_up_left         0xBB 
#define js_down_right      0x33
#define js_down_left       0xB3

//TO-DO Cambiar para que no se almacene el index
typedef struct jt {
    u8 steps[STEPS_PER_JUMP_TABLE];
    u8 index;    
} JumpTable_t;

void sys_jump_init();
void sys_jump_update();