/// @description Insert description here
/// Draw pictobar
draw_set_alpha(0.3);
draw_line_color(1060, 727, 1680, 727, c_black, c_black);
draw_sprite_ext(_dcr_pictobeat, 0, 1048, 722, _xsc, 1, 0, c_black, 0.1);

draw_set_alpha(1);
draw_line_color(1060, 726, 1680, 726, c_white, c_white);
draw_sprite_ext(_dcr_pictobeat, 0, 1048, 721, _xsc, 1, 0, global.lyricsColor, 1);

/// Draw lyrics
draw_text_softshadow(52, 694, lyricLineCurrent, _tfn_justdance_bold_16, c_white, c_black, 1, 1, 6, 1.4);
draw_text_softshadow(52, 722, lyricLineNext, _tfn_justdance_bold_16, c_white, c_black, 1, 1, 6, 1.4);

// Draw highlighted lyrics
draw_text_softshadow(52, 694, highlightText, _tfn_justdance_bold_16, global.lyricsColor, c_black, 1, 1, 0, 0);