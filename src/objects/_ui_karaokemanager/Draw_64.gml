/// @description Draw lyrics with Just Dance style
// Visual style parameters
var highlight_color = _common_songdata.songLyricsColor;
var outline_color = c_black;
var outline_thickness = 0.4;

// Get time info for animations
var video_time = _common_mediamanager.timer;

// Calculate fade alpha for current and next lyrics
var current_alpha = 1;
var next_alpha = 0.3;

// Calculate highlight length based on word progress
var highlight_len = 0;
if (lyricLineCurrent != "" && phraseProgress > 0) {
    highlight_len = floor(string_length(lyricLineCurrent) * phraseProgress);
}

// Drawing positions
var base_x = 48;
var current_y = room_height/1.115;
var next_y = room_height/1.07;

// 1. Draw current lyric base (white)
draw_set_alpha(1);
draw_text_outlined(base_x, current_y, outline_color, outline_thickness, _fnt_justdancebold_lyrics, c_white, lyricLineCurrent);

// 2. Draw highlighted portion with left-to-right fill
if (highlight_len > 0) {
    var highlight_text = lyricLineCurrent;  // Use full text
    var full_width = string_width(highlight_text);
    var fill_width = full_width * phraseProgress;  // Calculate fill width based on progress
    
    // Create surface if needed
    if (!surface_exists(highlight_surf)) {
        highlight_surf = surface_create(room_width, room_height);
    }
    
    // Draw highlighted text to surface
    surface_set_target(highlight_surf);
    draw_clear_alpha(c_black, 0);
    
    draw_set_alpha(current_alpha);
    draw_text_outlined(base_x, current_y, outline_color, outline_thickness, _fnt_justdancebold_lyrics, highlight_color, highlight_text);
    
    surface_reset_target();
    
    // Draw surface with fill effect
    draw_surface_part(highlight_surf, 
        base_x, 0,  // Start from left edge
        fill_width, room_height,  // Use calculated fill width
        base_x, 0); // Draw at same position
}

// 3. Draw next lyric (always white, faded)
draw_set_alpha(1);
draw_text_outlined(base_x, next_y, outline_color, outline_thickness, _fnt_justdancebold_lyrics, c_white, lyricLineNext);

// Reset alpha
draw_set_alpha(1);