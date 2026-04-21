global.inventory[# 2, 2] = global.weapons[| Weapons.Wooden_Sword];
global.inventory[# 0, 1] = global.weapons[| Weapons.Iron_Sword];
global.inventory[# 0, 0] = global.weapons[| Weapons.Blood_Sword];

display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

draw_player_life = function(_x, _y) {
	var _w = sprite_get_width(spr_heart) / 1.75;
	
	for(var _i = 0; _i < global.max_player_life; _i += 2) {
		var _img = ((global.player_life - _i) != 1) + 1;
		
		draw_sprite(spr_heart, _img, _x + _w * _i, _y);
	}
}

draw_pause = function() {
	var _width = display_get_gui_width(),
	_height = display_get_gui_height();
	
	draw_set_alpha(0.5);
	draw_rectangle_colour(0, 0, _width, _height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	
	if(!layer_exists("Pause_Effect")) {
		var _blur = fx_create("_filter_large_blur");
		
		layer_create(-10000, "Pause_Effect");
		fx_set_parameter(_blur, "g_Radius", 3);
		layer_set_fx("Pause_Effect", _blur);
	} 
}

draw_inventory = function() {
	static _selected_x = 0,
	_selected_y = 0,
	_item_mouse = 0;
	
	var _gui_width = display_get_gui_width(),
	_gui_height = display_get_gui_height(),
	_mouse_x = device_mouse_x_to_gui(0),
	_mouse_y = device_mouse_y_to_gui(0),
	_mouse_in_inventory = false,
	_inv_width = _gui_width * 0.6,
	_inv_height = _gui_height * 0.6,
	_inv_x = (_gui_width - _inv_width) / 2,
	_inv_y = (_gui_height - _inv_height) / 2,
	_marg_x = _inv_width * 0.02,
	_marg_y = _inv_height * 0.04,
	_item_x = _inv_x + _marg_x,
	_item_y = _inv_y + _marg_y,
	_item_width = _inv_width * 0.7 - _marg_x,
	_item_height = _inv_height - _marg_y * 2,
	_desc_x = _item_x + _item_width + _marg_x,
	_desc_y = _item_y,
	_desc_width = _inv_width * 0.3 - _marg_x * 2,
	_desc_height = _item_height,
	_column = ds_grid_width(global.inventory),
	_row = ds_grid_height(global.inventory),
	_item_slot_marg_x = _item_width * 0.02,
	_item_slot_marg_y = _item_height * 0.02,
	_item_slot_width = (_item_width - _item_slot_marg_x * (_column + 1)) div _column,
	_item_slot_height = (_item_height - _item_slot_marg_y * (_row + 1)) div _row,
	_equip_x = _inv_x + (_inv_width - _item_slot_width) / 2,
	_equip_y = _inv_y - _item_slot_height;
	
	draw_sprite_stretched(spr_inventory_background, 0, _inv_x, _inv_y, _inv_width, _inv_height);
	
	draw_sprite_stretched(spr_inventory_box, 0, _equip_x, _equip_y, _item_slot_width, _item_slot_height);
	if(global.player_weapon) {
		var _equip_width = _item_slot_width * 0.5,
		_equip_height = _item_slot_height * 0.5;
	
		draw_sprite_stretched(global.player_weapon.spr, global.player_weapon.my_id, _equip_x + _equip_width / 2, _equip_y + _equip_height / 2, _equip_width, _equip_height);
	}
	
	_mouse_in_inventory = (_mouse_x == clamp(_mouse_x, _item_x, _item_x + _item_width) and _mouse_y == clamp(_mouse_y, _item_y, _item_y + _item_height));
	
	for(var _i = 0; _i < _row; _i++) {
		for(var _j = 0; _j < _column; _j++) {
			if(_mouse_in_inventory) {
				_selected_x = (_mouse_x - _item_x - (_item_slot_marg_x * _j)) div _item_slot_width;
				_selected_y = (_mouse_y - _item_y - (_item_slot_marg_y * _i)) div _item_slot_height;
			}
			
			_selected_x = clamp(_selected_x, 0, _column - 1);
			_selected_y = clamp(_selected_y, 0, _row - 1);
			
			var _x1 = _item_x + _item_slot_width * _j + _item_slot_marg_x * (_j + 1),
			_y1 = _item_y + _item_slot_height * _i + _item_slot_marg_y * (_i + 1),
			_selected = (_selected_x == _j and _selected_y == _i ? 1 : 0),
			_item_atual = global.inventory[# _j, _i];
			
			draw_sprite_stretched(spr_inventory_box, _selected, _x1, _y1, _item_slot_width, _item_slot_height);
		
			if(_item_atual) {
				var _item_atual_width = _item_slot_width * 0.5,
				_item_atual_height = _item_slot_height * 0.5,
				_item_atual_x = _x1 + _item_atual_width / 2,
				_item_atual_y = _y1 + _item_atual_height / 2;
				
				draw_sprite_stretched(_item_atual.spr, _item_atual.my_id, _item_atual_x, _item_atual_y, _item_atual_width, _item_atual_height);
			}
		}
	}
	
	if(_mouse_in_inventory) {
		if(mouse_check_button_released(mb_right)) {
			if(global.inventory[# _selected_x, _selected_y]) global.inventory[# _selected_x, _selected_y].use_item();
		}
				
		if(mouse_check_button_released(mb_left)) {
			_item_mouse = swap_item(_selected_x, _selected_y, _item_mouse);
		}
	} else {
		if(_item_mouse and mouse_check_button_released(mb_left)) {
			if(count_itens(global.player_weapon) > 0) {
				var _new_item = instance_create_layer(mouse_x, mouse_y, "Player", obj_item);
			
				_new_item.item = _item_mouse;
			
				_item_mouse = 0;
			}
		}
	}
	
	var _selected_atual = global.inventory[# _selected_x, _selected_y];
		
	if(_selected_atual) {
		var _selected_atual_spr_width = sprite_get_width(_selected_atual.spr),
		_selected_atual_width = _item_slot_width * 0.5,
		_selected_atual_height = _item_slot_height * 0.5,
		_selected_atual_x = _desc_x + _desc_width / 2,
		_selected_atual_y = _desc_y + _selected_atual_height / 2,
		_selected_atual_scale = _selected_atual_width / _selected_atual_spr_width;
		_effect_x = generate_sin_wave(2);
			
		draw_sprite_ext(_selected_atual.spr, _selected_atual.my_id, _selected_atual_x, _selected_atual_y, _selected_atual_scale * _effect_x, _selected_atual_scale, 0, c_white, 1);
			
		draw_set_font(fnt_inventory);
		draw_set_halign(fa_center);
		draw_text_ext_transformed(_selected_atual_x, _selected_atual_y + _selected_atual_height, _selected_atual.desc, string_height("A") * 0.5, _desc_width / 0.1, 0.1, 0.1, 0);
		draw_set_halign(-1);
	}
	
	if(_item_mouse) {
		draw_sprite_stretched(_item_mouse.spr, _item_mouse.my_id, _mouse_x, _mouse_y, _item_slot_width * 0.5, _item_slot_height * 0.5);
	}
}

swap_item = function(_x, _y, _item) {
	var _item_storage = global.inventory[# _x, _y];
	
	global.inventory[# _x, _y] = _item;
	
	return _item_storage;
}

count_itens = function(_item) {
	var _column = ds_grid_width(global.inventory),
	_row = ds_grid_height(global.inventory),
	_qtd = 0;
	
	for(var _i = 0; _i < _row; _i++) {
		for(var _j = 0; _j < _column; _j++) {
			if(global.inventory[# _j, _i] == _item) _qtd++;
		}
	}
	
	return _qtd;
}