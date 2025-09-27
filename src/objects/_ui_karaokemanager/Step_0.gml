/// @description Update lyrics and timing
var video_time = _common_mediamanager.timer;

// Initialize progress to 0
phraseProgress = 0;

// Process lyrics if we have any
if (array_length(lyricTimes) > 0) {
    // Handle the last lyric
    if (lyricIndex >= array_length(lyricTimes)) {
        if (video_time >= lyricTimes[array_length(lyricTimes) - 1] + lyricCurrentDuration + (fadeOutDuration * 1000)) {
            lyricLineCurrent = "";
            lyricLineNext = "";
        }
    }
    // Normal lyric processing
    else {
        var current_lyric_time = lyricTimes[lyricIndex];
        
        // Show new lyric when it's time
        if (current_lyric_time <= video_time) {
            if (lyricIndex < array_length(lyricLines)) {
                // Update lyrics
                lyricLineCurrent = lyricLines[lyricIndex];
                lyricLineNext = (lyricIndex + 1 < array_length(lyricLines)) ? lyricLines[lyricIndex + 1] : "";
                
                // Update timing for new lyric
                lyricCurrentStart = current_lyric_time;
                
                // Get line duration from the sum of word durations
                if (lyricIndex > 0) {
                    var line_index = lyricIndex - 1;
                    var word_durations = lyricWordDurations[line_index];
                    lyricCurrentDuration = 0;
                    for (var i = 0; i < array_length(word_durations); i++) {
                        lyricCurrentDuration += word_durations[i];
                    }
                }
                
                lyricIndex++;
            }
        }
    }
    
    // Update word highlighting
    if (lyricIndex > 0) {
        var line_index = lyricIndex - 1;
        var word_starts = lyricWordStartTimes[line_index];
        var word_durations = lyricWordDurations[line_index];
        
        // Only process if we have words in the line
        if (array_length(word_starts) > 0) {
            var total_words = array_length(word_starts);
            var first_word_start = word_starts[0];
            var last_word_start = word_starts[total_words - 1];
            var last_word_duration = word_durations[total_words - 1];
            
            // Only start highlighting if we've reached the first word
            if (video_time >= first_word_start) {
                // Find current word and calculate progress
                for (var w = 0; w < total_words; w++) {
                    var word_start = word_starts[w];
                    var word_duration = word_durations[w];
                    var word_end = word_start + word_duration;
                    
                    if (video_time < word_start) {
                        // Before this word
                        phraseProgress = w / total_words;
                        break;
                    }
                    else if (video_time >= word_start && video_time < word_end) {
                        // Within this word's duration
                        var word_progress = (video_time - word_start) / word_duration;
                        phraseProgress = (w + word_progress) / total_words;
                        break;
                    }
                    else if (w == total_words - 1) {
                        // After the last word
                        phraseProgress = 1;
                    }
                }
            }
        }
    }
}

// Update word highlighting progress
if (lyricIndex > 0 && lyricIndex <= array_length(lyricLines)) {
    var line_index = lyricIndex - 1;
    var word_starts = lyricWordStartTimes[line_index];
    var word_durations = lyricWordDurations[line_index];
    var total_words = array_length(word_starts);
    
    // Only process if we've reached the first word's start time
    if (video_time >= word_starts[0]) {
        // Find which word should be highlighted
        for (var w = 0; w < total_words; w++) {
            var word_start = word_starts[w];
            var word_end = word_start + word_durations[w];
            
            if (video_time < word_start) {
                // Before this word, highlight up to previous word
                phraseProgress = w / total_words;
                currentWordIndex = w - 1;
                break;
            }
            else if (video_time >= word_start && video_time < word_end) {
                // Within this word's duration, calculate partial progress
                var word_progress = (video_time - word_start) / word_durations[w];
                phraseProgress = (w + word_progress) / total_words;
                currentWordIndex = w;
                break;
            }
            else if (w == total_words - 1) {
                // After last word's end time
                phraseProgress = 1;
                currentWordIndex = total_words - 1;
            }
        }
    }
    
    // Clamp the progress between 0 and 1
    phraseProgress = clamp(phraseProgress, 0, 1);
}
