function set_square_transition(_destino = noone) {
    if(!room_exists(_destino)) return;
    
    instance_create_depth(0, 0, 0, obj_square_transition).destiny_room = _destino;
}

function run_transition(_sq) {
    if(!layer_exists("Package_Transition")) layer_create(-100, "Package_Transition");
    
    var _cam_x = camera_get_view_x(view_camera),
	_cam_y = camera_get_view_y(view_camera),
	_cam_width = camera_get_view_width(view_camera),
	_cam_height = camera_get_view_height(view_camera),
	_sq_1 = layer_sequence_create("Package_Transition", _cam_x, _cam_y, _sq),
	_sq_width = 320,
	_sq_height = 180;
	
	switch(_sq) {
		case sq_square_transition_1:
		case sq_square_transition_2:
			_sq_width = 320;
			_sq_height = 180;
		break;
	}
	
	layer_sequence_xscale(_sq_1, _cam_width / _sq_width);
	layer_sequence_yscale(_sq_1, _cam_height / _sq_height);
}

function destroy_transition_layer() {
    if(layer_exists("Package_Transition")) layer_destroy("Package_Transition");
}