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

// Initialize phrase timing variables
phraseProgress = 0;
phraseCurrentStart = 0;
phraseTotalDuration = 0;

// Surface for highlighting
highlight_surf = -1;

// Empty arrays
currentLineArray = [];
lyricLines = [];
lyricLinesSep = [];
lyricTimes = [];
lyricWordStartTimes = [];  // Start time for each word in the current line
lyricWordDurations = [];   // Duration for each word in the current line
currentWordIndex = 0;      // Current word being highlighted

// Empty strings
lyricCurr = "";
lyricLineCurrent = "";
lyricLineNext = "";
highlightText = "";
lyricCurrentStart = 0;
lyricCurrentDuration = 2000;
fadeOutDuration = 0.5; // Duration in seconds for lyrics to fade out
// Add fade animation variables
highlight_fade_duration = 0.25; // Duration in seconds
highlight_fade_progress = 0;
last_highlight_len = 0; // Track changes in highlight length
char_alphas = array_create(0); // Store alpha for each character
fade_speed = 0.1;  // Speed of fade-in animation
last_highlight_count = 0;  // Track number of highlighted chars

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
    var current_word_times = [];
    var current_word_durations = [];
    
    for (i = 0; i < array_length(_common_songdata.songLyricsArray); i++) {
        var lyric = _common_songdata.songLyricsArray[i];
        
        // Add word to current line
        array_insert(currentLineArray, j, lyric.Lyrics);
        
        // Store timing for this word (add audioOffset to sync with music)
        var word_start = markerClipToStartTimeMS(lyric.StartTime, _common_songdata.songBeatsArray) + audioOffset;
        var word_duration = markerClipToDurationMS(lyric.StartTime, lyric.Duration, _common_songdata.songBeatsArray);
        array_insert(current_word_times, j, word_start);
        array_insert(current_word_durations, j, word_duration);
        j += 1;
        
        if (lyric.IsEndOfLine == 1) {
            // Build full line text
            for (lyricWord = 0; lyricWord < array_length(currentLineArray); lyricWord++) {
                lyricCurr += currentLineArray[lyricWord];
            }
            
            // Store line data
            array_insert(lyricLinesSep, k, currentLineArray);
            array_insert(lyricLines, k, lyricCurr);
            array_insert(lyricWordStartTimes, k, current_word_times);
            array_insert(lyricWordDurations, k, current_word_durations);
            array_insert(lyricTimes, k, current_word_times[0]); // Use first word's start time for line timing
            k += 1;
            
            // Reset for next line
            currentLineArray = [];
            current_word_times = [];
            current_word_durations = [];
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
    var current_word_times = [];
    var current_word_durations = [];
    
    for (i = 0; i < array_length(_common_songdata.songLyricsArray); i++) {
        var lyric = _common_songdata.songLyricsArray[i];
        
        // Add word to current line
        array_insert(currentLineArray, j, lyric.text);
        
        // Store timing for this word
        array_insert(current_word_times, j, lyric.time);
        array_insert(current_word_durations, j, lyric.duration);
        j += 1;
        
        if (lyric.isLineEnding == 1) {
            // Build full line text
            for (lyricWord = 0; lyricWord < array_length(currentLineArray); lyricWord++) {
                lyricCurr += currentLineArray[lyricWord];
            }
            
            // Store line data
            array_insert(lyricLinesSep, k, currentLineArray);
            array_insert(lyricLines, k, lyricCurr);
            array_insert(lyricWordStartTimes, k, current_word_times);
            array_insert(lyricWordDurations, k, current_word_durations);
            array_insert(lyricTimes, k, current_word_times[0]); // Use first word's start time for line timing
            k += 1;
            
            // Reset for next line
            currentLineArray = [];
            current_word_times = [];
            current_word_durations = [];
            lyricCurr = "";
            j = 0;
        }
    }
}