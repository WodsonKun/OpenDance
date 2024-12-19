/// @description Center window
window_center();

//Store size/position
temp_x = window_get_x();
temp_y = window_get_y();
temp_w = window_get_width();
temp_h = window_get_height();

// Set resolution
set_resolution(GAME_WIDTH, false, false, true);