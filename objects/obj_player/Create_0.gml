event_inherited();

up = false;
left = false;
down = false;
right = false;
spd = 5;

my_acel = 0.1;
acel = 0.1;

inputs = function() {
	up = keyboard_check(ord("W"));
	left = keyboard_check(ord("A"));
	down = keyboard_check(ord("S"));
	right = keyboard_check(ord("D"));
	
	if((left xor right) or (up xor down)) start_moving = true;
	else start_moving = false;
	
	dir = point_direction(0, 0, right - left, down - up);
}

apply_spd = function() {
	var _ice = instance_place(x, y, obj_ice);
	
	if(_ice) acel = _ice.my_acel;
	else acel = my_acel;
	
	if(start_moving) {
		hspd = lerp(hspd, lengthdir_x(spd, dir), acel);
		vspd = lerp(vspd, lengthdir_y(spd, dir), acel);
	} else {
		hspd = lerp(hspd, 0, acel);
		vspd = lerp(vspd, 0, acel);
	}
}