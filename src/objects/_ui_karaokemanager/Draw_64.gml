/// @description Draw lyrics
draw_text_outlined(48, room_height/1.115, c_black, 0.4, _fnt_justdancebold_lyrics, c_white, lyricLineCurrent);
draw_text_outlined(48, room_height/1.07, c_black, 0.4, _fnt_justdancebold_lyrics, c_white, lyricLineNext);
scribble(lyricLineCurrent).starting_format("_fnt_justdancebold_lyrics", _common_songdata.songLyricsColor).draw(48, room_height/1.115, typist);