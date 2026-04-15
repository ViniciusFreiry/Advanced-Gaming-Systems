if(blackout) {
    var _width = view_get_wport(view_current);
    var _height= view_get_hport(view_current);
	
    draw_set_color(c_black);
    draw_rectangle(0, 0, _width, _height, false);
    draw_set_color(-1);
}