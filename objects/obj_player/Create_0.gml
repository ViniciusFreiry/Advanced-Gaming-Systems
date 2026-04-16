event_inherited();

#region Variables
up = false;
left = false;
down = false;
right = false;
spd = 5;

my_acel = 0.1;
acel = 0.1;

face = 0;

sprites_idle = [[spr_player_idle_down, spr_player_idle_up, spr_player_idle_right, spr_player_idle_right]];
sprites_run = [[spr_player_run_down, spr_player_run_up, spr_player_run_right, spr_player_run_right]];

initialize_states_with_animation();
#endregion

#region Functions
inputs = function() {
	up = keyboard_check(ord("W"));
	left = keyboard_check(ord("A"));
	down = keyboard_check(ord("S"));
	right = keyboard_check(ord("D"));
	
	if((left xor right) or (up xor down)) {
		start_moving = true;
		dir = point_direction(0, 0, right - left, down - up);
	} else start_moving = false;
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

change_self_sprite = function(_array = sprites_idle) {
	sprite_index = _array[sprites_list_index][face];
	sprites_list[sprites_list_index] = sprite_index;
	
	switch(face) {
		case 2: image_xscale = 1; break;
		case 3: image_xscale = -1; break;
	}
}
#endregion

#region State Functions
idle_state = function() {
	change_sprite_with_animation();
	
	change_self_sprite(sprites_idle);
	
	hspd = 0;
	vspd = 0;
	
	if((left xor right) or (up xor down)) change_state(moving_state, [spr_player_run_down]);
}

moving_state = function() {
	change_sprite_with_animation();
	
	if(down and !up) face = 0;
	else if(up and !down) face =	1;
	
	if(right and !left) face = 2;
	else if(left and !right) face = 3;
	
	change_self_sprite(sprites_run);
	
	start_moving = true;
	
	if(!(left xor right) and !(up xor down)) {
		start_moving = false;
		if(abs(hspd) <= 0.1 and abs(vspd) <= 0.1) change_state(idle_state, [spr_player_idle_down]);
	}
	
	apply_spd();
}

state = idle_state;
#endregion