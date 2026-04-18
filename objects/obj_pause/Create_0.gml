display_set_gui_size(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));

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
	_selected_y = 0;
	
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
	_item_slot_height = (_item_height - _item_slot_marg_y * (_row + 1)) div _row;
	
	draw_sprite_stretched(spr_inventory_background, 0, _inv_x, _inv_y, _inv_width, _inv_height);
	
	draw_rectangle(_item_x, _item_y, _item_x + _item_width, _item_y + _item_height, true);
	
	draw_rectangle(_desc_x, _desc_y, _desc_x + _desc_width, _desc_y + _desc_height, true);
	
	
	
	_mouse_in_inventory = (_mouse_x == clamp(_mouse_x, _item_x, _item_x + _item_width) and _mouse_y == clamp(_mouse_y, _item_y, _item_y + _item_height));
	
	for(var _i = 0; _i < _row; _i++) {
		for(var _j = 0; _j < _column; _j++) {
			if(_mouse_in_inventory) {
				_selected_x = (_mouse_x - _item_x - (_item_slot_marg_x * (_j + 1))) div _item_slot_width;
				_selected_y = (_mouse_y - _item_y - (_item_slot_marg_y * (_i + 1))) div _item_slot_height;
			}
			
			_selected_x = clamp(_selected_x, 0, _column - 1);
			_selected_y = clamp(_selected_y, 0, _row - 1);
			
			var _x1 = _item_x + _item_slot_width * _j + _item_slot_marg_x * (_j + 1),
			_y1 = _item_y + _item_slot_height * _i + _item_slot_marg_y * (_i + 1),
			_selected = (_selected_x == _j and _selected_y == _i ? 1 : 0);
			
			draw_sprite_stretched(spr_inventory_box, _selected, _x1, _y1, _item_slot_width, _item_slot_height);
		}
	}
}