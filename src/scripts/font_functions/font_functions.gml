/// @function draw_text_outlined(xpos, ypos, outlinecolor, outlinethickness, textfont, textcolor, text)
function draw_text_outlined(x, y, outline_color, outline_thickness, string_font, string_color, string_text) {
	var xx, yy;  
	xx = argument[0];  
	yy = argument[1];  
  
	//Outline  
	draw_set_color(argument[2]);
	draw_set_font(argument[4]);
	draw_text(xx+argument[3], yy+argument[3], argument[6]);  
	draw_text(xx-argument[3], yy-argument[3], argument[6]);  
	draw_text(xx,			  yy+argument[3], argument[6]);  
	draw_text(xx+argument[3],			  yy, argument[6]);  
	draw_text(xx,			  yy-argument[3], argument[6]);  
	draw_text(xx-argument[3],			  yy, argument[6]);  
	draw_text(xx-argument[3], yy+argument[3], argument[6]);  
	draw_text(xx+argument[3], yy-argument[3], argument[6]);
	
	//Text  
	draw_set_color(argument[5]);  
	draw_text(xx, yy, argument[6]);  
}

/// Draws text with a little dropshadow
function draw_text_softshadow(x_position, y_position, text, font_name, text_colour, shadow_colour, shadow_offset_x, shadow_offset_y, shadow_blurriness, shadow_strength) {
	var _x, _y, _string, _font, _offset_x, _offset_y, _blurfactor, _shadow_colour, _shadow_strength, _text_colour, ix, iy;
	_x = argument0;
	_y = argument1;
	_string = argument2;
	_font = argument3;
	_text_colour = argument4;
	_shadow_colour = argument5;
	_offset_x = argument6;
	_offset_y = argument7;
	_blurfactor = argument8;
	_shadow_strength = argument9;

	draw_set_font(_font);
	var shadow_strength_calc = _shadow_strength/(_blurfactor * _blurfactor)
	draw_set_alpha(shadow_strength_calc);
	draw_set_colour(_shadow_colour);
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