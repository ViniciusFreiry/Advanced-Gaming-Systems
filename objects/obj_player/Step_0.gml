if(global.pause) exit;

inputs();
state();

run_iframes();
if(get_timer_index(0)) {
	invencible = false;
	set_timer_value_index(0, 0);
}