/// @description Inserir descrição aqui
if (async_load[? "type"] == "video_start") {
  video_pause();
  video_seek_to(videoOffset);
  video_resume();
}

if (async_load[? "type"] == "video_end")
{
    video_close();
}