/// @description Converts LocID strings to their correspondent variables
// Unfortunately, we can't directly convert strings to variables... So, we gotta do this kind of stuff
function loc8_converter() {
	for (i = 0; i < array_length_1d(global.publishedSongLocID); i++;) {
		if (global.publishedSongLocID[i] == "11627") {
			global.publishedSongLocID[i] = loc_11627;  // Guards Dance
		}
		else if (global.publishedSongLocID[i] == "12631") {
			global.publishedSongLocID[i] = loc_12631; // Extreme Version
		}
		else {
			global.publishedSongLocID[i] = loc_4294967295; // Default
		}
	}
}