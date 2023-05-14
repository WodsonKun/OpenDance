/// @description Handles the danceroom logic
// ------------------------------------------------------------------------------------------------------
/// Video
// Update the video buffer
if (video_exists(v)) {
  if (video_is_playing(v)) {
    video_position = video_get_playtime(v);
    global.videoPosition = video_get_playtime(v);
    video_grab_frame_buffer(v, buffer_get_address(buff));
  } 
  else if (video_position >= video_get_duration(v)) {
	video_stop(v);
  }
}

// ------------------------------------------------------------------------------------------------------
/// Beat system
// Decrease xscale
if (beatIndex < array_length_1d(global.beatsArray)) {
	_xsc += (global.beatsArray[29] - global.beatsArray[30]) / 60000;
}
// Loop through beats
if (global.beatsArray[beatIndex] <= round(video_position * 1000)) {
	_xsc = 1;
	beatIndex += 1;
}

/// Lyrics system
// Loop through phrases in order to draw ht
for (lrcPhraseIndex = 0; lrcPhraseIndex < array_length_1d(lyricLines) - 1; lrcPhraseIndex++;) {
	// Checks if the lyric phrase times coincide with the video duration
	if (lyricTimes[lyricIndex] <= round(video_position * 1000)) {
		
		// Defines the current lyric as the phrases loop
		lyricLineCurrent = lyricLines[lyricIndex];
		
		// Checks if the next value exists
		if ((lyricIndex + 1) >= 0 && (lyricIndex + 1) < array_length_1d(lyricLines)) {
			lyricLineNext = lyricLines[lyricIndex + 1];    
		} else {
			lyricLineNext = "";
		}
		
		// Increases the loop
		lyricIndex += 1;
	}
	else {
		// Shows a debug message that the song ended
		show_debug_message("End of the song")
	}
}

// Loop through the phrases until we find the current one
while (_curr_phrase_ind < array_length_1d(global.lyricsArray)) {
	phrase = global.lyricsArray[_curr_phrase_ind]
	
	if (phrase.time <= round(video_position * 1000)) {
		if (phrase.isLineEnding == 0) {
			highlightText += phrase.text;
		}
		else {
			highlightText += phrase.text;
			highlightText = ""
		}
		_curr_phrase_ind++
	}
	else {
		break;
	}
}

/// Pictogram system
// Generate pictograms
for (pic = 0; pic < array_length_1d(global.pictoArray); pic++;) {
	if ((global.pictoArray[pictoIndex].time - 2000) <= round(video_position * 1000)) {
		pictoCurrent = global.pictoArray[pictoIndex].name
		instance_create_depth(1284, 510, 0, _pldr_pictogram)
		if (pic < (array_length_1d(global.pictoArray) - 1)) {
			pictoNext = global.pictoArray[pictoIndex + 1];
		}
		else {
			pictoNext = global.pictoArray[pictoIndex];
		}
		pictoIndex += 1
	}
}