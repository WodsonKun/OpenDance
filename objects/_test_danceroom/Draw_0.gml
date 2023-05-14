/// @description Draw the frame to the screen

draw_set_color(c_white);
display_set_gui_size(window_get_width(), window_get_height());

// rembember to check if video exists when interacting with video.
// if you get a crash it is likely because you a trying to interact
// with memory that no longer exists or doesn't exist yet (video).
if (video_exists(v)) {

  if (!surface_exists(surf)) {
    // create a squeaky clean totally empty surface for our needs.
    surf = surface_create(w, h);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
  }

  // then we just slap the video frame on that surf.
  buffer_set_surface(buff, surf, 0);
  draw_surface_stretched(surf, 0, 0, window_get_width(), window_get_height());
}
