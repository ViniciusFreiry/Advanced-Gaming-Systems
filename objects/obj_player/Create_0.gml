event_inherited();

smooth_camera_set_target();

#region Variables
up = false;
left = false;
down = false;
right = false;
attack = false;
shield = false;
dodge = false;

keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("M"), ord("C"));
keyboard_set_map(ord("L"), ord("Z"));
keyboard_set_map(ord("K"), ord("X"));

spd = 3;
dodge_spd = 5;
my_acel = 0.1;
acel = 0.1;

go_to_x = 0;
go_to_y = 0;

face = 0;

sprites_idle = [[spr_player_idle_down, spr_player_idle_up, spr_player_idle_right, spr_player_idle_right]];
sprites_run = [[spr_player_run_down, spr_player_run_up, spr_player_run_right, spr_player_run_right]];
sprites_attack = [[spr_player_attack_down, spr_player_attack_up, spr_player_attack_right, spr_player_attack_right]];
sprites_shield = [[spr_player_shield_down, spr_player_shield_up, spr_player_shield_right, spr_player_shield_right]];
sprites_dodge = [[spr_player_dodge_down, spr_player_dodge_up, spr_player_dodge_right, spr_player_dodge_right]];

initialize_states_with_animation();
#endregion

#region Functions
inputs = function() {
	up = keyboard_check(vk_up);
	left = keyboard_check(vk_left);
	down = keyboard_check(vk_down);
	right = keyboard_check(vk_right);
	attack = keyboard_check_pressed(ord("C"));
	shield = keyboard_check(ord("Z"));
	dodge = keyboard_check_pressed(ord("X"));
	
	if((left xor right) or (up xor down)) {
		switch(state) {
			case dodge_state: break;
			
			default: dir = point_direction(0, 0, right - left, down - up);
		}
	}
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

change_face = function() {
	if(down and !up) face = 0;
	else if(up and !down) face =	1;
	
	if(right and !left) face = 2;
	else if(left and !right) face = 3;
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
	if(change_sprite_with_animation()) {
		hspd = 0;
		vspd = 0;
	}
	
	change_self_sprite(sprites_idle);
	
	start_moving = true;
	
	if((left xor right) or (up xor down)) change_state(moving_state, [spr_player_run_down]);
	
	if(attack) change_state(attack_state, [spr_player_attack_down]);
	
	if(shield) change_state(shield_state, [spr_player_shield_down]);
	
	if(dodge) change_state(dodge_state, [spr_player_dodge_down]);
}

moving_state = function() {
	change_sprite_with_animation();
	
	change_face();
	change_self_sprite(sprites_run);
	
	start_moving = true;
	
	if(!(left xor right) and !(up xor down)) {
		start_moving = false;
		if(abs(hspd) <= 0.1 and abs(vspd) <= 0.1) change_state(idle_state, [spr_player_idle_down]);
	}
	
	apply_spd();
	
	if(attack) change_state(attack_state, [spr_player_attack_down]);
	
	if(shield) change_state(shield_state, [spr_player_shield_down]);
	
	if(dodge) change_state(dodge_state, [spr_player_dodge_down]);
}

attack_state = function() {
	if(change_sprite_with_animation()) {
		hspd = 0;
		vspd = 0;
	}
	
	change_self_sprite(sprites_attack);
	
	if(animation_end()) change_state(idle_state, [spr_player_idle_down]);
}

shield_state = function() {
	if(change_sprite_with_animation()) {
		hspd = 0;
		vspd = 0;
	}
	
	change_face();
	change_self_sprite(sprites_shield);
	
	if(!shield) change_state(idle_state, [spr_player_idle_down]);
}

dodge_state = function() {
	change_sprite_with_animation();
	
	hspd = lengthdir_x(dodge_spd, dir);
	vspd = lengthdir_y(dodge_spd, dir);
	
	change_self_sprite(sprites_dodge);
	
	if(animation_end()) change_state(idle_state, [spr_player_idle_down]);
}

event_state = function() {
	change_sprite_with_animation();
	change_self_sprite(sprites_idle);
}

go_to_event_state = function() {
	change_sprite_with_animation();
	
	dir = point_direction(x, y, go_to_x, go_to_y);
	
	hspd = lengthdir_x(spd / 2, dir);
	vspd = lengthdir_y(spd / 2, dir);
	
	var _face = dir div 45;
	
	switch(_face) {
		case 0:
		case 7:
			face = 2;
			image_xscale = 1;
		break;
		
		case 1: case 2: face = 1; break;
		
		case 3:
		case 4:
			face = 3;
			image_xscale = -1;
		break;
		
		case 5: case 6: face = 0; break;
	}
	
	change_self_sprite(sprites_run);
	
	if(point_distance(x, y, go_to_x, go_to_y) <= spd / 2) {
		hspd = 0;
		vspd = 0;
		x = go_to_x;
		y = go_to_y;
		x_buffer = x;
		y_buffer = y;
		
		change_state(event_state, [spr_player_idle_down]);
	}
}

state = idle_state;
#endregion