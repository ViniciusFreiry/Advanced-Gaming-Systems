global.hitstop = false;

function hitstop_use(_timer = 30) {
	if(!instance_exists(obj_hitstop_manager)) instance_create_depth(0, 0, 0, obj_hitstop_manager);
	
	global.hitstop = true;
	obj_hitstop_manager.timer_hitstop = _timer;
	stop_backgrounds(obj_hitstop_manager.bg_list);
}

function get_background() {
	var _layers = layer_get_all(),
	_qtd = array_length(_layers),
	_bgs = [];
	
	for(var _i = 0; _i < _qtd; _i++) {
		var _actual = _layers[_i],
		_bg = layer_background_get_id(_actual);
		
		if(_bg != -1) {
			var _name = layer_get_name(_actual);
			
			array_push(_bgs, _name);
		}
	}
	
	return _bgs;
}

function stop_backgrounds(_bg_list) {
	obj_hitstop_manager.bgs_hspd = [];
	obj_hitstop_manager.bgs_vspd = [];
	
	var _qtd = array_length(_bg_list);
	
	for(var _i = 0; _i < _qtd; _i++) {
		var _actual = _bg_list[_i],
		_hspd = layer_get_hspeed(_actual),
		_vspd =layer_get_vspeed(_actual);
		
		array_push(obj_hitstop_manager.bgs_hspd, _hspd);
		array_push(obj_hitstop_manager.bgs_vspd, _vspd);
		
		layer_hspeed(_actual, 0);
		layer_vspeed(_actual, 0);
	}
}

function run_backgrounds(_bg_list, _bgs_hspd, _bgs_vspd) {
	var _qtd = array_length(_bg_list);
	
	for(var _i = 0; _i < _qtd; _i++) {
		var _actual = _bg_list[_i],
		_hspd = _bgs_hspd[_i],
		_vspd = _bgs_vspd[_i];
		
		layer_hspeed(_actual, _hspd);
		layer_vspeed(_actual, _vspd);
	}
}