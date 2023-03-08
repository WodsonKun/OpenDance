/// @description Insert description here
// Set default GUI size
display_set_gui_size(854,480);

// [DEBUG] Song info
draw_set_font(_fnt_justdance_regular);
draw_text_outlined(16, 16, c_black, c_white, "Title: " + global.songName)
draw_text_outlined(16, 32, c_black, c_white, "Artist: " + global.songArtist)
draw_text_outlined(16, 48, c_black, c_white, "Song position: " + string(round(global.videoPosition * 1000)))
draw_text_outlined(16, 64, c_black, c_white, "Current beat: " + string(global.beatsArray[beatIndex]))
draw_text_outlined(16, 80, c_black, c_white, "Current phrase: " + lyricLineCurrent)
draw_text_outlined(16, 96, c_black, c_white, "Current word: " + phrase.text)
draw_text_outlined(16, 112, c_black, c_white, "Current picto: " + pictoCurrent)

/// Draw pictobar
draw_set_alpha(0.3);
draw_line_color(700, 458, 900, 458, c_black, c_black);
draw_sprite_ext(_dcr_pictobeat, 0, 658, 457, _xsc, 1, 0, c_black, 0.1);

draw_set_alpha(1);
draw_line_color(700, 457, 900, 457, c_white, c_white);
draw_sprite_ext(_dcr_pictobeat, 0, 658, 456, _xsc, 1, 0, global.lyricsColor, 1);

/// Draw lyrics
draw_set_alpha(1);
draw_set_font(_fnt_justdance_bold);
draw_text_outlined(24, 426, c_black, c_white, lyricLineCurrent)
draw_text_outlined(24, 446, c_black, c_white, lyricLineNext)
draw_text_outlined(24, 426, c_black, global.lyricsColor, highlightText)

// Draw pictograms
//draw_sprite_ext(a, 0, _pic_x, 416, 0.5, 0.5, 0, c_white, _pic_a);