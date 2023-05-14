/// @description Handles keyboard logic
// Fullscreen
if (keyboard_check_released(vk_f10)) {
    fullscreen =! fullscreen;
    alarm[4] = 3;
};

// Reset game
if (keyboard_check_released(ord("R"))) {
	game_restart()
}

// End game
if (keyboard_check_released(vk_escape)) {
	game_end();
};