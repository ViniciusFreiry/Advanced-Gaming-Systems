persistent = true;
alarm[0] = 30;

start_second_transition = false;
blackout = false;
destiny_room = noone;

obj_aux = instance_create_depth(0, 0, 0, obj_square_aux);

run_transition(sq_square_transition_1);