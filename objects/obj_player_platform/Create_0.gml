grav = 0.3;
hspd = 0;
vspd = 5;
max_hspd = 5;
max_vspd = 10;
jumps_qtd = 2;
ground = false;

up = false;
left = false;
down = false;
right = false;
jump = false;

inputs = function() {
	up = keyboard_check(ord("W"));
	left = keyboard_check(ord("A"));
	down = keyboard_check(ord("S"));
	right = keyboard_check(ord("D"));
	jump = keyboard_check_pressed(vk_space);
}

apply_spd = function() {
	ground = place_meeting(x, y + 1, obj_ground_platform);
	
	hspd = (right - left) * max_hspd;
	
	if(ground) jumps_qtd = 2;
	else {
		vspd = clamp(vspd + grav, -max_vspd, max_vspd);
	}
	
	if(jump and jumps_qtd > 0) {
		vspd = -max_vspd;
		jumps_qtd--;
	}
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
			hspd = 0;
			break;
		}
		
		x += _hspd;
	}
	
	repeat(abs(vspd)) {
		if(place_meeting(x, y + _vspd, obj_ground_platform)) {
			vspd = 0;
			break;
		}
		
		y += _vspd;
	}
}