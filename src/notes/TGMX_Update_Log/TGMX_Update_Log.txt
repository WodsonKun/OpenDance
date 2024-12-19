
[TweenGMX]

[v1.0.6]

- Fix for Advanced Properties when using To/From (">", "<") in a tween played more than once
  (e.g.)
	tween = TweenCreate(self, "outSine", 0, true, 0, 1, TPCol("color1>"), targetColor);
	TweenPlay(tween);
	TweenPlay(tween); // ERROR would occur here


[v1.0.5]

- Fix for inline callbacks involving built-in functions with passed arguments
	* e.g.
		TweenFire(..., "@finish", [show_message, "Done!"]);

- Added "soft" and "softer" variations for EaseBack* types
	* e.g.
		EaseOutBackSoft
		"ioBackSofter"
	

[v1.0.4]

- Fixes for recent GameMaker changes

- Fixed "rawstart" returning improper value
	e.g.
		tween = TweenFire(self, "io", 0, true, 0, 1, "x", "mouse_x", "mouse_x+100"); 
		raw_start = TweenGet("rawstart", tween); // Returns "mouse_x"

- Officially removed deprecated multi-tween "array support" for TweenIsActive(), TweenIsPlaying(), etc...
  Instead of TweenIsActive([tween1, tween2]) use the Tweens Selection convention.
  (Please read about "Tween Selection" in the Script Reference Guide)
	e.g.
		isActive = TweenIsActive({list: [tween1, tween2]});

