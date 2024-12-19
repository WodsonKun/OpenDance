/// @description Draws the video
var _data = video_draw();
var _status = _data[0];

if (_status == 0)
{
    var _surface = _data[1];
	draw_surface_stretched(_surface, 0, 0, room_width, room_height)
}