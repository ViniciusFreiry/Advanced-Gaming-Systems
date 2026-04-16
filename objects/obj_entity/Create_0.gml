x_buffer = x;
y_buffer = y;
hspd = 0;
vspd = 0;
spd = 1;

dir = 0;
start_moving = false;

apply_spd = function() {
	if(start_moving) {
		hspd = lengthdir_x(spd, dir);
		vspd = lengthdir_y(spd, dir);
	} else {
		hspd = 0;
		vspd = 0;
	}
}

move = function() {
	x_buffer += hspd;
	y_buffer += vspd;
	
	repeat(abs(round(x_buffer) - x)) {
		var _hspd = sign(hspd);
		
		if(place_meeting(x + _hspd, y, obj_ground)) {
			if(!place_meeting(x + _hspd, y - 1, obj_ground)) {
				x += _hspd;
				y--;
				y_buffer--;
				continue;
			} else if(!place_meeting(x + _hspd, y + 1, obj_ground)) {
				x += _hspd;
				y++;
				y_buffer++;
				continue;
			}
		}
		
		if(place_meeting(x + _hspd, y, obj_ground)) {
			hspd = 0;
			x_buffer = x;
			break;
		} else {
			x += _hspd;
		}
	}
	
	repeat(abs(round(y_buffer) - y)) {
		var _vspd = sign(vspd);
		
		if(place_meeting(x, y + _vspd, obj_ground)) {
			if(!place_meeting(x - 1, y + _vspd, obj_ground)) {
				x--;
				y += _vspd;
				x_buffer--;
				continue;
			} else if(!place_meeting(x + 1, y + _vspd, obj_ground)) {
				x++;
				y += _vspd;
				x_buffer++;
				continue;
			}
		}
		
		if(place_meeting(x, y + _vspd, obj_ground)) {
			vspd = 0;
			y_buffer = y;
			break;
		} else {
			y += _vspd;
		}
	}
}