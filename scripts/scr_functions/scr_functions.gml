function create_weapon(_name, _desc, _spr, _damage, _spd, _special) constructor {
	static _weapon_qtd = 0;
	
	my_id = _weapon_qtd++;
	name = _name;
	desc = _desc;
	spr = _spr;
	damage = _damage;
	spd = _spd;
	special = _special;
	
	use_item = function() {
		global.player_weapon = global.weapons[| my_id];
	}
	
	take_item = function() {
		var _column = ds_grid_width(global.inventory),
		_row = ds_grid_height(global.inventory);
		
		for(var _i = 0; _i < _row; _i++) {
			for(var _j = 0; _j < _column; _j++) {
				var _actual = global.inventory[# _j, _i];
				
				if(!_actual) {
					global.inventory[# _j, _i] = global.weapons[| my_id];
					
					return true;
				}
			}
		}
		
		return false;
	}
}

enum Weapons {
	Wooden_Sword,
	Iron_Sword,
	Blood_Sword
}

var _a = new create_weapon("Wooden Sword", "A simple sword made of wood.", spr_sword, 1, 1, iron_sword_special),
_b = new create_weapon("Iron Sword", "A sword with a very sharp blade.", spr_sword, 2, 1, iron_sword_special),
_c = new create_weapon("Blood Sword", "A sword created from the entrails of all the monsters that were slain by it.", spr_sword, 4, 0.5, iron_sword_special);

global.player_weapon = noone;
global.weapons = ds_list_create();
ds_list_add(global.weapons, _a, _b, _c);

function iron_sword_special(_owner = other.id) {
	var _layer = layer_create(_owner.depth, "Attack_Layer");
	
	var _new_sq = sequence_get(sq_attack_1),
	_sprites = [];
	
	with(_owner) {
		switch(face) {
			case 0:
				array_push(_sprites, spr_player_idle_down);
				array_push(_sprites, spr_player_attack_down);
				array_push(_sprites, spr_player_attack_down);
			break;
			
			case 1:
				array_push(_sprites, spr_player_idle_up);
				array_push(_sprites, spr_player_attack_up);
				array_push(_sprites, spr_player_attack_up);
			break;
			
			default:
				array_push(_sprites, spr_player_idle_right);
				array_push(_sprites, spr_player_attack_right);
				array_push(_sprites, spr_player_attack_right);
			break;
		}
	}
	
	_new_sq.tracks[0].keyframes[0].channels[0].spriteIndex = _sprites[0];
	_new_sq.tracks[2].keyframes[0].channels[0].spriteIndex = _sprites[1];
	_new_sq.tracks[1].keyframes[0].channels[0].spriteIndex = _sprites[2];
	
	return layer_sequence_create(_layer, _owner.x, _owner.y, _new_sq);
}