if(global.pause) {
	draw_pause();
	draw_inventory();
} else {
	draw_player_life(20, 20);
	if(layer_exists("Pause_Effect")) layer_destroy("Pause_Effect");
}