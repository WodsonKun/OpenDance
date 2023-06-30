/// @description Draw the background layers
draw_sprite(_bkg_space, 0, 0, 0);

// Animated stars
draw_sprite_ext(_frg_stars, 0, (window_get_width() / 2), (window_get_height() / 2), currentZoom, currentZoom, 0, c_white, 1);
draw_sprite_ext(_frg_stars, 1, (window_get_width() / 2), (window_get_height() / 2), currentZoom1, currentZoom1, 0, c_white, 1);
draw_sprite_ext(_frg_stars, 2, (window_get_width() / 2), (window_get_height() / 2), currentZoom2, currentZoom2, 0, c_white, 1);