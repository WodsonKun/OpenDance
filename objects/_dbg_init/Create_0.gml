/// @description Initializes the engine
// Loads the gameconfig
gameconfig();

// Sets the window width
temp_w = GAME_WIDTH;

// Set fullscreen
alarm[4] = 6;

// Center window (if on "Window Mode")
alarm[3] = 2;

// Lock speed on 60FPS (useful for debugging, also avoids bugs)
room_speed = 60;