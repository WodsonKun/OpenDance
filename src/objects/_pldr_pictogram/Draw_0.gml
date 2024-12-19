/// @description Draw pictogram

if (sprite_exists(picto_sprite)) {
    draw_sprite_ext(picto_sprite, 0, x, y, image_xscale, image_yscale, 0, c_white, image_alpha);
} else {
    // Debug: Draw placeholder if sprite failed to load
    draw_sprite_ext(_placeholderpicto, 0, x, y, min(0.4375, 0.4375), min(0.4375, 0.4375), 0, c_white, image_alpha);
}