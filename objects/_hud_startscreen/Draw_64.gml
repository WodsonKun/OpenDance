/// @description Draw the basic GUI
// Set a variable to define the "x" value for the text
_x_ORIG = window_get_width() / 2
_y_ORIG = window_get_height() / 1.05

// Set text alignment and draw the "Press [button] to close the game"
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_text_softshadow(_x_ORIG, 24, loc_1001, _tfn_prompt_12, c_white, c_black, 1, 1, 6, 1.4);
draw_text_softshadow(_x_ORIG + string_width(loc_1001), 24, loc_9, _tfn_justdance_bold_12, c_white, c_black, 1, 1, 6, 1.4);

draw_set_halign(fa_right)
draw_text_softshadow(_x_ORIG - (string_width(loc_1001) / 4), 24, loc_8, _tfn_justdance_bold_12, c_white, c_black, 1, 1, 6, 1.4);


// Set text alignment and draw the "Press [button] to close the game"
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_text_softshadow(_x_ORIG, _y_ORIG, loc_1000, _tfn_prompt_12, c_white, c_black, 1, 1, 6, 1.4);
draw_text_softshadow(_x_ORIG + string_width(loc_1000), _y_ORIG, loc_10, _tfn_justdance_bold_12, c_white, c_black, 1, 1, 6, 1.4);

draw_set_halign(fa_right)
draw_text_softshadow(_x_ORIG - (string_width(loc_1000) / 4), _y_ORIG, loc_8, _tfn_justdance_bold_12, c_white, c_black, 1, 1, 6, 1.4);

