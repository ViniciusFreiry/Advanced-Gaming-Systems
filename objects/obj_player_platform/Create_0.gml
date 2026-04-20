event_inherited();

jump = false;
jumps = 2;
jumps_qtd = 2;

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