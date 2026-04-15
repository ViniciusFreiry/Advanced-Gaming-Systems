enum Particles {
	SHOOT,
	POWER_UP
}

function create_particles(_layer_name, _type = Particles.SHOOT, _min_life = 20, _max_life = 40, _x = 0, _y = 0, _hspd = 0, _vspd = 0, _spd_extra_min = 0, _spd_extra_max = 3, _range_multiplier = 4, _min_qtd = 10, _max_qtd = 50, _start_colour = c_white, _final_colour = c_white, _part_scale = 0.2) {
	if(!instance_exists(obj_particle_manager)) instance_create_depth(0, 0, 0, obj_particle_manager);
	
	switch(_type) {
		case Particles.SHOOT:
			with(obj_particle_manager) {
				var _qtd = irandom_range(_min_qtd, _max_qtd),
				_dir = point_direction(0, 0, _hspd, _vspd),
				_spd = abs(_hspd) + abs(_vspd);
		
				repeat(_qtd) {
					var _part = instance_create_layer(_x + random(_hspd * _range_multiplier), _y + random(_vspd * _range_multiplier), _layer_name, obj_particle_shoot),
					_dir_part = _dir + random_range(-30, 30),
					_life = random_range(_min_life, _max_life),
					_part_spd = _spd + random_range(_spd_extra_min, _spd_extra_max);
					
					_part.hspd = lengthdir_x(_part_spd, _dir_part);
					_part.vspd = lengthdir_y(_part_spd, _dir_part);
					_part.max_life = _life;
					_part.actual_life = _life;
					_part.sprite_index = choose(spr_part_line, spr_part_star);
					_part.image_angle = _dir_part;
					_part.start_colour = _start_colour;
					_part.final_colour = _final_colour;
					_part.original_scale = random_range(_part_scale, _part_scale * 2.5);
					_part.image_xscale = _part.original_scale;
					_part.image_yscale = _part.original_scale;
				}
			}
		break;
		
		case Particles.POWER_UP:
			with(obj_particle_manager) {
				var _qtd = irandom_range(_min_qtd, _max_qtd),
				_spd = abs(_hspd) + abs(_vspd);
				
				repeat(_qtd) {
					var _part = instance_create_layer(_x + random(_hspd * _range_multiplier), _y + random(_vspd * _range_multiplier), _layer_name, obj_particle_power_up),
					_dir_part = random(359),
					_life = random_range(_min_life, _max_life),
					_part_spd = _spd + random_range(_spd_extra_min, _spd_extra_max);

					_part.hspd = lengthdir_x(_part_spd, _dir_part);
					_part.vspd = lengthdir_y(_part_spd, _dir_part);
					_part.start_hspd = _part.hspd;
					_part.start_vspd = _part.vspd;
					_part.max_life = _life;
					_part.actual_life = _life;
					_part.start_colour = _start_colour;
					_part.final_colour = _final_colour;
					_part.original_scale = random_range(_part_scale, _part_scale * 1.5);
					_part.image_xscale = _part.original_scale;
					_part.image_yscale = _part.original_scale;
					_part.image_angle = _dir_part;
				}
			}
		break;
	}
}

function set_target_power_up_particles(_obj, _x_offset = 0, _y_offset = 0) {
	with(obj_particle_power_up) {
		target_obj = _obj;
		target_x_offset = _x_offset;
		target_y_offset = _y_offset;
	}
}