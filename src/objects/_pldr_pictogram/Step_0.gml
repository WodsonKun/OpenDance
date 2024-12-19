/// @description Handle movement and timing

var actual_time = _common_mediamanager.timer;
actualnew_time = actual_time - start_time;

switch (current_state) {
    case PictoState.Entering:
        // Simple linear movement
        var progress = clamp(actualnew_time / enter_duration, 0, 1);
        x = lerp(start_x, target_x, progress);
        
        // Check if we've reached the target
        if (actual_time >= arrive_time) {
            current_state = PictoState.OnBeat;
            start_time = actual_time; // Reset timer for next state
            actualnew_time = 0;
            x = target_x; // Ensure exact position
        }
        break;
        
    case PictoState.OnBeat:
        // Wait for hold duration
        if (actualnew_time >= hold_duration) {
            current_state = PictoState.Exiting;
            start_time = actual_time; // Reset timer for fading
            actualnew_time = 0;
        }
        break;
        
    case PictoState.Exiting:
        // Calculate fade progress (0 to 1)
        var fade_progress = min(actualnew_time / exit_duration, 1);
        
        // Update alpha
        image_alpha = 1 - fade_progress;
        
        // Destroy when fully faded
        if (fade_progress >= 1) {
            instance_destroy();
        }
        break;
}