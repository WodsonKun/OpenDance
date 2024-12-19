// feather ignore all
// feather disable all

/// @function str(stringKey, [data])
/// @description Polyglot helper function. 
/// Looks up the localized string value of stringKey for polyglot's current locale
/// and interpolates additional data, if available
/// @param {String} stringKey The JSON path of the string whose localized value to fetch
/// @param {Struct} data Optional struct of keys and values to interpolate into the final localized string
/// @returns {String} The localized string, interpolated with provided data
function str(stringKey, data = {}) {
	if (!instance_exists(ext_polyglot)) {
		instance_create_depth(0, 0, 0, ext_polyglot);
	}
	return ext_polyglot._string_lookup(stringKey, data);
}

/// @function current_locale()
/// @description Polyglot helper function. Returns the currently set locale 
/// @returns {String} The currently set locale
function current_locale() {
	if (!instance_exists(ext_polyglot)) {
		instance_create_depth(0, 0, 0, ext_polyglot);
	}
	return ext_polyglot.getLocale();
}

/// @function set_locale(_locale)
/// @param {String} _locale The new locale to set
function set_locale(_locale) {
	if (!instance_exists(ext_polyglot)) {
		instance_create_depth(0, 0, 0, ext_polyglot);
	}
	ext_polyglot.setLocale(_locale);
}