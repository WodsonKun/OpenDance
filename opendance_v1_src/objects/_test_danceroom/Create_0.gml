/// @description Loads the song JSON, parses its data and initializes the UI and video
// Stops entirely the menu audio
audio_stop_sound(_snd_menuambiance);

// Parses the JSON
mainSongData = import_json("opendance_data\\maps\\" + global.SelectedSong + "\\" + global.SelectedSong + ".json", json_parse);

// Defines global variables to store song info
global.songCodename = mainSongData.MapName
global.songName = mainSongData.Title
global.songArtist = mainSongData.Artist
global.lyricsColor = make_color_hex(mainSongData.lyricsColor)
global.numCoach = mainSongData.NumCoach
global.videoOffset = mainSongData.videoOffset
global.audioPreview = mainSongData.AudioPreview.coverflow.startbeat
global.beatsArray = mainSongData.beats
global.lyricsArray = mainSongData.lyrics
global.pictoArray = mainSongData.pictos

highlightTimer = 0;

/// UI
/// Beat system
// Empty integers
_xsc = 1;
beatIndex = 0;

/// Lyric system
// Empty integers
_curr_phrase_ind = 0;
lyricIndex = 0;
j = 0;
k = 0;
l = 0;
textSpeed = 1;

// Empty arrays
currentLineArray = [];
lyricLines = [];
lyricLinesSep = [];
lyricTimes = [];

// Empty strings
lyricCurr = "";
lyricLineCurrent = "";
lyricLineNext = "";
highlightText = "";

/// Pictogram system
// Empty integers
pictoIndex = 0;
pictoSlideTime = 2000;

// Empty strings
pictoCurrent = "";
pictoNext = "";

// Generate array lines to be used with the lyric system
for (i = 0; i < array_length_1d(global.lyricsArray); i++) {

	// Iterates stuff
	if (global.lyricsArray[i].isLineEnding == 0) {
		array_insert(currentLineArray, j, global.lyricsArray[i].text);
		j += 1
	}
	else if (global.lyricsArray[i].isLineEnding == 1) {
		// Adds the lastest lyric to the array
		array_insert(currentLineArray, j, global.lyricsArray[i].text);
		j += 1
		
		// Adds to lyricLines
		for (lyricWord = 0; lyricWord < array_length_1d(currentLineArray); lyricWord++) {
			lyricCurr += currentLineArray[lyricWord]
		}
		array_insert(lyricLinesSep, k, currentLineArray);
		array_insert(lyricLines, k, lyricCurr);
		k += 1
		
		// Resets everything
		currentLineArray = [];
		lyricCurr = "";
		j = 0;
	}
}

// Gets times and adds to the lines
for (i = 0; i < array_length_1d(global.lyricsArray); i++) {

	// Iterates stuff
	if (i == 0) {
		array_insert(lyricTimes, l, global.lyricsArray[i].time);
		l += 1
	}
	else if (i > 0) {
		if (global.lyricsArray[i - 1].isLineEnding == 1) {
			array_insert(lyricTimes, l, global.lyricsArray[i - 1].time);
			l += 1
		}
	}
}

/// Video
/// @description And so it begins
// Purely to unlock framerate and maximum performance.
application_surface_enable(false);
display_reset(0, false);
room_speed = 60;

v = -1; fname = "opendance_data\\maps\\" + global.SelectedSong + "\\" + global.SelectedSong + ".webm";
if (file_exists(fname)) {
  v = video_add(fname);
  video_play(v);
  w = video_get_width(v);
  h = video_get_height(v);

  chan = buffer_sizeof(buffer_u64); // size of one pixel
  buff = buffer_create(chan * w * h, buffer_fixed, chan);
  surf = -1; // surfaces should be created in Draw events only!
  video_position = video_get_playtime(v);
  global.videoDuration = video_get_duration(v);
  
  /*
  // a hackfix for GM's internal 'used bytes' counter:
  buffer_poke(buff, buffer_get_size(buff) - 1, buffer_u8, 0);
  // just poke 0 at the very end, so we ensure everything is allocated properly.
  // probably not needed since GMS2.3+?*/
  
}

// fixes window close button on unix-likes with kwin/kde.
if (os_type == os_linux) {
	window_set_size(window_get_width(), window_get_height());
}