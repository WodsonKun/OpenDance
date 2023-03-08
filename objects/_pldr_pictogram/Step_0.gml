/// @description Handle pictogram placing
if (global.numCoach == 1) {
	if (x > 610) {
		x -= 13.85;
	}
	else if (x <= 610) {
		// Fix placing
		x = 606;
		image_alpha -= 0.45;
		
		if (image_alpha == 0) {
			
			// Destroy itself
			instance_destroy(self, true);
		}
	}
}
else if (global.numCoach >= 2) {
	if (x > 590) {
		x -= 8.665;
	}
	else if (x <= 590) {
		// Fix placing
		x = 586;
		image_alpha -= 0.45;
		
		// Destroy itself
		if (image_alpha == 0) {
			instance_destroy(self, true);
		}
	}
}