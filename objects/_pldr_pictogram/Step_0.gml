/// @description Handle pictogram placing
if (global.numCoach == 1) {
	if (x > 884) {
		x -= 13.65;
	}
	else if (x <= 884) {
		// Fix placing
		x = 880;
		image_alpha -= 0.45;
		
		if (image_alpha == 0) {
			
			// Destroy itself
			instance_destroy(self, true);
		}
	}
}
else if (global.numCoach >= 2) {
	if (x > 864) {
		x -= 8.705;
	}
	else if (x <= 864) {
		// Fix placing
		x = 860;
		image_alpha -= 0.45;
		
		// Destroy itself
		if (image_alpha == 0) {
			instance_destroy(self, true);
		}
	}
}