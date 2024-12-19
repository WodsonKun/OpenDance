// Ease functions
function ease_in_out_quad(t) {
    return t < 0.5 ? 2 * t * t : 1 - power(-2 * t + 2, 2) / 2;
}