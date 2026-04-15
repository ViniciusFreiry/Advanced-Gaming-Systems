function initialize_stretch() {
	stretch_xscale = 1;
	stretch_yscale = 1;
}

function set_stretch(_xscale = 0.9, _yscale = 0.9) {
	stretch_xscale = _xscale;
	stretch_yscale = _yscale;
}

function run_stretch(_lerp_percentage = 0.1) {
	stretch_xscale = lerp(stretch_xscale, 1, _lerp_percentage);
	stretch_yscale = lerp(stretch_yscale, 1, _lerp_percentage);
}

function draw_stretch() {
	draw_sprite_ext(sprite_index, image_index, x, y, stretch_xscale * image_xscale, stretch_yscale * image_yscale, image_angle, image_blend, image_alpha);
}