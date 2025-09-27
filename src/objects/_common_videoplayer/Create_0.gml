// Initialize video state
// Handle different song types
if (global.publishedSongType == "ubiart") {
    if (_common_songdata.songStartBeat != 0) {
        audioOffset = _common_songdata.songBeatsArray[abs(_common_songdata.songStartBeat)] / 48;
    } else {
        audioOffset = 0;
    }
    
    if (_common_songdata.songVideoStartTime != 0) {
        videoOffset = abs(_common_songdata.songVideoStartTime) * 700;
    } else {
        videoOffset = 0;
    }
} else {
    videoOffset = 0;
    audioOffset = 0;
}

// Initialize video
show_debug_message("Loading video: " + global.videoPath);
video_open(global.videoPath)