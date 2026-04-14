hspd = 0;
vspd = 0;
spd = 1;

dir = 0;
start_moving = false;

apply_spd = function() {
	if(start_moving) {
		hspd = lengthdir_x(spd, dir);
		vspd = lengthdir_y(spd, dir);
	} else {
		hspd = 0;
		vspd = 0;
	}
}

move = function() {
	if(place_meeting(x + hspd, y, obj_ground_top_down)) {
		var _hspd = sign(hspd);
		
		while(!place_meeting(x + _hspd, y, obj_ground_top_down)) x += _hspd;
		
		if(place_meeting(ceil(x), y, obj_ground_top_down)) x = floor(x);
		else x = ceil(x);
		
		hspd = 0;
	}
	
	x += hspd;
	
	if(place_meeting(x, y + vspd, obj_ground_top_down)) {
		var _vspd = sign(vspd);
		
		while(!place_meeting(x, y + _vspd, obj_ground_top_down)) y += _vspd;
		
		if(place_meeting(x, ceil(y), obj_ground_top_down)) y = floor(y);
		else y = ceil(y);
		
		vspd = 0;
	}
	
	y += vspd;
}