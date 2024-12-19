/// @description Loads the song JSON and parses its data
// Parses the JSON
mainSongData = import_json(global.SelectedSong + "\\" + global.SelectedSong + ".json", json_parse);

// Defines global variables to store song info
global.songCodename = mainSongData.MapName
global.songName = mainSongData.Title
global.songArtist = mainSongData.Artist
global.lyricsColor = make_color_hex(mainSongData.lyricsColor)
global.numCoach = mainSongData.NumCoach
global.videoOffset = mainSongData.videoOffset
global.audioPreview = mainSongData.AudioPreview.coverflow.startbeat
global.beatsArray = mainSongData.beats
global.lyricsArray = mainSongData.lyrics
global.pictoArray = mainSongData.pictos