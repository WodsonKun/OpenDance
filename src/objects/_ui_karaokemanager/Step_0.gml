/// @description Lyric System Step Event
// Get current video position for synchronization
video_time = _common_mediamanager.timer

// Main lyric update loop - with bounds checking
if (array_length(lyricTimes) > 0) {
    // Handle the last lyric if we've reached the end
    if (lyricIndex >= array_length(lyricTimes)) {
        var last_duration = 0;
        if (global.publishedSongType == "ubiart" && _curr_phrase_ind - 1 < array_length(_common_songdata.songLyricsArray)) {
            last_duration = markerClipToDurationMS(_common_songdata.songLyricsArray[_curr_phrase_ind - 1].StartTime, _common_songdata.songLyricsArray[_curr_phrase_ind - 1].Duration, _common_songdata.songBeatsArray);
        } else if (global.publishedSongType == "bluestar" && _curr_phrase_ind - 1 < array_length(_common_songdata.songLyricsArray)) {
            last_duration = _common_songdata.songLyricsArray[_curr_phrase_ind - 1].duration;
        }
        
        // Clear the last lyric after its duration + 3 seconds
        if (video_time >= lyricTimes[array_length(lyricTimes) - 1] + last_duration + 3000) {
            lyricLineCurrent = "";
            lyricLineNext = "";
        }
    }
    // Normal lyric processing
    else if (lyricIndex < array_length(lyricTimes)) {
        // Get current lyric timing
        var current_lyric_time = lyricTimes[lyricIndex];
        
        // Get previous lyric timing and duration if available
        var prev_lyric_end_time = -1;
        if (lyricIndex > 0 && _curr_phrase_ind > 0) {
            var prev_duration = 0;
            if (global.publishedSongType == "ubiart" && _curr_phrase_ind - 1 < array_length(_common_songdata.songLyricsArray)) {
                prev_duration = markerClipToDurationMS(_common_songdata.songLyricsArray[_curr_phrase_ind - 1].StartTime, _common_songdata.songLyricsArray[_curr_phrase_ind - 1].Duration, _common_songdata.songBeatsArray);
            } else if (global.publishedSongType == "bluestar" && _curr_phrase_ind - 1 < array_length(_common_songdata.songLyricsArray)) {
                prev_duration = _common_songdata.songLyricsArray[_curr_phrase_ind - 1].duration;
            }
            prev_lyric_end_time = lyricTimes[lyricIndex - 1] + prev_duration + 3000;
        }
        
        // Clear previous lyric if enough time has passed
        if (prev_lyric_end_time != -1 && video_time >= prev_lyric_end_time) {
			lyricLineCurrent = "";
        }
        
        // Show new lyric when it's time
        if (current_lyric_time <= video_time) {
            // Update current and next lyrics
            if (lyricIndex < array_length(lyricLines)) {
                // Update to new lyric
                lyricLineCurrent = lyricLines[lyricIndex];
                
                // Safely get next lyric if available
                if (lyricIndex + 1 < array_length(lyricLines)) {
                    lyricLineNext = lyricLines[lyricIndex + 1];
                } else {
                    lyricLineNext = "";
                }
                
	            // Reset typist for smooth animation
	            typist.reset().in(0.5, 0);  // Animate in over 0.5 seconds with no delay
				
                // Move to next lyric
                lyricIndex++;
            }
        }
    }
}

// Handle different song types
if (global.publishedSongType == "ubiart") {
    while (_curr_phrase_ind < array_length(_common_songdata.songLyricsArray)) {
        phrase = _common_songdata.songLyricsArray[_curr_phrase_ind];
        phrase_end_time = markerClipToStartTimeMS(phrase.StartTime, _common_songdata.songBeatsArray) + markerClipToDurationMS(phrase.StartTime, phrase.Duration, _common_songdata.songBeatsArray);
        
        if (phrase_end_time <= video_time) {
            // Update highlight text
            if (phrase.IsEndOfLine == 0) {
                highlightText += phrase.Lyrics;
            } else {
                highlightText += phrase.Lyrics;
                // Reset highlight at end of line
                highlightText = "";
            }
            _curr_phrase_ind++;
        } else {
            // Calculate progress for smooth transition
            var progress = (video_time - markerClipToStartTimeMS(phrase.StartTime, _common_songdata.songBeatsArray)) / markerClipToDurationMS(phrase.StartTime, phrase.Duration, _common_songdata.songBeatsArray);
            progress = clamp(progress, 0, 1);
            
	        // Update typist with smooth transition
	        typist.in(markerClipToDurationMS(phrase.StartTime, phrase.Duration, _common_songdata.songBeatsArray) / 1000, 1.5);
            break;
        }
    }
} else if (global.publishedSongType == "bluestar") {
    while (_curr_phrase_ind < array_length(_common_songdata.songLyricsArray)) {
        phrase = _common_songdata.songLyricsArray[_curr_phrase_ind];
        
        if (phrase.time <= video_time) {
            // Update highlight text
            if (phrase.isLineEnding == 0) {
                highlightText += phrase.text;
            } else {
                highlightText += phrase.text;
                // Reset highlight at end of line
                highlightText = "";
            }
            _curr_phrase_ind++;
        } else {
            // Calculate progress for smooth transition
            var progress = (video_time - phrase.time) / phrase.duration;
            progress = clamp(progress, 0, 1);
			
			// Update typist with smooth transition
	        typist.in(phrase.duration / 1000, 1.5);
            break;
        }
    }
}
