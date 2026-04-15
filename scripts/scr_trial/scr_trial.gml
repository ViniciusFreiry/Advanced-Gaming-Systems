function create_trial(_obj = other, _sprite = other.sprite_index, _xscale = 1, _yscale = 1, _is_glow = false, _glow_colour = c_white, _glow_scale = 1.1, _glow_alpha = other.image_alpha * 0.5, _layer = other.layer) {
	var _trial = instance_create_layer(_obj.x, _obj.y, _layer, obj_trial, {
		sprite_index: _sprite,
		image_xscale: _xscale,
		image_yscale: _yscale
	});
	
	_trial.is_glow = _is_glow;
	_trial.glow_colour = _glow_colour;
	_trial.glow_scale = _glow_scale;
	_trial.glow_alpha = _glow_alpha;
}