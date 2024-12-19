/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

/// @description Initialize pictogram

// Position variables
start_x = x;
if (_common_songdata.songNumCoach == 1) {
	target_x = 1491 - 116;  // Fixed target position
	target_width = 224;
	target_height = 224;
} else if (_common_songdata.songNumCoach == 2) {
	target_x = 1406 - 174;  // Fixed target position
	target_width = 224;
	target_height = 224;
} else if (_common_songdata.songNumCoach == 3 || _common_songdata.songNumCoach == 4) {
	target_x = 1264 - 204;  // Fixed target position
	target_width = 224;
	target_height = 224;
}
image_xscale = 0.75;
image_yscale = 0.75;
image_alpha = 1;

// Timing variables
arrive_time = 0;    // When pictogram should reach target
start_time = _common_mediamanager.timer;
actualnew_time = 0;   // Current time for movement

// Animation states
enum PictoState {
    Entering,    // Moving from start to target
    OnBeat,      // At target position
    Exiting      // Fading out
}
current_state = PictoState.Entering;

// Animation parameters
enter_duration = 3000;   // Time to move to target (ms)
hold_duration = 100;     // Time to hold at target (ms)
exit_duration = 200;    // Time to fade out (ms)

// Debug
show_debug_message("Pictogram created at: " + string(x) + ", " + string(y));