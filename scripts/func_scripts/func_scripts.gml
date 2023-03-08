// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function import_json(filename, function)
/// @param _file_name		JSON file to be read
/// @param _func			Function to be executed
function import_json(_file_name, _func) {
	if (file_exists(_file_name)) {
		var _file, _json_string;
		_file = file_text_open_read(_file_name);
		_json_string = "";
		while (!file_text_eof(_file)) {
			_json_string += file_text_readln(_file);
		}
		file_text_close(_file);
		return script_execute(_func, _json_string)
	}
	return undefined;
}

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

/// @function arrayHas(array_to_search, value_to_find);
function arrayHas(array_to_search, value_to_find) {
	var searchArray = argument[0];
	var findValue = argument[1];
	var loop = 0;
	repeat (array_length(searchArray)) {
		if (searchArray[loop++] == findValue) {
			return true;
		}
		else return false;
	}
}

/// @function make_color_hex(hex)
/// @param _hex_color		HEX Color to be converted
function make_color_hex(_hex_color) {
	var text = argument0;
	if (string_char_at(text, 1) == "#") {
	    text = string_delete(text, 1, 1);
	}

	if (string_char_at(text, 1) == "$") {
	    text = string_delete(text, 1, 1);
	}

	var len = string_length(text);
	var hex = array_create(len);
	var i;

	for (i = 0; i < len; i += 1) {
	    hex[i] = string_char_at(text, i + 1);
	}

	len = array_length_1d(hex)
	var r = 0
	var g = 0
	var b = 0

	for (i = 0; i < len; i++){
	    switch(string_upper(hex[i])){
	        case "A":
	            hex[i] = 10
	            break
                  
	        case "B":
	            hex[i] = 11
	            break
              
	        case "C":
	            hex[i] = 12
	            break
              
	        case "D":
	            hex[i] = 13
	            break
              
	        case "E":
	            hex[i] = 14
	            break
              
	        case "F":
	            hex[i] = 15
	            break
              
	        default:
	            hex[i] = real(hex[i])
	    }
	}

	if len == 6 {
	    r = hex[0] * 16 + hex[1]
	    g = hex[2] * 16 + hex[3]
	    b = hex[4] * 16 + hex[5]
	} else if len == 3 {
	    r = hex[0] * 16 + hex[0]
	    g = hex[1] * 16 + hex[1]
	    b = hex[2] * 16 + hex[2]
	} else if len == 2 {
	    r = hex[0] * 16 + hex[1] 
	    g = r
	    b = r
	} else if len == 1 {
	    r = hex[0] * 16 + hex[0]
	    g = r
	    b = r
	}

	return make_color_rgb(r, g, b)
}

///@desc returns the number of times a value appears in an array
///@arg array    array to search in
///@arg value    value to search for
function array_value_exists(array, value)
{
    var length, count
    length = array_length(array)
    count = 0
    for (var i = 0; i < length; i++)
    {
        if typeof(array[i]) == typeof(value) && array[i] == value 
                count += 1
    }
    return count
}