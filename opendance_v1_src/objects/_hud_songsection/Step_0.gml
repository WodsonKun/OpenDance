/// @description Keyboard and animation logic
/// Keyboard logic for the menu
if (keyboard_check_released(vk_left)) {
	// Changes options
	if (select_index <= 0) {
		select_index = (array_length_1d(songsArray) - 1)
	}
	else {
		select_index -= 1
	}
	
	// Checks if the audio is playing
	if (select_index < (array_length_1d(songsArray) - 1)) {
		if (audio_is_playing(global.publishedSongAudioPreview[select_index + 1])) {
			audio_stop_sound(global.publishedSongAudioPreview[select_index + 1]);
		}
	}
	
	// Plays the current audiopreview
	audio_play_sound(global.publishedSongAudioPreview[select_index], 0, 1)
}

else if (keyboard_check_released(vk_right)) {
	// Changes options
	if (select_index >= (array_length_1d(songsArray) - 1)) {
		select_index = 0
	}
	else {
		select_index += 1
	}
	
	// Checks if the audio is playing
	if (select_index > 1) {
		if (audio_is_playing(global.publishedSongAudioPreview[select_index - 1])) {
			audio_stop_sound(global.publishedSongAudioPreview[select_index - 1]);
		}
	}
	
	// Plays the current audiopreview
	audio_play_sound(global.publishedSongAudioPreview[select_index], 0, 1)
}

// Handles actions for both left or right key
if (keyboard_check_released(vk_left)) || (keyboard_check_released(vk_right)) {
	
	// Play scroll SFX
	audio_play_sfx(_sfx_scroll);
	
	/// Pauses and unpauses the background audio
	if (audio_exists(global.publishedSongAudioPreview[select_index])) {
		if (audio_is_playing(_snd_menuambiance)) {
			audio_pause_sound(_snd_menuambiance);
		}
	} else if (!audio_exists(global.publishedSongAudioPreview[select_index])) {
		if (audio_is_paused(_snd_menuambiance)) {
			audio_resume_sound(_snd_menuambiance);
		}
	}
}

// Go to the danceroom
if (keyboard_check_released(vk_enter)) {
	audio_play_sfx(_sfx_confirm); // Play confirm SFX
	audio_stop_sound(global.publishedSongAudioPreview[select_index]); // Stop playing the audiopreview
	global.SelectedSong = publishedSongID[select_index] // Defines the song codename to be loaded
	room_goto(_rm_danceroom) // Go to the danceroom
}


// --------------------------------------- Animations ---------------------------------------
/// Zooming stars animation
currentZoom += 0.005 * 1; currentZoom1 += 0.013 * 1; currentZoom2 += 0.015 * 1;
currentZoom = clamp(currentZoom, minZoom, 4.2); currentZoom1 = clamp(currentZoom1, minZoom, 4.5); currentZoom2 = clamp(currentZoom2, minZoom, 4.7);

if (currentZoom >= 4.15 || currentZoom <= 0.1) {
    currentZoom = 0.1;
}
if (currentZoom1 >= 4.25 || currentZoom1 <= 0.1) {
    currentZoom1 = 0.1;
} 
if (currentZoom2 >= 4.45 || currentZoom2 <= 0.1) {
    currentZoom2 = 0.1;
}