// OpenDance's game settings
// This is set as the initial object that is loaded by the engine
// Values pre-defined here, are default ones

// Defines default values
#macro LANG "enus"
#macro GAME_WIDTH 854
#macro PLATFORM "pc"

// Loads custom values from a settings file
if (file_exists("settings.ini")) {
	show_message("Custom settings")
}

// Set values to variables
fullscreen = 0;

// Sets the resolution of the game
set_resolution(GAME_WIDTH, false, false, true);