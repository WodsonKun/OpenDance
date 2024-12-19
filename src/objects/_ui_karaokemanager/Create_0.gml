/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
/// Lyric system
// Empty integers
_curr_phrase_ind = 0;
lyricIndex = 0;
j = 0;
k = 0;
l = 0;
textSpeed = 1;
last_lyric_time = 0; // Track when the last lyric was shown

//scribble_font_bake_outline_and_shadow("_fnt_justdancebold_lyrics", "_fnt_testoutline", 0.2, 0.2, SCRIBBLE_OUTLINE.FOUR_DIR, 1, true, 8192);

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
typist = scribble_typist().in(0.5, 0);                   // Animate in over 0.5 seconds with no delay

// Handle different song types
if (global.publishedSongType == "ubiart") {
    // Gets the right start points for audio and video (as UbiArt does this kind of shit, we have too...)
    videoOffset = round(_common_songdata.songBeatsArray[abs(_common_songdata.songVideoStartTime)] / 48)
    if (_common_songdata.songStartBeat != 0) {
        audioOffset = round(_common_songdata.songBeatsArray[abs(_common_songdata.songStartBeat)] / 48)
    } else {
        audioOffset = 0;
    }
} else {
    videoOffset = 0;
    audioOffset = 0;
}

if (global.publishedSongType == "ubiart") {
	// Generate array lines to be used with the lyric system
	for (i = 0; i < array_length(_common_songdata.songLyricsArray); i++) {

		// Iterates stuff
		if (_common_songdata.songLyricsArray[i].IsEndOfLine == 0) {
			array_insert(currentLineArray, j, _common_songdata.songLyricsArray[i].Lyrics);
			j += 1
		}
		else if (_common_songdata.songLyricsArray[i].IsEndOfLine == 1) {
			// Adds the lastest lyric to the array
			array_insert(currentLineArray, j, _common_songdata.songLyricsArray[i].Lyrics);
			j += 1
			
			// Adds to lyricLines
			for (lyricWord = 0; lyricWord < array_length(currentLineArray); lyricWord++) {
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
	for (i = 0; i < array_length(_common_songdata.songLyricsArray); i++) {
		// Iterates stuff
		if (i == 0) {
			array_insert(lyricTimes, l, (markerClipToStartTimeMS(_common_songdata.songLyricsArray[i].StartTime, _common_songdata.songBeatsArray) + audioOffset));
			l += 1
		}
		else if (i > 0) {
			if (_common_songdata.songLyricsArray[i - 1].IsEndOfLine == 1) {
				array_insert(lyricTimes, l, (markerClipToStartTimeMS(_common_songdata.songLyricsArray[i].StartTime, _common_songdata.songBeatsArray) + audioOffset));
				l += 1
			}
		}
	}
}
else if (global.publishedSongType == "bluestar") {
	// Generate array lines to be used with the lyric system
	for (i = 0; i < array_length(_common_songdata.songLyricsArray); i++) {
		// Iterates stuff
		if (_common_songdata.songLyricsArray[i].isLineEnding == 0) {
			array_insert(currentLineArray, j, _common_songdata.songLyricsArray[i].text);
			j += 1
		}
		else if (_common_songdata.songLyricsArray[i].isLineEnding == 1) {
			// Adds the lastest lyric to the array
			array_insert(currentLineArray, j, _common_songdata.songLyricsArray[i].text);
			j += 1
		
			// Adds to lyricLines
			for (lyricWord = 0; lyricWord < array_length(currentLineArray); lyricWord++) {
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
	for (i = 0; i < array_length(_common_songdata.songLyricsArray); i++) {
		// Iterates stuff
		if (i == 0) {
			array_insert(lyricTimes, l, _common_songdata.songLyricsArray[i].time);
			l += 1
		}
		else if (i > 0) {
			if (_common_songdata.songLyricsArray[i - 1].isLineEnding == 1) {
				array_insert(lyricTimes, l, _common_songdata.songLyricsArray[i - 1].time);
				l += 1
			}
		}
	}
}