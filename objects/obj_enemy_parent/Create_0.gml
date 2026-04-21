event_inherited();

max_life = 2;
actual_life = max_life;
damage = 1;

spd = 3;

target_distance = 100;
target_x = 0;
target_y = 0;

initialize_shader_draw();
initialize_states_with_animation();
initialize_timer_system(4);
set_timers_cd([[FPS, FPS * 2], [FPS * 2, round(FPS) * 3], [FPS * 2, FPS * 2], [FPS / 2, FPS / 2], [FPS / 5, FPS / 5]]);

enum Enemy_Timer {
	Idle,
	Move,
	Attack_Cd,
	Attack_Charge,
	Damage
}

damage_state = function() {
	apply_spd();
	
	if(get_timer_index(Enemy_Timer.Damage)) {
		if(actual_life > 0) change_state(idle_state, [sprite_index]);
		else change_state(death_state, [sprite_index]);
	}
}

death_state = function() {
	hspd = 0;
	vspd = 0;
	
	image_speed = 0;
	
	if(image_alpha > 0) image_alpha -= 0.01;
	else instance_destroy();
}

take_damage = function(_damage = 1) {
	actual_life -= _damage;
	
	set_shader_draw(FPS / 5, c_white);
	change_state(damage_state, [sprite_index]);
}

damage_player = function() {
	var _player = instance_place(x, y, obj_player);
	
	if(_player) {
		_player.take_damage(damage);
		_player.dir = point_direction(x, y, _player.x, _player.y);
	}
}