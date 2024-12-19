/// @description Loads the designated audio
if (global.publishedSongType == "ubiart") { // This is only needed for UbiArt routines, as BlueStar has audio included on the video
	// Creates the audio stream and plays it
	songAudio = audio_create_stream(global.audioPath)
	songAudioID = audio_play_sound(songAudio, 0, false);
}