/// @description Handle Display Updates

// Toggle fullscreen with F10
if (keyboard_check_pressed(vk_f10)) {
    is_fullscreen = !is_fullscreen;
    window_set_fullscreen(is_fullscreen);
    
    if (!is_fullscreen) {
        // Return to windowed mode at previous size
        window_set_size(window_width, window_height);
        alarm[0] = 1; // Center window
    }
}

// Handle window resize
if (!is_fullscreen) {
    if (window_width != window_get_width() || window_height != window_get_height()) {
        // Update stored window size
        window_width = window_get_width();
        window_height = window_get_height();
        
        // Calculate new size maintaining aspect ratio
        var aspect = base_width / base_height;
        var window_aspect = window_width / window_height;
        var new_width = window_width;
        var new_height = window_height;
        
        if (window_aspect > aspect) {
            new_width = window_height * aspect;
        } else {
            new_height = window_width / aspect;
        }
        
        // Update application surface
        surface_resize(application_surface, base_width, base_height);
        
        // Set viewport to maintain aspect ratio with black bars
        var viewport_x = (window_width - new_width) / 2;
        var viewport_y = (window_height - new_height) / 2;
        view_set_wport(0, window_width);
        view_set_hport(0, window_height);
        view_set_xport(0, viewport_x);
        view_set_yport(0, viewport_y);
        
        // Update camera and viewport size
        camera_set_view_size(view_camera[0], base_width, base_height);
        view_set_camera(0, view_camera[0]);
    }
}

// Update display dimensions if monitor setup changes
var new_display_width = display_get_width();
var new_display_height = display_get_height();
if (display_width != new_display_width || display_height != new_display_height) {
    display_width = new_display_width;
    display_height = new_display_height;
    
    if (is_fullscreen) {
        // Update fullscreen resolution
        window_set_fullscreen(false);
        window_set_fullscreen(true);
    }
}