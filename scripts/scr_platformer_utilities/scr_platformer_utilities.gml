function check_ground_in_front(_hspd, _sprite, _collisions) {
	return place_meeting(x + (sign(_hspd) * sprite_get_width(_sprite)), y + 1, _collisions);
}

function hit_the_ceil(_vspd, _collisions) {
	return place_meeting(x, y + sign(_vspd), _collisions);
}