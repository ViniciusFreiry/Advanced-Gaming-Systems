grav = 0.3;
hspd = 0;
vspd = 0;
max_hspd = 5;
max_vspd = 10;
jumps_qtd = 2;
ground = false;

up = false;
left = false;
down = false;
right = false;

apply_spd = function() {
	ground = place_meeting(x, y + 1, obj_ground_platform);
	
	hspd = (right - left) * max_hspd;
	if(!ground) vspd = clamp(vspd + grav, -max_vspd, max_vspd);
}

move = function() {	
	var _hspd = sign(hspd),
	_vspd = sign(vspd),
	_abs_hspd = abs(hspd),
	_abs_vspd = abs(vspd);
	
	if(_abs_hspd >= 1) {
		repeat(_abs_hspd) {
			if(place_meeting(x + _hspd, y, obj_ground_platform) and !place_meeting(x + _hspd, y - 1, obj_ground_platform)) {
				y--;
			}
		
			if(!place_meeting(x + _hspd, y, obj_ground_platform) and 
			!place_meeting(x + _hspd, y + 1, obj_ground_platform) and
			place_meeting(x + _hspd, y + 2, obj_ground_platform)) {
				y++;
			}
			
			if(place_meeting(x + _hspd, y, obj_ground_platform)) {
				if(hspd >= 0) {
					if(place_meeting(ceil(x), y, obj_ground_platform)) x = floor(x);
					else x = ceil(x);
				} else {
					if(place_meeting(floor(x), y, obj_ground_platform)) x = ceil(x);
					else x = floor(x);
				}
			
				hspd = 0;
				break;
			}
		
			x += _hspd;
		}
	} else {
		x += hspd;
		
		var _ceil = ceil(x),
		_floor = floor(x);
		
		if(hspd >= 0) {
			if(place_meeting(_ceil, y, obj_ground_platform)) {
				x = _floor;
				hspd = 0;
			}
		} else {
			if(place_meeting(_floor, y, obj_ground_platform)) {
				x = _ceil;
				hspd = 0;
			}
		}
	}
	
	if(_abs_vspd >= 1) {
		repeat(_abs_vspd) {
			if(place_meeting(x, y + _vspd, obj_ground_platform)) {
				if(!place_meeting(x - 1, y + _vspd, obj_ground_platform)) x--;
				else if(!place_meeting(x + 1, y + _vspd, obj_ground_platform)) x++;
			}
			
			if(place_meeting(x, y + _vspd, obj_ground_platform)) {
				if(vspd >= 0) {
					if(place_meeting(x, ceil(y), obj_ground_platform)) y = floor(y);
					else y = ceil(y);
				} else {
					if(place_meeting(x, floor(y), obj_ground_platform)) y = ceil(y);
					else y = floor(y);
				}
		
				vspd = 0;
				break;
			}
		
			y += _vspd;
		}
	} else {
		y += vspd;
		
		var _ceil = ceil(y),
		_floor = floor(y);
		
		if(vspd >= 0) {
			if(place_meeting(x, _ceil, obj_ground_platform)) {
				y = _floor;
				vspd = 0;
			}
		} else {
			if(place_meeting(x, _floor, obj_ground_platform)) {
				y = _ceil;
				vspd = 0;
			}
		}
	}
}