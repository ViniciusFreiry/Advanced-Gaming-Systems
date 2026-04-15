if (start_second_transition) {
    if (instance_exists(obj_square_aux)) alarm[1] = 1;
	else obj_aux = instance_create_depth(0, 0, 0, obj_square_aux);
}