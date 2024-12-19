/// @description High-precision timer update

// Update timer (milliseconds)
timer = floor((get_timer() - start_time) / 1000);

// Handle audio creation (UbiArt only)
if (!audioPlaying && global.publishedSongType == "ubiart") {
    if (audioOffset == 0 || timer >= audioOffset) {
        instance_create_depth(0, 0, 0, _common_audioplayer);
        audioPlaying = 1;
    }
}

// Handle video creation
if (!videoPlaying) {
    if (videoOffset == 0 || timer >= videoOffset) {
        instance_create_depth(0, 0, 0, _common_videoplayer);
        videoPlaying = 1;
    }
}