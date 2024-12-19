/// @function audio_play_sfx(sound)
/// @param sound
function audio_play_sfx(soundid) {
	audio_stop_sound(argument[0]);
	audio_play_sound(argument[0], 0, 0);
}