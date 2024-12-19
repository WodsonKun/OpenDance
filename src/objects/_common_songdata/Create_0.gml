/// @description Handles all the necessary in-game data of the songs
/// Handles files from the UbiArt Framework® (Just Dance® 2014 to Just Dance® 2022)
if (global.publishedSongType == "ubiart") {
	// Loads the songdesc
	ubiartSongdesc = import_json("opendance_data/mapdata/" + string_lower(global.publishedSongID) + "/songdesc.tpl.ckd", json_parse);
	songCodename = ubiartSongdesc.COMPONENTS[0].MapName
	songName = ubiartSongdesc.COMPONENTS[0].Title
	songArtist = ubiartSongdesc.COMPONENTS[0].Artist
	songNumCoach = ubiartSongdesc.COMPONENTS[0].NumCoach
	songLyricsColor = make_color_rgb(ubiartSongdesc.COMPONENTS[0].DefaultColors.lyrics[1] * 255, ubiartSongdesc.COMPONENTS[0].DefaultColors.lyrics[2] * 255, ubiartSongdesc.COMPONENTS[0].DefaultColors.lyrics[3] * 255)
	
	// Loads the musictrack
	ubiartMusictrack = import_json("opendance_data/mapdata/" + string_lower(global.publishedSongID) + "/audio/" + string_lower(global.publishedSongID) + "_musictrack.tpl.ckd", json_parse);
	songBeatsArray = ubiartMusictrack.COMPONENTS[0].trackData.structure.markers
	songAudioPreview = ubiartMusictrack.COMPONENTS[0].trackData.structure.previewEntry
	songVideoStartTime = ubiartMusictrack.COMPONENTS[0].trackData.structure.videoStartTime
	songStartBeat = ubiartMusictrack.COMPONENTS[0].trackData.structure.startBeat
	
	// Loads the KTAPE
	ubiartKaraokeTape =  import_json("opendance_data/mapdata/" + string_lower(global.publishedSongID) + "/timeline/" + string_lower(global.publishedSongID) + "_tml_karaoke.ktape.ckd", json_parse);
	songLyricsArray = ubiartKaraokeTape.Clips
	
	// Loads the DTAPE
	ubiartDanceTape = import_json("opendance_data/mapdata/" + string_lower(global.publishedSongID) + "/timeline/" + string_lower(global.publishedSongID) + "_tml_dance.dtape.ckd", json_parse);
	
	// Creates the arrays to store shit
	songPictoArray = [];
	songMoves0Array = [];
	songMoves1Array = [];
	songMoves2Array = [];
	songMoves3Array = [];
	songGoldEffectArray = [];
	
	// UbiArt stores EVERY clip together, so i gotta loop and iterate only PictogramClips first
	for (var ClipIndex = 0; ClipIndex < array_length(ubiartDanceTape.Clips); ClipIndex++) {
		if (ubiartDanceTape.Clips[ClipIndex].__class == "PictogramClip") {
			array_push(songPictoArray, ubiartDanceTape.Clips[ClipIndex]) // Adds only PictogramClips to the array
		}
		else if (ubiartDanceTape.Clips[ClipIndex].__class == "MotionClip") {
			if (ubiartDanceTape.Clips[ClipIndex].MoveType == 0) {
				if (ubiartDanceTape.Clips[ClipIndex].CoachId == 0) {
					array_push(songMoves0Array, ubiartDanceTape.Clips[ClipIndex]) // Inserts Moves0 inside of the array
				}
				else if (ubiartDanceTape.Clips[ClipIndex].CoachId == 1) {
					array_push(songMoves1Array, ubiartDanceTape.Clips[ClipIndex]) // Inserts Moves1 inside of the array
				}
				else if (ubiartDanceTape.Clips[ClipIndex].CoachId == 2) {
					array_push(songMoves2Array, ubiartDanceTape.Clips[ClipIndex]) // Inserts Moves2 inside of the array
				}
				else if (ubiartDanceTape.Clips[ClipIndex].CoachId == 3) {
					array_push(songMoves3Array, ubiartDanceTape.Clips[ClipIndex]) // Inserts Moves3 inside of the array
				}
			}
		}
		
		else if (ubiartDanceTape.Clips[ClipIndex].__class == "GoldEffectClip") {
			array_push(songGoldEffectArray, ubiartDanceTape.Clips[ClipIndex]) // Inserts the whole GoldEffectClip inside of the array
		}
	}
	
	/// Defines video path
	global.videoPath = "opendance_data/mapdata/" + global.publishedSongID + "/videoscoach/" + string_lower(global.publishedSongID) + ".webm"
	global.audioPath = "opendance_data/mapdata/" + global.publishedSongID + "/audio/" + string_lower(global.publishedSongID) + ".ogg"
	
} /// Handles files from the BlueStar Engine® (Just Dance® Now)
else if (global.publishedSongType == "bluestar") {
	// Loads the songdesc
	bluestarJSON = import_json("opendance_data/mapdata/" + string_lower(global.publishedSongID) + "/" + string_lower(global.publishedSongID) + ".json", json_parse);
	
	// Defines variables to store song info
	songCodename = bluestarJSON.MapName
	songName = bluestarJSON.Title
	songArtist = bluestarJSON.Artist
	songLyricsColor = make_color_hex(bluestarJSON.lyricsColor)
	songNumCoach = bluestarJSON.NumCoach
	songAudioPreview = bluestarJSON.AudioPreview.coverflow.startbeat
	songBeatsArray = bluestarJSON.beats
	songLyricsArray = bluestarJSON.lyrics
	songPictoArray = bluestarJSON.pictos
	
	/// Defines video path
	global.videoPath = "opendance_data/mapdata/" + global.publishedSongID + "/videoscoach/" + string_lower(global.publishedSongID) + ".mp4"
}

/// Creates the media manager instance
// Pre-loads and masks the sprite
instance_create_depth(0, 0, 0, _common_mediamanager);
instance_create_depth(0, 0, -2, _ui_karaokemanager);
instance_create_depth(0, 0, -2, _ui_dancemanager);
window_set_caption("OpenDance | " + songName + " by " + songArtist)