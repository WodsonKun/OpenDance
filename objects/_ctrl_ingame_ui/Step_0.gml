/// @description Logic stuff (for, if, loops and everything else)

/// Beat system
// Decrease xscale
if (beatIndex < array_length_1d(global.beatsArray)) {
	_xsc += (global.beatsArray[29] - global.beatsArray[30]) / 10000;
}
// Loop through beats
if (global.beatsArray[beatIndex] <= round(global.videoPosition * 1000)) {
	_xsc = 1;
	beatIndex += 1
}

/// Lyrics system
// Draw phrases
for (idx = 0; idx < array_length_1d(lyricLines); idx++;) {
	if (lyricTimes[lyricIndex] <= round(global.videoPosition * 1000)) {
		lyricLineCurrent = lyricLines[lyricIndex]
		if (idx < array_length_1d(lyricLines)) {
			lyricLineNext = lyricLines[lyricIndex + 1];
		}
		lyricIndex += 1
	}
}

// Loop through the phrases until we find the current one
while (_curr_phrase_ind < array_length_1d(global.lyricsArray)) {
	phrase = global.lyricsArray[_curr_phrase_ind]
	
	if (phrase.time <= round(global.videoPosition * 1000)) {
		if (phrase.isLineEnding == 0) {
			while (characters < string_length(phrase.text)) { 
				characters += phrase.duration / 1000
			}
			highlightText += string_copy(phrase.text, 0, characters);
		}
		else {
			while (characters < string_length(phrase.text)) { 
				characters += phrase.duration / 1000
			}
			highlightText += string_copy(phrase.text, 0, characters);
			highlightText = ""
		}
		_curr_phrase_ind++
	}
	else {
		break;
	}
}

/// Pictogram system
for (pic = 0; pic < array_length_1d(global.pictoArray); pic++;) {
	if ((global.pictoArray[pictoIndex].time - 2000) <= round(global.videoPosition * 1000)) {
		pictoCurrent = global.pictoArray[pictoIndex].name
		instance_create_depth(870, 340, 0, _pldr_pictogram)
		if (pic < array_length_1d(global.pictoArray)) {
			pictoNext = global.pictoArray[pictoIndex + 1];
		}
		pictoIndex += 1
	}
}

/// HideUserInterfaceClip
_gui_alpha += (global.videoOffset / 10000);
if (_gui_alpha == 1) {
	_gui_alpha = 1;
}
draw_set_alpha(_gui_alpha);