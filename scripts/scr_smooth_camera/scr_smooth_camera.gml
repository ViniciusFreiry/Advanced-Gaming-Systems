function smooth_camera_set_target(_object = id, _cam_zoom = false, _zoom_min_scale = 0.5, _zoom_max_scale = 2, _zoom_scale_jump = 0.1) {
	if(!instance_exists(obj_smooth_camera)) instance_create_depth(_object.x, _object.y, 0, obj_smooth_camera);
	
	obj_smooth_camera.target = _object;
	
	if(_cam_zoom) {
		obj_smooth_camera.cam_zoom = true;
		obj_smooth_camera.zoom_min_scale = _zoom_min_scale;
		obj_smooth_camera.zoom_max_scale = _zoom_max_scale;
		obj_smooth_camera.zoom_scale_jump = _zoom_scale_jump;
	}
}