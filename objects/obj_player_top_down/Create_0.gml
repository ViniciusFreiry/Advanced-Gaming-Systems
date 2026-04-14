event_inherited();

up = false;
left = false;
down = false;
right = false;
spd = 5;

inputs = function() {
	up = keyboard_check(ord("W"));
	left = keyboard_check(ord("A"));
	down = keyboard_check(ord("S"));
	right = keyboard_check(ord("D"));
	
	if((left xor right) or (up xor down)) start_moving = true;
	else start_moving = false;
	
	dir = point_direction(0, 0, right - left, down - up);
}