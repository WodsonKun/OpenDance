// Read "published.json"
publishedSongData = import_json("opendance_data/mapdata/publishedMaps.json", json_parse);

// Define empty global arrays to store song data
publishedSongInfo = [];

// Define local variables
select_index = 0;
playlist_index = 0;
offset = 280;


// Loop through every song's JSON and store their basic info inside global arrays
for(songIndex = 0; songIndex < array_length(publishedSongData.songs); songIndex += 1) {
    
    // Creates a single array to store shit
    publishedSongInfo[songIndex] = [publishedSongData.songs[songIndex].id, publishedSongData.songs[songIndex].name,
    publishedSongData.songs[songIndex].artist, publishedSongData.songs[songIndex].jdversion,
    publishedSongData.songs[songIndex].songtype, publishedSongData.songs[songIndex].haslogo,
    publishedSongData.songs[songIndex].coaches, publishedSongData.songs[songIndex].difficulty,
    publishedSongData.songs[songIndex].effort]
    
    // Gets the cover file
	if (file_exists("opendance_data/mapdata/" + publishedSongInfo[songIndex][0] + "/menuart/" + string_lower(publishedSongInfo[songIndex][0]) + "_cover_legacy.png")) {
        
        // Loads the sprite image
        songCoverBase = sprite_add("opendance_data/mapdata/" + publishedSongInfo[songIndex][0] + "/menuart/" + string_lower(publishedSongInfo[songIndex][0]) + "_cover_legacy.png", 0, false, false, 0, 0);
        
        // Duplicates the sprites and masks it
        songCover = sprite_duplicate(songCoverBase);
        songMask = sprite_duplicate(_ui_msk_cover);
        sprite_set_alpha_from_sprite(songCover, songMask);
		
        // Pushes into the array
        array_push(publishedSongInfo[songIndex], songCover);
        
        // Deletes the duplicated sprites (to avoid memory being consumed for nothing)
        sprite_delete(songCoverBase);
        sprite_delete(songMask);
	} else {
		array_push(publishedSongInfo[songIndex], noone);
	}
    
    // Gets the map_bkg file
	if (file_exists("opendance_data/mapdata/" + publishedSongInfo[songIndex][0] + "/menuart/" + string_lower(publishedSongInfo[songIndex][0]) + "_map_bkg.png")) {
        
        // Loads the sprite image
        songMapBKGBase = sprite_add("opendance_data/mapdata/" + publishedSongInfo[songIndex][0] + "/menuart/" + string_lower(publishedSongInfo[songIndex][0]) + "_map_bkg.png", 0, false, false, 0, 0);
        
        // Duplicates the sprites and masks it
        songMapBKG = sprite_duplicate(songMapBKGBase);
        songMapMask = sprite_duplicate(_ui_msk_mapbkg);
        sprite_set_alpha_from_sprite(songMapBKG, songMapMask);
		
        // Pushes into the array
        array_push(publishedSongInfo[songIndex], songMapBKG);
        
        // Deletes the duplicated sprites (to avoid memory being consumed for nothing)
        sprite_delete(songMapBKGBase);
        sprite_delete(songMapMask);
	} else {
		array_push(publishedSongInfo[songIndex], noone);
	}
    
    // Gets the albumcoach file
	if (file_exists("opendance_data/mapdata/" + publishedSongInfo[songIndex][0] + "/menuart/" + string_lower(publishedSongInfo[songIndex][0]) + "_cover_albumcoach.png")) {
        // Pushes into the array
        array_push(publishedSongInfo[songIndex], sprite_add("opendance_data/mapdata/" + publishedSongInfo[songIndex][0] + "/menuart/" + string_lower(publishedSongInfo[songIndex][0]) + "_cover_albumcoach.png", 0, false, false, 0, 0));
	} else {
		array_push(publishedSongInfo[songIndex], noone);
	}
}