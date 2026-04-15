function initialize_input_buffer(_inputs_qtd = 1) {
	buffer_timer = game_get_speed(gamespeed_fps) / 10;
	actual_buffer_timer = [];
	
	for(var _i = 0; _i < _inputs_qtd; _i++) array_push(actual_buffer_timer, 0);
}

function set_buffer(_input, _index = 0) {
	actual_buffer_timer[_index] = (_input ? buffer_timer : actual_buffer_timer[_index]);
}

function run_buffer() {
	for(var _i = 0; _i < array_length(actual_buffer_timer); _i++) {
		if(actual_buffer_timer[_i] > 0) actual_buffer_timer[_i]--;
	}
}

function get_buffer(_index) {
	if(actual_buffer_timer[_index] > 0) return true;
	
	return false;
}