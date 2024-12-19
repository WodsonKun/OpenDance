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

/// @function
function msmReader(_file) {
	_msmFile = buffer_load(argument[0]); // Opens the MSM and creates a buffer for it
	
	// Ignores the first 4 bytes
	buffer_seek(_msmFile, buffer_seek_start, 4)
	
	// Reads the necessary data
	buffer_seek(_msmFile, buffer_seek_relative, 4)
	_msmVersion = buffer_read(_msmFile, buffer_u32)
	
	
	
}
/*
 using BinaryReader reader = new(File.OpenRead(msmFile));

        //Ignores the first 4 bytes
        reader.ReadBytes(4);

        //Instantiates UbiMoveSpaceMovement and acquired main data from binary file (ONLY VERSION 7 MOVES SUPPORTED)
        UbiMoveSpaceMovement move = new()
        {
            version = BitConverter.ToInt32(ReverseEndianess(reader.ReadBytes(4)), 0),
            moveName = Encoding.UTF8.GetString(reader.ReadBytes(0x40)).TrimEnd('\0'),
            mapName = Encoding.UTF8.GetString(reader.ReadBytes(0x40)).TrimEnd('\0'),
            authorName = Encoding.UTF8.GetString(reader.ReadBytes(0x40)).TrimEnd('\0'),
            moveDuration = BitConverter.ToSingle(ReverseEndianess(reader.ReadBytes(4)), 0),
            moveAccurateLowThreshold = BitConverter.ToSingle(ReverseEndianess(reader.ReadBytes(4)), 0),
            moveAccurateHighThreshold = BitConverter.ToSingle(ReverseEndianess(reader.ReadBytes(4)), 0),
            autoCorrelationThreshold = BitConverter.ToSingle(ReverseEndianess(reader.ReadBytes(4)), 0),
            moveDirectionImpactFactor = BitConverter.ToSingle(ReverseEndianess(reader.ReadBytes(4)), 0),
            moveMeasureBitfield = BitConverter.ToInt64(ReverseEndianess(reader.ReadBytes(8)), 0),
            measureValue = BitConverter.ToInt32(ReverseEndianess(reader.ReadBytes(4)), 0),
            measureCount = BitConverter.ToInt32(ReverseEndianess(reader.ReadBytes(4)), 0),
            energyMeasureCount = BitConverter.ToInt32(ReverseEndianess(reader.ReadBytes(4)), 0),
            moveCustomizationFlags = BitConverter.ToInt32(ReverseEndianess(reader.ReadBytes(4)), 0),            
            measures = new List<float>()
        };

        //Acquires measures data from binary file using a loop
        while (reader.BaseStream.Position < reader.BaseStream.Length)
        {
            move.measures.Add(BitConverter.ToSingle(ReverseEndianess(reader.ReadBytes(4)), 0));
        }
*/