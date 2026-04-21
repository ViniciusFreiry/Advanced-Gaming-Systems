event_inherited();

sprite_controll = function() {
	var _face = dir div 45;
	
	switch(_face) {
		case 0:
		case 7:
			sprite_index = spr_mushroom_jump_right;
			image_xscale = 1;
		break;
		
		case 1: case 2: sprite_index = spr_mushroom_jump_up; break;
		
		case 3:
		case 4:
			sprite_index = spr_mushroom_jump_right;
			image_xscale = -1;
		break;
		
		case 5: case 6: sprite_index = spr_mushroom_jump_down; break;
	}

	sprites_list[sprites_list_index] = sprite_index;
}

check_player_distance = function(_distance = target_distance) {
	return (instance_exists(obj_player) and point_distance(x, y, obj_player.x, obj_player.y) <= _distance);
}

idle_state = function() {
	change_sprite_with_animation();
	
	hspd = 0;
	vspd = 0;
	start_moving = false;
	
	if(get_timer_index(Enemy_Timer.Idle)) {
		target_x = irandom(room_width);
		target_y = irandom(room_height);
		
		change_state(moving_state, [spr_mushroom_jump_down]);
	}
	
	if(get_timer_index(Enemy_Timer.Attack_Cd)) set_timer_value_index(Enemy_Timer.Attack_Cd, 0);
	
	if(check_player_distance()) {
		target_x = irandom(room_width);
		target_y = irandom(room_height);
		
		reset_timer_index(Enemy_Timer.Idle);
		change_state(moving_state, [spr_mushroom_jump_down]);
	}
}

moving_state = function() {
	start_moving = true;
	
	dir = point_direction(x, y, target_x, target_y);
		
	apply_spd();
		
	if(point_distance(x, y, target_x, target_y) <= spd or place_meeting(x + hspd, y + vspd, obj_ground)) {
		hspd = 0;
		vspd = 0;
		reset_timer_index(Enemy_Timer.Move);
		change_state(idle_state, [spr_mushroom_jump_down]);
	}
		
	if(get_timer_index(Enemy_Timer.Move)) {
		change_state(idle_state, [spr_mushroom_jump_down]);
	}
	
	if(get_timer_index(Enemy_Timer.Attack_Cd)) set_timer_value_index(Enemy_Timer.Attack_Cd, 0);
	
	if(check_player_distance()) {
		reset_timer_index(Enemy_Timer.Move);
		change_state(chase_player_state, [spr_mushroom_jump_down]);
	}
}

chase_player_state = function() {
	change_sprite_with_animation()
	
	apply_spd();
	
	if(check_player_distance(target_distance * 1.5)) {
		dir = point_direction(x, y, obj_player.x, obj_player.y);
		
		if(check_player_distance(target_distance) and get_timer_index(Enemy_Timer.Attack_Cd)) {
			change_state(attack_charge, [spr_mushroom_jump_down]);
		}
	} else {
		change_state(idle_state, [spr_mushroom_jump_down]);
	}
	
	if(check_player_distance(20)) {
		hspd = 0;
		vspd = 0;
	}
}

attack_charge = function() {
	change_sprite_with_animation();

	hspd = 0;
	vspd = 0;
	
	image_blend = merge_colour(c_red, c_white, timers_list[Enemy_Timer.Attack_Charge] / timers_cd_list[Enemy_Timer.Attack_Charge][0]);
	
	if(get_timer_index(Enemy_Timer.Attack_Charge)) {
		image_blend = c_white;
		
		if(instance_exists(obj_player)) {
			target_x = obj_player.x;
			target_y = obj_player.y;
			dir = point_direction(x, y, target_x, target_y);	
		
			change_state(attack_player, [spr_mushroom_jump_down]);
		} else {
			change_state(idle_state, [spr_mushroom_jump_down]);
		}
	}
}

attack_player = function() {
	hspd = lengthdir_x(spd * 3, dir);
	vspd = lengthdir_y(spd * 3, dir);
	
	damage_player();
	
	if(point_distance(x, y, target_x, target_y) < spd * 3 or place_meeting(x + hspd, y + vspd, obj_ground)) {
		change_state(idle_state, [spr_mushroom_jump_down]);
	}
}

stop_state = function() {
	change_sprite_with_animation();
	
	hspd = 0;
	vspd = 0;
}

state = idle_state;