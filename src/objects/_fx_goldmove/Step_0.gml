/// @description Animates the Gold Move FX
if (!animation_complete) {
    animation_frame += animation_speed; // Increment the frame based on speed

    // Check if the animation has completed (assuming 10 frames in this example)
    if (animation_frame >= (sprite_get_number(_fx_goldeffect) - 1)) {
        animation_frame = (sprite_get_number(_fx_goldeffect) - 1); // Set to the last frame
        animation_complete = true; // Mark animation as complete
    }
    
    // Update the sprite or visual representation based on the current frame
    sprite_index = _fx_goldeffect; // Replace with your animation sprite
    image_index = animation_frame; // Set the current frame of the sprite
} else {
    instance_destroy(); // Destroy the instance after animation is complete
}