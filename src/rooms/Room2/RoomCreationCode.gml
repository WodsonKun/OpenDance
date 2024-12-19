global.publishedSongID = get_string("Song codename", "AboutThatBass")

publishedSongs = import_json("opendance_data/mapdata/publishedMaps.json", json_parse);
for (i = 0; i < array_length(publishedSongs.songs); i++) {
	if publishedSongs.songs[i].id == global.publishedSongID {
		global.publishedSongType = publishedSongs.songs[i].songtype
	}
}
room_goto(Room1)