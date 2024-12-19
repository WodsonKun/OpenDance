/// @description Draw pictobar and beat indicator

// Function to draw beat indicator
draw_beat_indicator = function(beat_x, beat_y) {
    var current_scale = 1 + (beatPulseAmount * 0.3);  // 30% size increase on beat
    var current_alpha = 0.4 + (beatPulseAmount * 0.6);  // Fade from 40% to 100%
    
    // Draw solid center
    draw_set_alpha(1);
    draw_sprite_ext(_ui_pictobeat, 0, beat_x, beat_y, current_scale, 1, 0, _common_songdata.songLyricsColor, 1);
}

// Draw based on number of coaches
if (_common_songdata.songNumCoach == 1) {
    // Draw line
    draw_set_alpha(0.3);
    draw_line_color(1555, 1034, room_width, 1034, c_black, c_black);
    draw_set_alpha(1);
    draw_line_color(1555, 1033, room_width, 1033, c_white, c_white);
    
    // Draw beat indicator
    draw_beat_indicator(1491, 1034);
    
} else if (_common_songdata.songNumCoach == 2) {
    // Draw line
    draw_set_alpha(0.3);
    draw_line_color(1406, 1034, room_width, 1034, c_black, c_black);
    draw_set_alpha(1);
    draw_line_color(1406, 1033, room_width, 1033, c_white, c_white);
    
    // Draw beat indicator
    draw_beat_indicator(1342, 1034);
    
} else if (_common_songdata.songNumCoach == 3 || _common_songdata.songNumCoach == 4) {
    // Draw line
    draw_set_alpha(0.3);
    draw_line_color(1328, 1034, room_width, 1034, c_black, c_black);
    draw_set_alpha(1);
    draw_line_color(1328, 1033, room_width, 1033, c_white, c_white);
    
    // Draw beat indicator
    draw_beat_indicator(1264, 1034);
}

// Reset alpha
draw_set_alpha(1);