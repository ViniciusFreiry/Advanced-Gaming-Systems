function initialize_iframes() {
	iframes = false;
	iframes_timer = 0;
}

function set_iframes(_frames = 120) {
	iframes_timer = _frames;
	iframes = true;
}

function run_iframes(_blink_frames = 5) {
	if(iframes_timer > 0) {
		iframes_timer--;
		if(iframes_timer % _blink_frames == 0) iframes = !iframes;
	} else iframes = false;
}

function is_iframes() {
	return iframes;
}