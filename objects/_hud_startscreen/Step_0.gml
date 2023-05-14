/// @description Handles keyboard functions

// You can write your code in this editor
if keyboard_check_released(vk_enter) {
	room_goto(_rm_songsection); // Goes to song selection (alpha)
}
else if keyboard_check_released(vk_escape) {
	game_end(); // Closes the game
}