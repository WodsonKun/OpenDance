/// @description Initializes the game logic
// Pre-loads the GoldMoveEffectClip textures (as they're too heavy to load on-the-fly)
texture_prefetch("GoldEffect_TextureGroup");

// Sets the game speed to 30FPS
game_set_speed(30, gamespeed_fps);

// [DEBUG] Debug functions
instance_create_depth(0, 0, 0, _dbg_debugfunctions);

// Initializes the display handler
instance_create_depth(0, 0, 0, _eng_displayhandler);

// Loads game settings
if (file_exists("opendance_data/configdata/gameConfig.json")) {
    gameSettingsJSON = import_json("opendance_data/configdata/gameConfig.json", json_parse);
    
    // Set language based off the user's defined settings
    if (gameSettingsJSON.language != "") {
        set_locale(string(gameSettingsJSON.language));
    }
    else {
       // Set language based off the user's computer language
       set_locale(string(os_get_language()));
    }
}