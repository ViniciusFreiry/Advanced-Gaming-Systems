function initialize_corner_correction(_pixels = (bbox_right - bbox_left) / 2) {
	corner_pixels = _pixels;
}

function check_corner_correction(_hit_the_ceil, _hspd, _vspd, _collisions) {
	if(_hit_the_ceil) {
		if(_vspd < 0) {
			if(_hspd >= 0) {
				for(var _i = 1; _i <= corner_pixels; _i++) {
					var _free = !place_meeting(x + _i, y + _vspd, _collisions);
				
					if(_free) {
						x += _i;
						return true;
					}
				}
			}
			
			if(_hspd <= 0) {
				for(var _i = 1; _i <= corner_pixels; _i++) {
					var _free = !place_meeting(x - _i, y + _vspd, _collisions);
				
					if(_free) {
						x -= _i;
						return true;
					}
				}
			}
		}
	}
	
	return false;
}