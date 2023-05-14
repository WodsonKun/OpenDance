/// @description Draw the basic GUI
// Set a variable to define the "x" value for the text
_x_ORIG = window_get_width() / 2

// Set text alignment and draw the "Press [button] to close the game"
draw_set_valign(fa_middle);
draw_set_halign(fa_left);
draw_text_softshadow(16, 16, loc_9, _tfn_justdance_regular_12, c_white, c_black, 1, 1, 6, 1.4);
draw_text_softshadow(16 + (string_width(loc_9) / 2), 16, loc_1001, _tfn_prompt_12, c_white, c_black, 1, 1, 6, 1.4);

// Set text alignment
draw_set_valign(fa_middle);
draw_set_halign(fa_middle);

// Draw the "Press [button] to start"
draw_text_softshadow(_x_ORIG, 372, loc_10, _tfn_justdance_bold_12, c_white, c_black, 1, 1, 6, 1.4);
draw_text_softshadow(_x_ORIG + (string_width(loc_10) / 2.8) - 48, 372, loc_1000, _tfn_prompt_12, c_white, c_black, 1, 1, 6, 1.4);