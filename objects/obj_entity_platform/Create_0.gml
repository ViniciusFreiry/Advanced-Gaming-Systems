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
	_vspd = sign(vspd);
	
	repeat(abs(hspd)) {
		if(place_meeting(x + _hspd, y, obj_ground_platform) and !place_meeting(x + _hspd, y - 1, obj_ground_platform)) {
			y--;
		}
		
		if(!place_meeting(x + _hspd, y, obj_ground_platform) and 
		!place_meeting(x + _hspd, y + 1, obj_ground_platform) and
		place_meeting(x + _hspd, y + 2, obj_ground_platform)) {
			y++;
		}
		
		if(place_meeting(x + _hspd, y, obj_ground_platform)) {
			if(place_meeting(ceil(x), y, obj_ground_platform)) x = floor(x);
			else x = ceil(x);
			
			hspd = 0;
			break;
		}
		
		x += _hspd;
	}
	
	repeat(abs(vspd)) {
		if(place_meeting(x, y + _vspd, obj_ground_platform)) {
			if(place_meeting(x, ceil(y), obj_ground_platform)) y = floor(y);
			else y = ceil(y);
		
			vspd = 0;
			break;
		}
		
		y += _vspd;
	}
}