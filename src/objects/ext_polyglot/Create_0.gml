// feather ignore all
// feather disable all

/// @description Initalize Polyglot
_currLocale = defaultLocale;
_stringData = {};

_undef = "ERROR: NO LOCALIZED STRING";

// If another instance of polyglot already exists, destroy ourself
if (instance_number(object_index) > 1) {
	instance_destroy();
}

/// @function setLocale(locale)
/// @param locale The new locale to set
/// @description Changes the current locale
function setLocale(locale) {
	_currLocale = locale;
	_loadStringData();
}

/// @function getLocale()
/// @returns {String} the current locale
function getLocale() {
	return _currLocale;
}

// Internal function, reads the current locale's JSON data file into working memory
function _loadStringData() {
	var langFile = file_text_open_read("opendance_data/localisationdata/" + _currLocale + ".json");
	if (langFile != -1) {
		var data = "";
		while (!file_text_eof(langFile)) {
		    data += file_text_read_string(langFile);
		    file_text_readln(langFile);
		}
		file_text_close(langFile);
		
		_stringData = json_parse(data);
	} else {
		throw "Language file: " + "opendance_data/localisationdata//" + _currLocale + ".json could not be read or does not exist";
	}
}

// Internal function, looks up a localized string by its key and uses the interpolation data if any
function _string_lookup(stringKey, data = {}) {
	// Split our string key on dots, to try and follow the JSON structure down
	var keyPathParts = self._string_split(stringKey, ".");
	if (array_length(keyPathParts) == 0) throw "Error: Invalid string lookup key";
	
	// iterate down our key path & JSON data structure to find the deepest level
	var workStruct = _stringData;
	while (array_length(keyPathParts) > 1) {
		// "pop" the first level of the key path
		var sectionKey = keyPathParts[0];
		array_delete(keyPathParts, 0, 1);
		// try to dive deeper in the work struct
		if (!variable_struct_exists(workStruct, sectionKey)) return _undef;
		var nextLevel = variable_struct_get(workStruct, sectionKey);
		if (!is_struct(nextLevel)) return _undef;
		workStruct = nextLevel;
	}
	
	// Now our work struct should be at it's deepest point,
	// and our remaining key path part should be in this struct with our localized string
	var finalString = _undef;
	if (!variable_struct_exists(workStruct, keyPathParts[0])) {
		// If there is not a lookup for our exact key, it may be a pluralizable string
		// if we have interpolation data named "count", check for our pluralized keys instead
		if (variable_struct_exists(data, "count")) {
			var count = variable_struct_get(data, "count");
			if (is_numeric(count)) {
				var zeroString = keyPathParts[0] + "__zero";
				var oneString = keyPathParts[0] + "__one";
				var pluralString = keyPathParts[0] + "__plural";
				
				if (count == 0) {
					if (variable_struct_exists(workStruct, zeroString)) {
						finalString = variable_struct_get(workStruct, zeroString);
					} else if (variable_struct_exists(workStruct, pluralString)) {
						// The zero case can just use the plural string if no special zero string is specified
						finalString = variable_struct_get(workStruct, pluralString);
					}
				} else if (count == 1 && variable_struct_exists(workStruct, oneString)) {
					finalString = variable_struct_get(workStruct, oneString);
				} else if (variable_struct_exists(workStruct, pluralString)) {
					finalString = variable_struct_get(workStruct, pluralString);
				}
			}
		}
	} else {
		// The lookup key is found exactly as-is in our file so just grab its value
		finalString = variable_struct_get(workStruct,  keyPathParts[0]);
	}
	if (!is_string(finalString)) return _undef;
	
	// If we have any data to interpolate, do it
	var dataKeys = variable_struct_get_names(data);
	for (var i = 0; i < array_length(dataKeys); i++) {
		var key = dataKeys[i];
		var value = variable_struct_get(data, key);
		
		finalString = string_replace_all(finalString, "{"+key+"}", value);
	}
	
	// Only perform nesting if string contains any str()
	if (string_pos("str(", finalString) != 0) {
		var nestingKey = "";
		var parsingToken = false;
		var replacements = [];
		// Find any nested tokens, of the form "str(nestedKey)"
		for (var i = 0; i < string_length(finalString); i++) {
			if (!parsingToken) {
				// GameMaker string functions are 1-indexed, so add 1 to i...
				var next4 = string_copy(finalString, i + 1, 4);
				if (next4 == "str(") {
					parsingToken = true;
					i += 3;
				}
			} else {
				if (string_char_at(finalString, i + 1) == ")") {
					// call ourselves recursively to look up the nested string key
					var nested = _string_lookup(nestingKey, data);
					array_push(replacements, {_key: "str("+nestingKey+")", _value: nested});
					nestingKey = "";
					parsingToken = false;
				} else {
					nestingKey += string_char_at(finalString, i + 1);
				}
			}
		}
		// Replace any nested tokens found with their looked-up values
		for (var i = 0; i < array_length(replacements); i++) {
			var replacement = replacements[i];
			finalString = string_replace(finalString, replacement._key, replacement._value);
		}
	}
		
	return finalString;
}

// Graciously borrowed from here: https://www.reddit.com/r/gamemaker/comments/3zxota/splitting_strings/
function _string_split(_input, _delimiter) {
	var slot = 0;
	var splits = []; //array to hold all splits
	var str2 = ""; //var to hold the current split we're working on building

	for (var i = 1; i < (string_length(_input) + 1); i++) {
	    var currStr = string_char_at(_input, i);
	    if (currStr == _delimiter) {
			if (str2 != "") { // Make sure we don't include the _delimiter
		        splits[slot] = str2; //add this split to the array of all splits
		        slot++;
			}
	        str2 = "";
	    } else {
	        str2 = str2 + currStr;
	        splits[slot] = str2;
	    }
	}
	// If we ended on our delimiter character, include an empty string as the final split
	if (str2 == "") {
		splits[slot] = str2;
	}

	return splits;
}



// Load our default locale's language data
self._loadStringData();