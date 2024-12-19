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

// Load audiogroups
audio_group_load(ambiance);
audio_group_load(soundeffect);

// Sets the cursor invisible (makes us able to add ur own custom cursor)
window_set_cursor(cr_none);

// Starts playing the menu audio
audio_play_sound(_snd_menuambiance, 0, true);