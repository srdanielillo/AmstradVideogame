/** 
 * 
 *  AI SYSTEM BIT OPERATORS
 *  ---------------------
 *  - PATROL_CLEAN_STEP : Used to restart the patrol table
 * 
 **/
#define PATROL_CLEAN_STEP 0xF0

/** 
 * 
 *  PHYSICS SYSTEM BIT OPERATORS
 *  ---------------------
 *  - PHYSICS_NOT_MOVED          : Used to disable the has_moved flag (2nd bit)
 *  - PHYSICS_HAS_MOVED          : Used to enable the has_moved flag (2nd bit)
 *  - PHYSICS_IS_NEGATIVE : Used to check if a number is negative
 * 
 **/
#define PHYSICS_NOT_MOVED 0xFD
#define PHYSICS_HAS_MOVED 0x02
#define PHYSICS_IS_NEGATIVE 0xF0

/** 
 * 
 *  RENDER SYSTEM BIT OPERATORS
 *  ---------------------
 *  - RENDER_HAS_MOVED      : Used to check if the entity has moved this game cycle
 *  - RENDER_SHOULD_RENDER  : Used to check if the entity should be rendered this game cycle
 *  - RENDER_NOT_RENDER     : Used to disable the should_render flag (1st bit), so the next game cycle the entitie won't be rendered
 * 
 **/
#define RENDER_HAS_MOVED 0x02
#define RENDER_SHOULD_RENDER 0x01
#define RENDER_NOT_RENDER 0xFE

/**
 * 
 *  COLLISION SYSTEM OPERATORS 
 *
 **/
#define TILE_W 4
#define TILE_H 8