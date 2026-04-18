dialog = {
	text: ["undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined", "undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined undefined"],
	portrait: [spr_portrait_mage, spr_portrait_player],
	text_spd: 0.3
}

speak_box_width = 22;
speak_box_height = 28;

keyboard_set_map(vk_space, vk_enter);

dialog_area = function() {
	var _player = collision_rectangle(x - speak_box_width, y, x + speak_box_width, y + speak_box_height, obj_player, false, false);

	if(_player) {
		if(keyboard_check_pressed(vk_enter)) {
			with(_player) {
				if(state != event_state) {
					change_state(go_to_event_state, [spr_player_run_up]);
					go_to_x = other.x;
					go_to_y = other.y + 16;
					npc = other.id;
				}
			}
		}
		
		if(keyboard_check_pressed(vk_escape)) {
			with(_player) {
				if(state == event_state) change_state(idle_state, [sprite_index]);
			}
		}
		
		if(_player.state == _player.event_state) {
			with(_player) {
				face = 1;
			}
		}
	}
}