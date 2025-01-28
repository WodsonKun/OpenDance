/// @description Keyboard and animation logic
// Changes songs
if (keyboard_check_released(vk_left)) {
	// Changes options
	if (select_index <= 0) {
		select_index = (array_length(publishedSongData.playlists[playlist_index].songs) - 1)
	}
	else {
		select_index -= 1
	}
} else if (keyboard_check_released(vk_right)) {
	// Changes options
	if (select_index >= (array_length(publishedSongData.playlists[playlist_index].songs) - 1)) {
		select_index = 0
	}
	else {
		select_index += 1
	}
}

// Changes playlists
if (keyboard_check_released(vk_up)) {
	// Changes options
	if (playlist_index <= 0) {
		playlist_index = (array_length(publishedSongData.playlists) - 1)
	}
	else {
		playlist_index -= 1
	}
    select_index = 0;
} else if (keyboard_check_released(vk_down)) {
	// Changes options
	if (playlist_index >= (array_length(publishedSongData.playlists) - 1)) {
		playlist_index = 0
	}
	else {
		playlist_index += 1
	}
    select_index = 0;
}

// Go to the danceroom
if (keyboard_check_released(vk_enter)) {
	global.publishedSongID = song[0]; // Defines the song codename to be loaded
	global.publishedSongType = song[4]; // Defines the song codename to be loaded
	room_goto(_rm_danceroom); // Go to the danceroom
}