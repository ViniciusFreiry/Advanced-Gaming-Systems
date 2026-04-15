bg_list = get_background();
bgs_hspd = [];
bgs_vspd = [];

timer_hitstop = 0;

undo_hitstop = function() {
	if (!global.hitstop) return;
	
	timer_hitstop--;
	
	with(all) {
		if (image_speed != 0) image_spd = image_speed;
		image_speed = 0;
	}
	
	if (timer_hitstop <= 0) {
		global.hitstop = false;
	
		run_backgrounds(bg_list, bgs_hspd, bgs_vspd);
	
		with(all) {
			image_speed = (variable_instance_exists(id, "image_spd") ? image_spd : 0);
		}
	}
}