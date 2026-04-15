if(variable_global_exists("hitstop") and global.hitstop) exit;

actual_life--;

var _life_percent = actual_life / max_life;

image_alpha = _life_percent;
image_blend = merge_colour(final_colour, start_colour, _life_percent);
image_xscale = original_scale * _life_percent;
image_yscale = image_xscale;

x += hspd * _life_percent * _life_percent;
y += vspd * _life_percent * _life_percent;

if (actual_life <= 0) instance_destroy();