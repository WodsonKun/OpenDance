/// @description Initialize dance manager

// Get reference to pictogram array
pictoArray = _common_songdata.songPictoArray;
currentPictoIndex = 0;

// Screen positions for pictograms
picto_start_x = 1920 + 200;      // Start off screen
picto_target_x = 1491 - 164;     // Target x position aligned with new scale
picto_y = 1034 - 232;      // Y position

// Current pictogram instance
picto = noone;

target_width = 224;
target_height = 224;

// Timing constants (in milliseconds)
if (_common_songdata.songNumCoach == 1) {
	PICTO_SLIDE_TIME = 3000;    // How long pictogram takes to slide in
} else if (_common_songdata.songNumCoach == 2) {
	PICTO_SLIDE_TIME = 3300;    // How long pictogram takes to slide in
} else if (_common_songdata.songNumCoach == 3 || _common_songdata.songNumCoach == 4) {
	PICTO_SLIDE_TIME = 3400;    // How long pictogram takes to slide in
}
PICTO_FADE_TIME = 300;     // How long to fade out

// Easing function
function ease_in_out_quad(t) {
    return t < 0.5 ? 2 * t * t : 1 - power(-2 * t + 2, 2) / 2;
}

// Beat tracking
beatsArray = _common_songdata.songBeatsArray;
currentBeatIndex = 0;
beatPulseTime = 0;
beatPulseAmount = 0;
BEAT_PULSE_DURATION = 200;
GoldMoveIndex = 0;
ambIndex = 0;
sfxAMB = NaN;
ambpath_file = "";

// Active pictograms tracking
active_pictograms = ds_list_create();

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