function glow(_scale_multipli = 1.1, _colour = c_white, _alpha = 0.5) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * _scale_multipli, image_yscale * _scale_multipli, image_angle, _colour, _alpha);
	gpu_set_blendmode(bm_normal);	
}

function glow_ext(_sprite, _image_index = 0, _x = x, _y = y, _image_xscale = 1.1, _image_yscale = 1.1, _image_angle = 0, _colour = c_white, _alpha = 0.5) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(_sprite, _image_index, _x, _y, _image_xscale, _image_yscale, _image_angle, _colour, _alpha);
	gpu_set_blendmode(bm_normal);
}