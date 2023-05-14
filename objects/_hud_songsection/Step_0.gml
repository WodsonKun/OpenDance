/// @description Keyboard logic
if (keyboard_check_released(vk_left)) {
	if (select_index <= 0) {
		select_index = (array_length_1d(songsArray) - 1)
	}
	else {
		select_index -= 1
	}
}
else if (keyboard_check_released(vk_right)) {
	if (select_index >= (array_length_1d(songsArray) - 1)) {
		select_index = 0
	}
	else {
		select_index += 1
	}
}

// Checks if a audiopreview exists and plays it
if (audio_exists(global.publishedSongAudioPreview[select_index])) {
	if (!audio_is_playing(global.publishedSongAudioPreview[select_index])) {
		if (select_index != select_index) {
			audio_play_sound(global.publishedSongAudioPreview[select_index], 0, 1);
		}
	}
	else {
		if (select_index != select_index) {
			audio_stop_sound(global.publishedSongAudioPreview[select_index]);
			audio_play_sound(global.publishedSongAudioPreview[select_index], 0, 1);
		}
	}
}

// Go to the danceroom
if (keyboard_check_released(vk_enter)) {
	// Defines the song codename to be loaded
	global.SelectedSong = publishedSongID[select_index]
	
	// Go to the danceroom
	room_goto(_rm_danceroom)
}