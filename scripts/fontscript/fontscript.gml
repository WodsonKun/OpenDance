/// @function draw_text_outlined(x, y, outline color, string color, string)
function draw_text_outlined(x, y, outline_color, string_color, string_text) {
	var xx,yy;  
	xx = argument[0];  
	yy = argument[1];  
  
	//Outline  
	draw_set_color(argument[2]);  
	draw_text(xx+1, yy+1, argument[4]);  
	draw_text(xx-1, yy-1, argument[4]);  
	draw_text(xx,   yy+1, argument[4]);  
	draw_text(xx+1,   yy, argument[4]);  
	draw_text(xx,   yy-1, argument[4]);  
	draw_text(xx-1,   yy, argument[4]);  
	draw_text(xx-1, yy+1, argument[4]);  
	draw_text(xx+1, yy-1, argument[4]);
	
	//Text  
	draw_set_color(argument[3]);  
	draw_text(xx, yy, argument[4]);  
}

/// @function draw_text_softshadow
/// @param x_position
/// @param y_position
/// @param text
/// @param font_name
/// @param text_colour
/// @param shadow_colour
/// @param shadow_offset_x
/// @param shadow_offset_y
/// @param shadow_blurriness (higher numbers will be slower!)
/// @param shadow_strenght of shadow, (0.01=soft, 1=strong);
/// example: draw_text_softshadow(10,10,"Hello World!", font_name, c_white, c_black, 0,5,6,0.01, );
function draw_text_softshadow(x_position, y_position, text, font_name, text_colour, shadow_colour, shadow_offset_x, shadow_offset_y, shadow_blurriness, shadow_strenght) {
	var _x, _y, _string, _font, _offset_x, _offset_y, _blurfactor, _shadow_colour, _shadow_strenght, _text_colour, ix, iy;
	_x = argument0;
	_y = argument1;
	_string = argument2;
	_font = argument3;
	_text_colour = argument4;
	_shadow_colour = argument5;
	_offset_x = argument6;
	_offset_y = argument7;
	_blurfactor = argument8;
	_shadow_strenght = argument9;

	draw_set_font(_font);
	var shadow_strenght_calc = _shadow_strenght/(_blurfactor * _blurfactor)
	draw_set_alpha(shadow_strenght_calc);
	draw_set_colour(_shadow_colour);
	//draw_text((_x + _offset_x), (_y + _offset_x), string(_string));
	var bx = _blurfactor/2;
	var by = _blurfactor/2;

	for (ix = 0; ix < _blurfactor; ix++) {
	    for (iy = 0; iy < _blurfactor; iy++) {
	        draw_text((_x-bx) +_offset_x + ix, (_y-by) +_offset_y + iy, string(_string));
	    }
	}
	draw_set_alpha(1);
	draw_set_colour(_text_colour);
	draw_text(_x, _y, string(_string));
}