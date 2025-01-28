/// Coverflow
//Draw the profile picture
// Scrolling
if (select_index > 0) {
    offset = 0 + (-420 * select_index);
} else {
    offset = 0;
}


// Define what's going to be shown on-screen
var i, i_start, i_end;
if (select_index > 1) {
	i_start = select_index - 2;
	i_end = select_index + 3;
}
else {
	i_start = 0;
    i_end = select_index + 5;
}


for (i = i_start; i < array_length(publishedSongData.playlists[playlist_index].songs); i++) {
    // Stores the songId
    songId = publishedSongData.playlists[playlist_index].songs[i].id
    song = undefined;
    show_debug_message("Searching for Song ID: " + string(songId));
    // Search for the song in publishedSongData.songs
    for (k = 0; k < array_length(publishedSongInfo); k++) {
        if (publishedSongInfo[k][0] == songId) {
            song = publishedSongInfo[k];
            show_debug_message("Found Song: " + string(publishedSongInfo[k][1]));
        }
    }
    // Draw the song cover if found
    if (song != undefined) {
        if (sprite_exists(song[9])) {
            draw_sprite_part_ext(song[9], 0, 0, 0, 640, 360, 26 + offset + (400 + 20) * i, 744, 0.6, 0.6, c_white, 1);
        }
    }
}

// Seletor de jogos
if (select_index < array_length(publishedSongData.playlists[playlist_index].songs) + 1) {
	draw_sprite_ext(_ui_coverflow_selector, 0, 26, 744, 0.6, 0.6, 0, c_white, 1)
}

// Iterates through the songlist
for (_s = 0; _s < array_length(publishedSongData.playlists[playlist_index].songs); _s++) {
    // Stores the songId
    _songId = publishedSongData.playlists[playlist_index].songs[select_index].id
    song = undefined;
    // Search for the song in publishedSongData.songs
    for (_k = 0; _k < array_length(publishedSongInfo); _k++) {
        if (publishedSongInfo[_k][0] == _songId) {
            song = publishedSongInfo[_k];
        }
    }
}
    
// Draw the song name (only if a logo doesn't exist)
draw_set_font(_fnt_justdancecondensed_24);
draw_text(38, 322, song[1]);

// Draw the "Just Dance" version
draw_set_font(_fnt_justdanceregular_12);
draw_text(38, 358, "Just Dance " + string(song[3]));

// Draw the artist name BG
for (artistIndex = 0; artistIndex < array_length(song[2]); artistIndex++) {
    // Draw the artist name
    draw_set_alpha(1);
    draw_set_font(_fnt_justdancecondensed_artist);
    if (artistIndex == 0) {
        draw_roundrect_color_ext(32, 382, (string_width(song[2][artistIndex]) + 68), 422, 16, 16, make_color_rgb(47, 60, 99), make_color_rgb(47, 60, 99), false);
        draw_roundrect_color_ext(34, 384, (string_width(song[2][artistIndex]) + 66), 420, 16, 16, make_color_rgb(34, 49, 89), make_color_rgb(34, 49, 89), false);
        draw_text(52, 396, song[2][artistIndex]);
    } else if (artistIndex > 0) {
        draw_roundrect_color_ext(12 + (32 * artistIndex) + 36 + string_width(song[2][artistIndex - 1]), 382, (16 + (32 * artistIndex) + 36 + string_width(song[2][artistIndex - 1])) + string_width(song[2][artistIndex]) + 34, 422, 16, 16, make_color_rgb(47, 60, 99), make_color_rgb(47, 60, 99), false);
        draw_roundrect_color_ext(12 + (32 * artistIndex) + 36 + string_width(song[2][artistIndex - 1]), 384, (16 + (32 * artistIndex) + 36 + string_width(song[2][artistIndex - 1])) + string_width(song[2][artistIndex]) + 34, 420, 16, 16, make_color_rgb(34, 49, 89), make_color_rgb(34, 49, 89), false);
        draw_text(12 + (52 * artistIndex) + 36 + string_width(song[2][artistIndex - 1]), 396, song[2][artistIndex]);
    }
}

// Draws the difficulty, number of coaches and effort string
draw_text_scribble(38, 426, "[offset,0,5]" + str("10") + ": [offsetPop][_icn_difficulty," + string(song[7]-1) + "][offset,0,5]    " + str("11") + ": [offsetPop][_icn_coaches," + string(song[6]-1) + "][offset,0,5]   " + str("12") + ": [offsetPop][_icn_effort," + string(song[8]-1) + "]")

// Draw the playlist name
draw_set_font(_fnt_justdancebold_16);
draw_text(38, 1016, publishedSongData.playlists[playlist_index].name);
draw_text_scribble(1790, 1008, "[_ui_xsxcontroller, 0][offset,0,7] " + str("8"));