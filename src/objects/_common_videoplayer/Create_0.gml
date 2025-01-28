// Handle different song types
if (global.publishedSongType == "ubiart") {
    if (_common_songdata.songStartBeat != 0) {
        audioOffset = _common_songdata.songBeatsArray[abs(_common_songdata.songStartBeat)] / 48
    } else {
        audioOffset = 0;
    }
    if (_common_songdata.songVideoStartTime != 0) {
        // Gets the right start points for audio and video (as UbiArt does this kind of shit, we have too...) 
        videoOffset = abs(_common_songdata.songVideoStartTime) * 100
    } else {
        videoOffset = 1;
    }
    
} else {
    videoOffset = 1;
    audioOffset = 0;
}

/// @description Loads the designated video
video_open(global.videoPath);