if (shake > 0.1) {
	var _x = random_range(-shake, shake),
	_y = random_range(-shake, shake);
	
	view_set_xport(view_current, _x);
	view_set_yport(view_current, _y);
} else {
	shake = 0;
	
	view_set_xport(view_current, shake);
	view_set_yport(view_current, shake);
}

shake = lerp(shake, 0, 0.1);