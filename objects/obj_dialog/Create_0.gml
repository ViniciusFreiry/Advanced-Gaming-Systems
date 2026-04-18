dialog = noone;
index = 1;
page = 0;
player = noone;

scale = 0;

free_player = function() {
	if(player) with(player) change_state(idle_state, [sprite_index]);
}

draw_dialog = function(_dialog = dialog) {
	draw_set_font(fnt_dialog);
	
	static _gui_width = display_get_gui_width(),
	_gui_height = display_get_gui_height(),
	_marg = string_height("A"),
	_spr_box_width = sprite_get_width(spr_text_box);
	_spr_box_height = sprite_get_height(spr_text_box);
	
	var _xscale = _gui_width / _spr_box_width * scale,
	_yscale = (_gui_height * 0.3) / _spr_box_height,
	_text = string_copy(_dialog.text[page], 1, index),
	_text_length = string_length(_dialog.text[page]),
	_y = _gui_height - (_yscale * _spr_box_height),
	_portrait_height = sprite_get_height(_dialog.portrait[page]),
	_portrait_scale = (_gui_height * 0.2) / _portrait_height,
	_portrait_y = _y + _portrait_height * _portrait_scale / 4,
	_x = _portrait_scale * sprite_get_width(_dialog.portrait[page]) + _marg * 2;
	
	draw_sprite_ext(spr_text_box, 0, 0, _y, _xscale, _yscale, 0, c_white, 1);

	if(scale < 1) {
		scale = lerp(scale, 1.1, 0.05);
		return;
	} else scale = 1;
	
	if(index <= _text_length) index += _dialog.text_spd;
	
	draw_sprite_ext(_dialog.portrait[page], 0, _marg, _portrait_y, _portrait_scale, _portrait_scale, 0, c_white, 1);

	draw_text_ext(_x, _y + _marg, _text, _marg, _gui_width - _x + _marg);
	
	if(keyboard_check_pressed(vk_enter)) {
		if(index < _text_length) index = _text_length;
		else if(page < array_length(_dialog.text) - 1) {
			page++;
			index = 1;
		} else {
			free_player();
			instance_destroy();
		}
	}
}