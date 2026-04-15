function sound_pitch_variation(_audio, _pitch_var = 0, _gain = 1, _priority = 0, _loops = false, _offset = 0) {
	audio_play_sound(_audio, _priority, _loops, _gain, _offset, random_range(1 - _pitch_var, 1 + _pitch_var));
}