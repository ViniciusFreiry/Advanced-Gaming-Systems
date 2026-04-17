event_inherited();

spd = 3;

target_distance = 200;
target_x = 0;
target_y = 0;

initialize_states_with_animation();
initialize_timer_system(4);
set_timers_cd([[FPS, FPS * 2], [FPS * 2, round(FPS) * 3], [FPS * 2, FPS * 2], [FPS / 2, FPS / 2]]);

enum Enemy_Timer {
	Idle,
	Move,
	Attack_Cd,
	Attack_Charge
}

check_player_distance = function(_distance = target_distance) {
	return (instance_exists(obj_player) and point_distance(x, y, obj_player.x, obj_player.y) <= _distance);
}

idle_state = function() {
	change_sprite_with_animation();
	
	hspd = 0;
	vspd = 0;
	start_moving = false;
	
	if(get_timer_index(Enemy_Timer.Idle)) change_state(moving_state, [spr_enemy_moving]);
	if(get_timer_index(Enemy_Timer.Attack_Cd)) set_timer_value_index(Enemy_Timer.Attack_Cd, 0);
	
	if(check_player_distance()) {
		reset_timer_index(Enemy_Timer.Idle);
		change_state(moving_state, [spr_enemy_moving]);
	}
}

moving_state = function() {
	if(change_sprite_with_animation() and sprite_index == sprites_list[0]) {
		target_x = irandom(room_width);
		target_y = irandom(room_height);
	}
	
	start_moving = true;
	
	dir = point_direction(x, y, target_x, target_y);
		
	apply_spd();
		
	if(point_distance(x, y, target_x, target_y) <= spd) {
		x = target_x;
		y = target_y;
		hspd = 0;
		vspd = 0;
		reset_timer_index(Enemy_Timer.Move);
		change_state(idle_state, [spr_enemy_idle]);
	}
		
	if(get_timer_index(Enemy_Timer.Move)) {
		change_state(idle_state, [spr_enemy_idle]);
	}
	
	if(get_timer_index(Enemy_Timer.Attack_Cd)) set_timer_value_index(Enemy_Timer.Attack_Cd, 0);
	
	if(check_player_distance()) {
		reset_timer_index(Enemy_Timer.Move);
		change_state(chase_player_state, [spr_enemy_moving]);
	}
}

chase_player_state = function() {
	change_sprite_with_animation()
	
	apply_spd();
	
	if(check_player_distance(target_distance + 100)) {
		dir = point_direction(x, y, obj_player.x, obj_player.y);
		
		if(check_player_distance(target_distance) and get_timer_index(Enemy_Timer.Attack_Cd)) {
			change_state(attack_charge, [spr_enemy_idle]);
		}
	} else {
		change_state(idle_state, [spr_enemy_idle]);
	}
}

attack_charge = function() {
	change_sprite_with_animation();

	hspd = 0;
	vspd = 0;
	
	if(get_timer_index(Enemy_Timer.Attack_Charge)) {
		if(instance_exists(obj_player)) {
			target_x = obj_player.x;
			target_y = obj_player.y;
			dir = point_direction(x, y, target_x, target_y);	
		
			change_state(attack_player, [spr_enemy_moving]);
		} else {
			change_state(idle_state, [spr_enemy_idle]);
		}
	}
}

attack_player = function() {
	hspd = lengthdir_x(spd * 3, dir);
	vspd = lengthdir_y(spd * 3, dir);
	
	if(point_distance(x, y, target_x, target_y) < spd * 3 or !check_player_distance(target_distance * 2)) {
		change_state(idle_state, [spr_enemy_idle]);
	}
}

state = idle_state;