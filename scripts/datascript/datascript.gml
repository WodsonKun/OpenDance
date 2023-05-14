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

function load_locid() {
	// Loads the symbol localization (necessary for buttons)
	loc8_symb()

	// Loads the loc8 depending on the language
	switch (LANG) {
		case ("enus"): loc8_enus(); break;
		case ("ptbr"): loc8_ptbr(); break;
		default: loc8_enus(); break;
	}
}

// Credits to "Woowoo"
// https://forum.gamemaker.io/index.php?threads/dealing-with-external-mp3-files.49595/
function audio_load_mp3(mp3file) {
	var fname = argument0;
	var result = 0;
	if (file_exists(fname)) {
	    file = file_bin_open(fname, 0);
	    var size = file_bin_size(file);
	    var gameTransfer = buffer_create(1024, buffer_grow, 1);
	    for (var i = 0; i < size; i += 1;) {
	        buffer_write(gameTransfer, buffer_s16, file_bin_read_byte(file));
	    }
	    result = audio_create_buffer_sound(gameTransfer, buffer_u8, 44100, 0, 10, audio_stereo);
	    file_bin_close(file);
	}
	return result;
	
	// Shows a message if it wasn't able to get the audio file
	if (!file_exists(fname)) {
		show_debug_message("file_open_bin has failed to open the file");
	}
}