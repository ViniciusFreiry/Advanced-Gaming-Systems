function screen_shake(_shake = 20) {
	if (!instance_exists(obj_screen_shake_manager)) instance_create_depth(0, 0, 0, obj_screen_shake_manager);
	
	with(obj_screen_shake_manager) {
		if (_shake > shake) shake = _shake;
	}
}