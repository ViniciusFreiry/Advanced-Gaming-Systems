function create_weapon(_name, _desc, _spr, _damage, _spd) constructor {
	static _weapon_qtd = 0;
	
	my_id = _weapon_qtd++;
	name = _name;
	desc = _desc;
	spr = _spr;
	damage = _damage;
	spd = _spd;
}

enum Weapons {
	Wooden_Sword,
	Iron_Sword,
	Blood_Sword
}

var _a = new create_weapon("Wooden Sword", "A simple sword made of wood.", spr_sword, 1, 1),
_b = new create_weapon("Iron Sword", "A sword with a very sharp blade.", spr_sword, 2, 1),
_c = new create_weapon("Blood Sword", "A sword created from the entrails of all the monsters that were slain by it.", spr_sword, 4, 0.5);

global.weapons = ds_list_create();
ds_list_add(global.weapons, _a, _b, _c);