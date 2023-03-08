/// @description Update the frame buffer

if (video_exists(v)) {
  if (video_is_playing(v)) {
    video_position = video_get_playtime(v);
    global.videoPosition = video_get_playtime(v);
    video_grab_frame_buffer(v, buffer_get_address(buff));
  } else if (video_position >= video_get_duration(v)) {
    game_end();
  }
}