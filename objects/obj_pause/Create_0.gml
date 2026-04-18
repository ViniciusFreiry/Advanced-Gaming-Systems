draw_pause = function() {
	var _width = display_get_gui_width(),
	_height = display_get_gui_height();
	
	draw_set_alpha(0.5);
	draw_rectangle_colour(0, 0, _width, _height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	
	if(!layer_exists("Pause_Effect")) {
		var _blur = fx_create("_filter_large_blur");
		
		layer_create(-10000, "Pause_Effect");
		fx_set_parameter(_blur, "g_Radius", 3);
		layer_set_fx("Pause_Effect", _blur);
	} 
}