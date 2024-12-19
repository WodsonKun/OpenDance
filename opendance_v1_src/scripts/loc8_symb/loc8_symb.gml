/// Button / symbol localization for OpenDance
// v1.0.0 by WodsonKun

// This script is loaded regardless of language, as these are fixed LocIDs for buttons and icons
// Controller buttons
switch (PLATFORM) {
	case ("pc"):
		loc_1000 = "\u242E"; // Enter button
		loc_1001 = "\u242F"; // Escape button
	break;
	case ("nx"):
		loc_1000 = "\u21D3"; // "A" button
		loc_1001 = "\u21D2"; // "B" button
	break;
	case ("ps"): 
		loc_1000 = "\u21E3"; // "Cross" button
		loc_1001 = "\u21E2"; // "Circle" button
	break;
	case ("xb"): 
		loc_1000 = "\u21D3"; // "A" button
		loc_1001 = "\u21D2"; // "B" button
	break;
	default:
		loc_1000 = "<VAR_ACCEPT>";
		loc_1001 = "<VAR_BACK>" 
	break;
}