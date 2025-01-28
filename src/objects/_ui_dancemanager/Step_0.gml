/// @description Handle pictogram spawning and beats

// Handle beats
if (global.publishedSongType == "ubiart") {
	if (array_length(beatsArray) > 0 && currentBeatIndex < array_length(beatsArray)) {
	    var nextBeatTime = beatsArray[currentBeatIndex] / 48;
	    if (_common_mediamanager.timer >= nextBeatTime) {
	        beatPulseTime = _common_mediamanager.timer;
	        beatPulseAmount = 1;
	        currentBeatIndex++;
	    }
	}
} else if (global.publishedSongType == "bluestar") {
	if (array_length(beatsArray) > 0 && currentBeatIndex < array_length(beatsArray)) {
	    var nextBeatTime = beatsArray[currentBeatIndex];
	    if (_common_mediamanager.timer >= nextBeatTime) {
	        beatPulseTime = _common_mediamanager.timer;
	        beatPulseAmount = 1;
	        currentBeatIndex++;
	    }
	}
}

// Update beat pulse
if (beatPulseAmount > 0) {
    var timeSinceBeat = _common_mediamanager.timer - beatPulseTime;
    if (timeSinceBeat >= BEAT_PULSE_DURATION) {
        beatPulseAmount = 0;
    } else {
        beatPulseAmount = 1 - (timeSinceBeat / BEAT_PULSE_DURATION);
    }
}

// Clean up destroyed pictograms from tracking list
var cleaned_count = 0;
for (var i = ds_list_size(active_pictograms) - 1; i >= 0; i--) {
    var check_picto = active_pictograms[| i];
    if (!instance_exists(check_picto)) {
        ds_list_delete(active_pictograms, i);
        cleaned_count++;
    }
}

if (cleaned_count > 0) {
    show_debug_message("Cleaned up " + string(cleaned_count) + " pictograms. Active count: " + string(ds_list_size(active_pictograms)));
}

// Handle GoldEffectClip
if (global.publishedSongType == "ubiart") {
	if (array_length(_common_songdata.songGoldEffectArray) > 0 && GoldMoveIndex < array_length(_common_songdata.songGoldEffectArray)) {
        var actual_time = _common_mediamanager.timer;
		var goldMoveChargeSpawnTime = markerClipToStartTimeMS(_common_songdata.songGoldEffectArray[GoldMoveIndex].StartTime, _common_songdata.songBeatsArray) + (1000); //Animation speed (0.4) * number of frames (65) (minus 200ms of margin error)
		var goldMoveExplodeSpawnTime = markerToMS(_common_songdata.songGoldEffectArray[GoldMoveIndex].StartTime + 24, _common_songdata.songBeatsArray) + (1000)
        
        global.goldeffect_played = 0;
		if (actual_time >= goldMoveExplodeSpawnTime && global.goldeffect_played == 0) {
		    instance_create_depth(0, 0, -1, _fx_goldmove_explode);
			audio_play_sfx(_sfx_goldmove);
		    GoldMoveIndex++; // Increment only when the effect is played
		    show_debug_message("Effect triggered.");
		}
	}
}

// Handles AMBs
if (global.publishedSongType == "ubiart") {
    if (file_exists("opendance_data/mapdata/" + string_lower(global.publishedSongID) + "/cinematics/" + string_lower(global.publishedSongID) + "_mainsequence.tape.ckd")) {
        if (array_length(_common_songdata.songSoundSetClipArray) > 0 && ambIndex < array_length(_common_songdata.songSoundSetClipArray)) {
            var actual_time = _common_mediamanager.timer;
            
            // Fixes and gets the file path of the AMB ogg file
            ambpath = _common_songdata.songSoundSetClipArray[ambIndex].SoundSetPath
            ambpath = string_replace(ambpath, ".tpl", ".ogg");
            ambpath = string_replace(ambpath, "/jd5/", "/maps/");
            ambpath = string_replace(ambpath, "/jd2015/", "/maps/");
            ambpath_file = string_replace(ambpath, "world/maps/" + string_lower(global.publishedSongID) + "/audio/amb/", "");
            ambpath = "opendance_data/mapdata/" + global.publishedSongID + "/audio/amb/" + ambpath_file
            // Checks if the audio exists
            if (file_exists(ambpath)) {
                // Fixes the offsync AMB issue
                if (sign(_common_songdata.songSoundSetClipArray[ambIndex].StartTime) = -1) {
                    var ambTime = audioOffset + ((_common_songdata.songSoundSetClipArray[ambIndex].StartTime) / 53) * 1000
                }
                else if (sign(_common_songdata.songSoundSetClipArray[ambIndex].StartTime) = 1) {
                    var ambTime = audioOffset + ((_common_songdata.songSoundSetClipArray[ambIndex].StartTime) / 50.5) * 1000
                }
                
                // Plays the AMB 
                if (actual_time >= ambTime) {
                    sfxAMB = audio_create_stream(ambpath);
                    audio_play_sfx(sfxAMB);
                    ambIndex++; // Increment only when the effect is played
                    show_debug_message("AMB played: " + string(ambpath_file)); 
               }
            }
        }
        
        // Cleans the AMB from the memory
        if audio_exists(sfxAMB) && !audio_is_playing(sfxAMB) {
            audio_destroy_stream(sfxAMB);
        }
    }
}

// Handle pictogram spawning
if (global.publishedSongType == "ubiart") {
    if (array_length(pictoArray) > 0 && currentPictoIndex < array_length(pictoArray)) {
        var currentPicto = pictoArray[currentPictoIndex];
        var pictoTime = markerToMS(currentPicto.StartTime, _common_songdata.songBeatsArray);
        
        // Apply audio offset to sync with music
        pictoTime += audioOffset;
        
        // Calculate when to spawn pictogram
        var spawnTime = pictoTime - PICTO_SLIDE_TIME;
        
        // Check if it's time to spawn
        var actual_time = _common_mediamanager.timer;
        
        if (actual_time >= spawnTime) {
            show_debug_message("Spawning pictogram " + string(currentPictoIndex) + " arriving at " + string(pictoTime));
            
            picto = instance_create_depth(picto_start_x, picto_y, -3, _pldr_pictogram);
            
            // Initialize timing variables using the closest beat time
            picto.start_time = actual_time;
            picto.arrive_time = pictoTime;
            
            // Load sprite
			picto_path = currentPicto.PictoPath
            picto_path = string_replace(picto_path, ".tga", ".png"); // Checks for TGA paths and rename them to PNG paths
			picto_path = string_replace(picto_path, "/jd5/", "/maps/"); // Checks for JD5 paths and rename them to MAPS paths
			picto_path = string_replace(picto_path, "/jd2015/", "/maps/"); // Checks for JD2015 paths and rename them to MAPS paths
            picto_path = string_replace(picto_path, "world/maps/" + string_lower(global.publishedSongID) + "/timeline/pictos/", "");
			picto_path = "opendance_data/mapdata/" + global.publishedSongID + "/timeline/pictos/" + picto_path
            picto.picto_sprite = sprite_add(picto_path, 0, false, true, 0, 0);
            
            // Calculate scale to maintain aspect ratio
            if (sprite_exists(picto.picto_sprite)) {
                var picto_width = sprite_get_width(picto.picto_sprite);
                var picto_height = sprite_get_height(picto.picto_sprite);
                
                // Calculate scales for both width and height
                var scale_x = picto.target_width / picto_width;
                var scale_y = picto.target_height / picto_height;
                
                // Use the smaller scale to fit within target size while maintaining aspect ratio
                var final_scale = min(scale_x, scale_y);
                
                picto.image_xscale = scale_x;
                picto.image_yscale = scale_y;
            } else {
                show_debug_message("Failed to load sprite: " + picto_path);
            }
            
            // Add to active pictograms list
            ds_list_add(active_pictograms, picto);
            
            // Move to next pictogram
            currentPictoIndex++;
        }
    }
} else if (global.publishedSongType == "bluestar") {
    if (array_length(pictoArray) > 0 && currentPictoIndex < array_length(pictoArray)) {
        var currentPicto = pictoArray[currentPictoIndex];
        var pictoTime = currentPicto.time;
        
        // Apply audio offset to sync with music
        pictoTime += audioOffset;
        
        // Find the closest beat time for this pictogram
        var closestBeatTime = pictoTime;
        if (array_length(beatsArray) > 0) {
            var minDiff = infinity;
            for (var i = 0; i < array_length(beatsArray); i++) {
                var beatTime = beatsArray[i];
                var timeDiff = abs(beatTime - pictoTime);
                if (timeDiff < minDiff) {
                    minDiff = timeDiff;
                    closestBeatTime = beatTime;
                }
            }
        }
        
        // Calculate when to spawn pictogram
        var spawnTime = pictoTime - PICTO_SLIDE_TIME;
        
        // Check if it's time to spawn
        var actual_time = _common_mediamanager.timer;
        
        if (actual_time >= spawnTime) {
            show_debug_message("Spawning pictogram " + string(currentPictoIndex) + " arriving at " + string(closestBeatTime));
            
            picto = instance_create_depth(picto_start_x, picto_y, -3, _pldr_pictogram);
            
            // Initialize timing variables using the closest beat time
            picto.start_time = actual_time;
            picto.arrive_time = closestBeatTime;
            
            // Load sprite
            var picto_path = "opendance_data/mapdata/" + global.publishedSongID + "/timeline/pictos/" + currentPicto.name + ".png"
            
            picto.picto_sprite = sprite_add(picto_path, 0, false, true, 0, 0);
            
            // Calculate scale to maintain aspect ratio
            if (sprite_exists(picto.picto_sprite)) {
                var picto_width = sprite_get_width(picto.picto_sprite);
                var picto_height = sprite_get_height(picto.picto_sprite);
                
                // Calculate scales for both width and height
                var scale_x = picto.target_width / picto_width;
                var scale_y = picto.target_height / picto_height;
                
                // Use the smaller scale to fit within target size while maintaining aspect ratio
                var final_scale = min(scale_x, scale_y);
                
                picto.image_xscale = final_scale;
                picto.image_yscale = final_scale;
            } else {
                show_debug_message("Failed to load sprite: " + picto_path);
            }
            
            // Add to active pictograms list
            ds_list_add(active_pictograms, picto);
            
            // Move to next pictogram
            currentPictoIndex++;
        }
    }
}