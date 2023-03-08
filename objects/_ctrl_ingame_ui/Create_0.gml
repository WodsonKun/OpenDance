/// @description Initializes Game UI
/// HideUserInterfaceClip
_gui_alpha = 0
draw_set_alpha(_gui_alpha);

/// Beat system
// Empty integers
_xsc = 1;
beatIndex = 0;

/// Lyric system
// Empty integers
_curr_phrase_ind = 0;
characters = 0;
lyricIndex = 0;
j = 0;
k = 0;
l = 0;

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

//Pictogram system
pictoCurrent = "";
pictoNext = "";
pictoIndex = 0;
pictoSlideTime = 2000;



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