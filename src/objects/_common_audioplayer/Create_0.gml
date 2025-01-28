/// @description Loads the designated audio
// Creates the audio stream and plays it
songAudio = audio_create_stream(global.audioPath)
songAudioID = audio_play_sound(songAudio, 0, false);