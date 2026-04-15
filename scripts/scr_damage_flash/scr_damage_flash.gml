function damage_flash(_colour = c_white, _frames_duration = 3) {
	var _flash = instance_create_depth(0, 0, -1, obj_damage_flash, {
		image_blend: _colour,
		image_alpha: _frames_duration / 10
	});
	
	_flash.image_xscale = camera_get_view_width(view_current) / sprite_width;
	_flash.image_yscale = camera_get_view_height(view_current) / sprite_height;
}