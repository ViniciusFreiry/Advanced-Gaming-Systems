x_buffer = x;
y_buffer = y;
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
	x_buffer += hspd;
	y_buffer += vspd;
	
	repeat(abs(round(x_buffer) - x)) {
		var _hspd = sign(hspd);
		
		if(place_meeting(x + _hspd, y, obj_ground_platform)) {
			hspd = 0;
			x_buffer = x;
			break;
		} else {
			x += _hspd;
		}
	}
	
	repeat(abs(round(y_buffer) - y)) {
		var _vspd = sign(vspd);
		
		if(place_meeting(x, y + _vspd, obj_ground_platform)) {
			vspd = 0;
			y_buffer = y;
			break;
		} else {
			y += _vspd;
		}
	}
}