global.pause = !global.pause;

if(global.pause) {
	with(obj_entity) {
		hspd = 0;
		vspd = 0;
		image_speed = 0;
	}
} else {
	with(obj_entity) image_speed = 1;
}