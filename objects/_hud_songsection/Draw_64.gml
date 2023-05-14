/// @description Draw the GUI
// Set the horizontal alignment for the text
draw_set_halign(fa_left);

// Draws the map_bkg
if sprite_exists(global.publishedSongMapBKG[select_index]) && (array_length_1d(songsArray) > 0) {
	draw_sprite_stretched_ext(global.publishedSongMapBKG[select_index], 0, 0, 0, window_get_width(), room_height, c_white, 0.4);
}

// ------------------------------------------------------------------------------------------------------
/// Coverflow
//Draw the profile picture
// Scrolling
if (select_index > 0) {
    offset = 0 + (-340 * select_index);
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

// Draws the song list
for (i = i_start; i < array_length_1d(songsArray); i++) {
	// Draw the song covers and the default ones
    if(i > (array_length_1d(songsArray) - 1)) {
        draw_sprite_stretched(_pch_empty, 0, 32 + offset + (320 + 20) * i, 235 - vv, 320, 160);
	}
	else {
		
		// Draws the cover
		if sprite_exists(global.publishedSongCover[i]) && (array_length_1d(songsArray) > 0) {
			draw_sprite_part_ext(global.publishedSongCover[i], 0, 0, 0, 640, 320, 32 + offset + (320 + 20) * i, 500, 0.5, 0.5, c_white, 1);
		}
		
		if (!sprite_exists(global.publishedSongLogo[i]) && (array_length_1d(songsArray) > 0)) {
			draw_sprite_stretched(_ui_shd_cover, 0, 32 + offset + (320 + 20) * i, 500, 320, 160)
		}
	}
	
	// Draw the song names
	draw_set_font(_tfn_justdance_bold_16);
	if (!sprite_exists(global.publishedSongLogo[i]) && (array_length_1d(songsArray) > 0)) {
		draw_text(44 + offset + (320 + 20) * i, 460 + 160 + 20, global.publishedSongTitle[i]);
	}
	else {
	}
}

// Seletor de jogos
if (select_index < array_length_1d(songsArray) + 1) {
	draw_sprite_stretched(_ui_coverflow_selector, 0, 26, 494, 332, 172);
}

// ------------------------------------------------------------------------------------------------------
/// The rest (???)
// Draws the albumcoach
if sprite_exists(global.publishedSongAlbumcoach[select_index]) && (array_length_1d(songsArray) > 0) {
	draw_sprite_stretched(global.publishedSongAlbumcoach[select_index], 0, 914, 72, 384, 384);
}

// Draws the logo
if sprite_exists(global.publishedSongLogo[select_index]) && (array_length_1d(songsArray) > 0) {
	draw_sprite_stretched(global.publishedSongLogo[select_index], 0, 38, 224, 256, 128);
} else {
	// Draw the song name (only if a logo doesn't exist)
	draw_set_font(_tfn_justdance_bold_24);
	draw_text(38, 334, global.publishedSongTitle[select_index]);
}

// Set the font to "Regular"
draw_set_font(_tfn_justdance_regular_12);

// Draw the "Just Dance" version
draw_text(38, 370, loc_11 + string(publishedSongJDVersion[select_index]));

// Draw the artist name
draw_sprite_ext(_ui_artistname_bg, 0, 32, 382, 0.65, 0.65, 0, c_white, 0.620);
draw_text(52, 406, global.publishedSongArtist[select_index]);

// Draw the engine name
draw_set_font(_tfn_justdance_bold_14);
draw_text(38, 534 + 160 + 24, "OpenDance Engine");
draw_text(1110 + string_width(loc_1001), 534 + 160 + 24, loc_13);
draw_text(1210 + string_width(loc_1000), 534 + 160 + 24, loc_12);

draw_set_font(_tfn_prompt_14);
draw_text(1110, 534 + 160 + 24, loc_1001);
draw_text(1210, 534 + 160 + 24, loc_1000);

