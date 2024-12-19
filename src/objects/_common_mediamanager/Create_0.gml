/// @description Handles the creation of the media objects (VideoPlayer and AudioPlayer)

// Initialize timer
game_set_speed(60, gamespeed_fps);
timer = 0;
start_time = get_timer();

videoPlaying = 0;
audioPlaying = 0;

// Handle different song types
if (global.publishedSongType == "ubiart") {
    // Gets the right start points for audio and video (as UbiArt does this kind of shit, we have too...)
    videoOffset = markerClipToStartTimeMS(abs(_common_songdata.songVideoStartTime), _common_songdata.songBeatsArray) * 10
    if (_common_songdata.songStartBeat != 0) {
        audioOffset = _common_songdata.songBeatsArray[abs(_common_songdata.songStartBeat)] / 48
    } else {
        audioOffset = 0;
    }
} else {
    videoOffset = 0;
    audioOffset = 0;
}