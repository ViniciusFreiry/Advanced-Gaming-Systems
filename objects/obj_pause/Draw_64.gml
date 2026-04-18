if(global.pause) {
	draw_pause();
	draw_inventory();
} else if(layer_exists("Pause_Effect")) layer_destroy("Pause_Effect");