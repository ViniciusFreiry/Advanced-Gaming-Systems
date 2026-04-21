var _collisions = ds_list_create(),
_qtd = instance_place_list(x, y, obj_enemy_parent, _collisions, false);

for(var _i = 0; _i < _qtd; _i++) {
	if(ds_list_find_index(attacked_list, _collisions[| _i]) == -1) {
		if(_collisions[| _i] != owner) {
			ds_list_add(attacked_list, _collisions[| _i]);
		
			var _damage = (global.player_weapon != noone ? global.player_weapon.damage : 0);
		
			_collisions[| _i].take_damage(_damage);
			_collisions[| _i].dir = point_direction(x, y, _collisions[| _i].x, _collisions[| _i].y);
		}
	}
}

ds_list_destroy(_collisions);