if(variable_global_exists("hitstop") and global.hitstop) exit;

actual_life--;

var _life_percent = actual_life / max_life;

hspd = start_hspd * _life_percent;
vspd = start_vspd * _life_percent;

image_blend = merge_colour(final_colour, start_colour, clamp(_life_percent, 0, 1));

if(target_obj == noone) {
	image_alpha = _life_percent;
	image_xscale = original_scale * _life_percent;
	image_yscale = image_xscale;
	
	x += hspd;
	y += vspd;
} else {
	if(actual_life > 0) {
		image_alpha = (abs(hspd) + abs(vspd)) / (abs(start_hspd) + abs(start_vspd));
		image_xscale = original_scale;
		image_yscale = image_xscale;
		
		x += hspd;
		y += vspd;
	} else {
		_life_percent = (max_life + actual_life) / (max_life * 2);
		
		var _new_percent = (max_life + actual_life) / max_life,
		_x = target_obj.x + target_x_offset * target_obj.image_xscale,
		_y = target_obj.y + target_y_offset * target_obj.image_yscale;
		
		image_xscale = original_scale * 3 * _new_percent;
		image_yscale = original_scale / 3 * _new_percent;
		image_angle = point_direction(x, y, _x, _y);
		
		image_alpha = lerp(image_alpha, 1, 1 - _new_percent);
		x = lerp(x, _x, 1 - _new_percent);
		y = lerp(y, _y, 1 - _new_percent);
	}
}
	
if(_life_percent <= 0) instance_destroy();