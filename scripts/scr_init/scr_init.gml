randomise();

global.pause = false;
global.inventory = ds_grid_create(4, 4);
ds_grid_clear(global.inventory, 0);

global.max_player_life = 6;
global.player_life = global.max_player_life;