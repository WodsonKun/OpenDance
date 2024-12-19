/// @description Initialize Display Handler

// Base resolution (your game's internal resolution)
base_width = 1920;
base_height = 1080;

// Window size
window_width = base_width;
window_height = base_height;

// Aspect ratio
aspect_ratio = base_width / base_height;

// Initial window setup
window_set_size(1280, 720);
surface_resize(application_surface, base_width, base_height);

// Center the window
alarm[0] = 1; // Use alarm to center window after a frame

// Display settings
display_width = display_get_width();
display_height = display_get_height();

// Fullscreen flag
is_fullscreen = false;

// Set minimum window size
window_set_min_width(640);  // Minimum width
window_set_min_height(360); // Minimum height (maintains 16:9 ratio)
