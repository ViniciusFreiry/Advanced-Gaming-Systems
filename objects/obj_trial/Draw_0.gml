if (is_glow) {
	gpu_set_blendmode(bm_add);
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * glow_scale, image_yscale * glow_scale, image_angle, glow_colour, glow_alpha);
	gpu_set_blendmode(bm_normal);
} else {
	draw_self();
}