x_buffer = x;
y_buffer = y;

target = noone;
cam_zoom = false;
view_scale = 1;
zoom_min_scale = 1;
zoom_max_scale = 1;
zoom_scale_jump = 0.1;

view_original_w = camera_get_view_width(view_camera[0]);
view_original_h = camera_get_view_height(view_camera[0]);

zoom = function() {
	if(!cam_zoom) return;
		
	if(mouse_wheel_up()) {
		view_scale = max(view_scale - zoom_scale_jump, zoom_min_scale);
		camera_set_view_size(view_camera[0], view_original_w * view_scale, view_original_h * view_scale);
	} else if(mouse_wheel_down()) {
		view_scale = min(view_scale + zoom_scale_jump, zoom_max_scale);
		camera_set_view_size(view_camera[0], view_original_w * view_scale, view_original_h * view_scale);
	}
}

stoped_state = function() {
	if(target != noone) state = chase_target_state;
}

chase_target_state = function() {
	if(instance_exists(target)) {
		x_buffer = lerp(x, target.x, 0.1);
		y_buffer = lerp(y, target.y, 0.1);
		
		x = round(x_buffer);
		y = round(y_buffer);
		
		var _view_w = camera_get_view_width(view_camera[0]),
		_view_h = camera_get_view_height(view_camera[0]);
		
		camera_set_view_pos(view_camera[0], clamp(x - _view_w / 2, 0, room_width - _view_w), clamp(y - _view_h / 2, 0, room_height - _view_h));
	} else {
		target = noone;
		state = stoped_state;
	}
}

state = stoped_state;