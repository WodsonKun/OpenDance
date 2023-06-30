/// @description Initializes the song section
// Loads LocIDs
load_locid();
coverflow_surf = -1

// Animation
minZoom = 0.1;
currentZoom = 0.1;
currentZoom1 = 0.3;
currentZoom2 = 0.5;

// Read "published.json"
publishedSongData = import_json("opendance_data\\config\\published.json", json_parse);

// Load array of songs
songsArray = publishedSongData.songs

// Define empty global arrays to store song data
global.publishedSongTitle = [];
global.publishedSongArtist = [];
publishedSongID = [];
global.publishedSongLocID = [];
publishedSongJDVersion = [];
publishedBeats = [];

// Define empty arrays to store song assets
global.publishedSongCover = [];
global.publishedSongAlbumcoach = [];
global.publishedSongLogo = [];
global.publishedSongMapBKG = [];
global.publishedSongAudioPreview = [];

// Define local variables
select_index = 0;
offset = 280;

// Loop through every song's JSON and store their basic info inside global arrays
for(songIndex = 0; songIndex < array_length_1d(songsArray); songIndex += 1)
{
	// Defines global variables to store song info
    global.publishedSongTitle[songIndex] = songsArray[songIndex].name
	global.publishedSongArtist[songIndex] = songsArray[songIndex].artist
	publishedSongID[songIndex] = songsArray[songIndex].id
	publishedSongJDVersion[songIndex] = songsArray[songIndex].jdversion
	global.publishedSongLocID[songIndex] = songsArray[songIndex].locid
	/*
	if (is_array(songsArray[songIndex].beats)) {
		publishedBeats[songIndex] = songsArray[songIndex].beats
	} else {
		publishedBeats[songIndex] = 120;
	}*/
	
	// Gets the cover file
	if (file_exists("opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_cover@2x.jpg")) {
		global.publishedSongCover[songIndex] = "opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_cover@2x.jpg";
		global.publishedSongCover[songIndex] = sprite_add(global.publishedSongCover[songIndex], 0, false, false, 0, 0);
	} else {
		global.publishedSongCover[songIndex] = _pch_cover1024;
	}

	// Gets the albumcoach file
	if (file_exists("opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_cover_albumcoach.png")) {
		global.publishedSongAlbumcoach[songIndex] = "opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_cover_albumcoach.png";
		global.publishedSongAlbumcoach[songIndex] = sprite_add(global.publishedSongAlbumcoach[songIndex], 0, false, false, 0, 0)
	}
	else {
		global.publishedSongAlbumcoach[songIndex] = _pch_coach;
	}
	
	// Gets the logo file
	if (file_exists("opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_logo.png")) {
		global.publishedSongLogo[songIndex] = "opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_logo.png";
		global.publishedSongLogo[songIndex] = sprite_add(global.publishedSongLogo[songIndex], 0, false, false, 0, 0)
	}
	else {
		global.publishedSongLogo[songIndex] = noone
	}
	
	// Gets the map_bkg file
	if (file_exists("opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_map_bkg.png")) {
		global.publishedSongMapBKG[songIndex] = "opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + string_lower(songsArray[songIndex].id) + "_map_bkg.png";
		global.publishedSongMapBKG[songIndex] = sprite_add(global.publishedSongMapBKG[songIndex], 0, false, false, 0, 0)
	}
	else {
		global.publishedSongMapBKG[songIndex] = noone
	}
	
	// Gets the audiopreview file
	if (file_exists("opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + songsArray[songIndex].id + ".ogg")) {
		global.publishedSongAudioPreview[songIndex] = audio_create_stream("opendance_data\\maps\\" + songsArray[songIndex].id + "\\" + songsArray[songIndex].id + ".ogg");
	}
	else {
		global.publishedSongAudioPreview[songIndex] = noone
	}
	
	// Masks the cover
	songMask = sprite_duplicate(_ui_msk_cover)
	songCover = sprite_duplicate(global.publishedSongCover[songIndex])
	sprite_set_alpha_from_sprite(songCover, songMask)
	global.publishedSongCover[songIndex] = songCover
	
	// Masks the map_bkg
	mapMask = sprite_duplicate(_ui_msk_mapbkg)
	songBKG = sprite_duplicate(global.publishedSongMapBKG[songIndex])
	sprite_set_alpha_from_sprite(songBKG, mapMask)
	global.publishedSongMapBKG[songIndex] = songBKG
};

// Converts locIDs to local locIDs
loc8_converter();

// Resets songIndex after doing the loop
songIndex = 0