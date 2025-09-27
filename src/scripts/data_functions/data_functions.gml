/// @function import_json(filename, function)
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

/// @function make_color_hex(FFFFFF)
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

	len = array_length(hex)
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

/// @function markerClipToStartTimeMS(starttimemarker, markerarray)
function markerClipToStartTimeMS(_StartTimeMarker, _markers) {
	startTimeMS = markerToMS(argument[0], argument[1]);
	return startTimeMS
}
/// @function markerClipToDurationMS(starttimemarker, durationmarker, markerarray)
function markerClipToDurationMS(_StartTimeMarker, _DurationMarker, _markers) {
	startTimeMS = markerToMS(argument[0], argument[2]);
	durationMS = markerToMS(argument[0] + argument[1], argument[2]) - startTimeMS
	return durationMS
}
/// @function markerToMS(markervalue, markerarray)
function markerToMS(_marker, _markers) {
	var _beat_marker = argument[0];
	negative = _beat_marker < 0
	if negative {
		_beat_marker *= -1
	}
	_beat_marker /= 24;
	absmarker = round(abs(_beat_marker))
	back = _markers[absmarker] / 48
	front = _markers[absmarker + 1] / 48
	decimal = _beat_marker - absmarker
	rest = (front - back) * decimal
	ms = back + rest
	if negative {
		ms *= -1
	}
	return ms
}

/// @description process_packet(buffer)
/// @param buffer
function process_packet(argument0) {
	var buffer = argument0;
	var msg_id = buffer_read(buffer,buffer_u8); // ID
	var clickx = buffer_read(buffer, buffer_f32); // AxisX
	var clicky = buffer_read(buffer, buffer_f32); // AxisY
	var clickz = buffer_read(buffer, buffer_f32); // AxisZ
    
	// Updates AxisX, AxisY and AxisZ
	remotex = clickx;
	remotey = clicky;
	remotez = clickz;
}

function read_msm_file(_filename) {
    if (!file_exists(_filename)) {
        show_debug_message("MSM file not found: " + _filename);
        return undefined;
    }
    
    var _buffer = buffer_load(_filename);
    if (_buffer == -1) {
        show_debug_message("Failed to load MSM file into buffer");
        return undefined;
    }
    
    // Create MSM data structure with all required fields
    var _msm = {
        // Required fields with default values
        endianess: 0,
        version: 0,
        move_name: "",
        song_name: "",
        classifier_type: "",
        duration: 0,
        low_threshold: 0,
        high_threshold: 0,
        measures: [],
        is_valid: false,
        
        // Additional fields
        autocorr_threshold: 0,
        direction_impact: 0,
        measures_bitfield: 0,
        custom_flags: 0,
        measure_value: 0,
        measure_count: 0,
        energy_measure_count: 0
    };
    
    try {
        buffer_seek(_buffer, buffer_seek_start, 0);
        
        // Reads the endianess of the MSM
        _msm.endianess = buffer_read_u32be(_buffer);
        
        // Reads the MSM structure
        if (_msm.endianess == 1) {
            _msm.version = buffer_read_u32be(_buffer);
            _msm.move_name = buffer_read_string_fixed(_buffer, 64);
            _msm.song_name = buffer_read_string_fixed(_buffer, 64);
            _msm.classifier_type = buffer_read_string_fixed(_buffer, 64);
            _msm.duration = buffer_read_f32le(_buffer);
            _msm.low_threshold = buffer_read_f32le(_buffer);
            _msm.high_threshold = buffer_read_f32le(_buffer);
            _msm.autocorr_threshold = buffer_read_u32be(_buffer);
            _msm.direction_impact = buffer_read_f32le(_buffer);
            _msm.measures_bitfield = buffer_read_u64be(_buffer);
            _msm.measure_value = buffer_read_u32be(_buffer);
            _msm.measure_count = buffer_read_u32be(_buffer);
            _msm.energy_measure_count = buffer_read_u32be(_buffer);
            _msm.custom_flags = buffer_read(_buffer, buffer_s32);
            
            // Read remaining float data
            while (buffer_tell(_buffer) < buffer_get_size(_buffer) - 4) {
                var _value = buffer_read_f32le(_buffer);
                array_push(_msm.measures, _value);
            }
        }
        else {
            _msm.version = buffer_read_u32be(_buffer);
            _msm.move_name = buffer_read_string_fixed(_buffer, 64);
            _msm.song_name = buffer_read_string_fixed(_buffer, 64);
            _msm.classifier_type = buffer_read_string_fixed(_buffer, 64);
            _msm.duration = buffer_read_f32be(_buffer);
            _msm.low_threshold = buffer_read_f32be(_buffer);
            _msm.high_threshold = buffer_read_f32be(_buffer);
            _msm.autocorr_threshold = buffer_read_u32be(_buffer);
            _msm.direction_impact = buffer_read_f32be(_buffer);
            _msm.measures_bitfield = buffer_read_u64be(_buffer);
            _msm.measure_value = buffer_read_u32be(_buffer);
            _msm.measure_count = buffer_read_u32be(_buffer);
            _msm.energy_measure_count = buffer_read_u32be(_buffer);
            _msm.custom_flags = buffer_read(_buffer, buffer_s32);
            
            // Read remaining float data
            while (buffer_tell(_buffer) < buffer_get_size(_buffer) - 4) {
                var _value = buffer_read_f32be(_buffer);
                array_push(_msm.measures, _value);
            }
        }
        _msm.is_valid = true;
        
        //show_message(string(_msm));
        show_debug_message("Successfully read MSM file" + string(_filename));
        
    } catch(e) {
        show_debug_message("Error reading MSM file: " + string(e));
        _msm.is_valid = false;
    }
    
    buffer_delete(_buffer);
    return _msm;
}

function buffer_read_string_fixed(_buffer, _length) {
    var _str = "";
    var _null_found = false;
    
    repeat(_length) {
        var _byte = buffer_read(_buffer, buffer_u8);
        if (!_null_found && _byte != 0) {
            _str += chr(_byte);
        } else {
            _null_found = true;
        }
    }
    
    return _str;
}

/// @function buffer_read_float_be(buffer)
/// @param buffer The buffer to read from
/// @returns {real} The float value read from the buffer
function buffer_read_f32be(buffer) {
    // Read 4 bytes individually
    var b1 = buffer_read(buffer, buffer_u8);
    var b2 = buffer_read(buffer, buffer_u8);
    var b3 = buffer_read(buffer, buffer_u8);
    var b4 = buffer_read(buffer, buffer_u8);
    
    // Combine bytes in big-endian order and convert to float
    var bytes = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
    
    // Create a buffer to convert the integer to float
    var tmp_buffer = buffer_create(4, buffer_fixed, 1);
    buffer_seek(tmp_buffer, buffer_seek_start, 0);
    buffer_write(tmp_buffer, buffer_u32, bytes);
    buffer_seek(tmp_buffer, buffer_seek_start, 0);
    
    // Read as float
    var result = buffer_read(tmp_buffer, buffer_f32);
    
    // Clean up temporary buffer
    buffer_delete(tmp_buffer);
    
    return result;
}

function buffer_read_f32le(_buffer) {
    // Read a 32-bit floating-point number (buffer_f32) from the buffer.
    // GML's buffer_read function automatically handles byte order based on the
    // buffer's current type (which defaults to buffer_grow and little-endian
    // for floats unless explicitly changed). However, for clarity and to ensure
    // little-endian is used, we'll explicitly state it.
    // Note: GML's buffer_f32 type is inherently little-endian on most platforms
    // where GameMaker runs, but it's good practice to be aware of the byte order
    // if you're dealing with external data sources.
    var _float_value = buffer_read(_buffer, buffer_f32);

    // Return the read float value.
    return _float_value;
}

/// @function buffer_read_uint32_be(buffer)
function buffer_read_u32be(buffer) {
    var b1 = buffer_read(buffer, buffer_u8);
    var b2 = buffer_read(buffer, buffer_u8);
    var b3 = buffer_read(buffer, buffer_u8);
    var b4 = buffer_read(buffer, buffer_u8);
    return (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
}

/// @function buffer_read_int32_be(buffer)
/// @param buffer The buffer to read from
/// @returns {real} The 32-bit integer value read from the buffer
function buffer_read_s32be(buffer) {
    var b1 = buffer_read(buffer, buffer_u8);
    var b2 = buffer_read(buffer, buffer_u8);
    var b3 = buffer_read(buffer, buffer_u8);
    var b4 = buffer_read(buffer, buffer_u8);
    
    // Combine bytes in big-endian order
    var result = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
    
    // Convert to signed if necessary (handle negative numbers)
    if (result & $80000000) {
        result = -(($FFFFFFFF - result) + 1);
    }
    
    return result;
}

/// @function buffer_read_int64_be(buffer)
/// @param buffer The buffer to read from
/// @returns {real} The 64-bit integer value read from the buffer
/// @note Due to GML's number limitations, very large values might lose precision
function buffer_read_s64be(buffer) {
    var b1 = buffer_read(buffer, buffer_u8);
    var b2 = buffer_read(buffer, buffer_u8);
    var b3 = buffer_read(buffer, buffer_u8);
    var b4 = buffer_read(buffer, buffer_u8);
    var b5 = buffer_read(buffer, buffer_u8);
    var b6 = buffer_read(buffer, buffer_u8);
    var b7 = buffer_read(buffer, buffer_u8);
    var b8 = buffer_read(buffer, buffer_u8);
    
    // Split into high and low 32-bit parts
    var high = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
    var low = (b5 << 24) | (b6 << 16) | (b7 << 8) | b8;
    
    // Combine the parts (need to use multiplication for the high part to preserve bits)
    var result = (high * 4294967296) + (low >> 0);
    
    // Handle negative numbers
    if (b1 & $80) {
        // If highest bit is set (negative number)
        result -= 9223372036854775808; // 2^63
    }
    
    return result;
}

/// @function buffer_read_uint64_be(buffer)
/// @param buffer The buffer to read from
/// @returns {real} The unsigned 64-bit integer value read from the buffer
/// @note Due to GML's number limitations, very large values might lose precision
function buffer_read_u64be(buffer) {
    var b1 = buffer_read(buffer, buffer_u8);
    var b2 = buffer_read(buffer, buffer_u8);
    var b3 = buffer_read(buffer, buffer_u8);
    var b4 = buffer_read(buffer, buffer_u8);
    var b5 = buffer_read(buffer, buffer_u8);
    var b6 = buffer_read(buffer, buffer_u8);
    var b7 = buffer_read(buffer, buffer_u8);
    var b8 = buffer_read(buffer, buffer_u8);
    
    // Split into high and low 32-bit parts
    var high = (b1 << 24) | (b2 << 16) | (b3 << 8) | b4;
    var low = (b5 << 24) | (b6 << 16) | (b7 << 8) | b8;
    
    // Combine the parts
    return (high * 4294967296) + (low >> 0);
}