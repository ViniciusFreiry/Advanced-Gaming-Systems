function initialize_shader_draw() {
	shader_draw = 0;
	shader_draw_start = 0;
	shader_draw_colour = c_white;
	shader_draw_alpha = 1;
	shader_draw_with_decrement = false;
}

function set_shader_draw(_frames, _colour = c_white, _alpha = 1, _shader_draw_with_decrement = false) {
	shader_draw = _frames;
	shader_draw_start = _frames;
	shader_draw_colour = _colour;
	shader_draw_alpha = _alpha;
	shader_draw_with_decrement = _shader_draw_with_decrement;
}

function run_shader_draw() {
	if(shader_draw > 0) shader_draw--;
	if(shader_draw < 0) shader_draw++;
}

function use_shader_draw(_draw_function = draw_self) {
	if(shader_draw != 0) {
		_draw_function();
		
		var _original_colour = image_blend,
		_original_alpha = image_alpha;
		
		image_blend = shader_draw_colour;
		
		if(shader_draw > 0) image_alpha *= shader_draw_alpha * shader_draw / shader_draw_start;
		else image_alpha *= shader_draw_alpha * (shader_draw_start - shader_draw) / shader_draw_start;
		
		shader_set(sh_shader_draw);
		_draw_function();
		shader_reset();
		
		image_blend = _original_colour;
		image_alpha = _original_alpha;
	} else {
		_draw_function();	
	}
}