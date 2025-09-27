
// MSM Move Scoring System for GameMaker Language
// Adapts the Python classifier to work with your existing MSM reading code

/// @description Extract features from accelerometer signals (simplified version)
/// @param {array} signals Array of accelerometer readings with time, axisx, axisy, axisz
/// @param {real} classifier_size Expected number of features (from MSM measures)
/// @returns {array} Feature vector
function extract_features(_signals, _classifier_size) {
    if (array_length(_signals) == 0) {
        show_debug_message("WARNING: No signals provided for feature extraction");
        // Return zero array if no signals
        var _features = array_create(_classifier_size, 0.0);
        return _features;
    }
    
    // Simple implementation: calculate mean of each axis
    // For a more robust implementation, this would need to match
    // the original C# MeasuresManager feature extraction
    
    var _sum_x = 0.0;
    var _sum_y = 0.0;
    var _sum_z = 0.0;
    var _count = array_length(_signals);
    
    // Calculate averages with error checking
    for (var i = 0; i < _count; i++) {
        // Check if signal data is valid
        if (!is_real(_signals[i].axisx) || !is_real(_signals[i].axisy) || !is_real(_signals[i].axisz)) {
            show_debug_message("WARNING: Invalid accelerometer data at sample " + string(i));
            continue;
        }
        
        if (is_nan(_signals[i].axisx) || is_nan(_signals[i].axisy) || is_nan(_signals[i].axisz)) {
            show_debug_message("WARNING: NaN in accelerometer data at sample " + string(i));
            continue;
        }
        
        _sum_x += _signals[i].axisx;
        _sum_y += _signals[i].axisy;
        _sum_z += _signals[i].axisz;
    }
    
    if (_count == 0) {
        show_debug_message("ERROR: No valid accelerometer samples found");
        var _features = array_create(_classifier_size, 0.0);
        return _features;
    }
    
    var _avg_x = _sum_x / _count;
    var _avg_y = _sum_y / _count;
    var _avg_z = _sum_z / _count;
    
    // Debug the extracted features
    show_debug_message("FEATURE EXTRACTION:");
    show_debug_message("Samples processed: " + string(_count));
    show_debug_message("Average X: " + string(_avg_x));
    show_debug_message("Average Y: " + string(_avg_y));
    show_debug_message("Average Z: " + string(_avg_z));
    show_debug_message("Expected classifier size: " + string(_classifier_size));
    
    // Create feature vector
    // NOTE: This simplified version assumes 3 features (X, Y, Z averages)
    // For production, you'd need to implement the full feature extraction
    // to match the MSM classifier's expected feature count
    
    var _features;
    if (_classifier_size >= 3) {
        _features = array_create(_classifier_size, 0.0);
        _features[0] = _avg_x;
        _features[1] = _avg_y;
        _features[2] = _avg_z;
        
        // Fill remaining features with zeros or implement proper extraction
        // This would need to match your specific MSM training data
    } else {
        _features = [_avg_x, _avg_y, _avg_z];
        // Truncate if classifier expects fewer features
        array_resize(_features, _classifier_size);
    }
    
    return _features;
}

/// @description Calculate statistical distance between two vectors (simplified for MSM without variance data)
/// @param {array} player_features Player's extracted features
/// @param {array} reference_means Reference means from MSM
/// @returns {real} Euclidean distance
function calculate_statistical_distance(_player_features, _reference_means) {
    var _feature_count = min(array_length(_player_features), array_length(_reference_means));
    
    if (_feature_count == 0) {
        show_debug_message("ERROR: No features to compare!");
        return infinity;
    }
    
    show_debug_message("=== DISTANCE CALCULATION DEBUG ===");
    show_debug_message("Feature count: " + string(_feature_count));
    show_debug_message("Player features length: " + string(array_length(_player_features)));
    show_debug_message("Reference means length: " + string(array_length(_reference_means)));
    
    // Calculate Euclidean distance since MSM doesn't contain variance/covariance data
    var _sum = 0.0;
    var _valid_features = 0;
    
    for (var i = 0; i < _feature_count; i++) {
        show_debug_message("Feature " + string(i) + ": Player=" + string(_player_features[i]) + " Reference=" + string(_reference_means[i]));
        
        // Check for valid numbers
        if (is_nan(_player_features[i]) || is_nan(_reference_means[i])) {
            show_debug_message("ERROR: NaN detected at feature " + string(i));
            show_debug_message("Player feature: " + string(_player_features[i]));
            show_debug_message("Reference mean: " + string(_reference_means[i]));
            continue; // Skip this feature instead of returning infinity
        }
        
        if (!is_real(_player_features[i]) || !is_real(_reference_means[i])) {
            show_debug_message("ERROR: Non-numeric value at feature " + string(i));
            continue; // Skip this feature instead of returning infinity
        }
        
        var _diff = _player_features[i] - _reference_means[i];
        show_debug_message("Diff for feature " + string(i) + ": " + string(_diff));
        
        _sum += _diff * _diff;
        _valid_features++;
        
        show_debug_message("Running sum: " + string(_sum));
    }
    
    show_debug_message("Final sum: " + string(_sum));
    show_debug_message("Valid features used: " + string(_valid_features));
    
    // If we have no valid features, return infinity
    if (_valid_features == 0) {
        show_debug_message("ERROR: No valid features for comparison");
        return infinity;
    }
    
    // Check if sum is valid before taking square root
    if (is_nan(_sum) || _sum < 0) {
        show_debug_message("ERROR: Invalid sum for sqrt: " + string(_sum));
        return infinity;
    }
    
    var _distance = sqrt(_sum);
    
    show_debug_message("Calculated distance: " + string(_distance));
    show_debug_message("=================================");
    
    // Final NaN check
    if (is_nan(_distance)) {
        show_debug_message("ERROR: Distance calculation resulted in NaN");
        return infinity;
    }
    
    return _distance;
}

/// @description Compute move score from accelerometer data using MSM classifier
/// @param {struct} msm_data MSM data structure from read_msm_file()
/// @param {array} accel_signals Array of accelerometer readings with time, axisx, axisy, axisz
/// @param {real} start_time Start time of the movement window
/// @param {real} duration Duration of the movement window
/// @returns {struct} {distance: real, score: real} or {distance: infinity, score: 0} on error
function compute_move_score(_msm_data, _accel_signals, _start_time, _duration) {
    
    // Validate MSM data
    if (!_msm_data.is_valid || array_length(_msm_data.measures) == 0) {
        show_debug_message("Invalid MSM data for scoring");
        return {distance: infinity, score: 0.0};
    }
    
    if (_msm_data.classifier_type == "" || _msm_data.classifier_type == "None") {
        show_debug_message("No classifier loaded in MSM data");
        return {distance: infinity, score: 0.0};
    }
    
    // Filter accelerometer signals for the movement window and clamp values
    var _move_signals = [];
    var _end_time = _start_time + _duration;
    
    for (var i = 0; i < array_length(_accel_signals); i++) {
        var _signal = _accel_signals[i];
        
        if (_signal.time >= _start_time && _signal.time < _end_time) {
            // Clamp accelerometer values to [-3.4, 3.4] as in original code
            var _clamped_signal = {
                time: _signal.time,
                axisx: clamp(_signal.axisx, -3.4, 3.4),
                axisy: clamp(_signal.axisy, -3.4, 3.4),
                axisz: clamp(_signal.axisz, -3.4, 3.4)
            };
            array_push(_move_signals, _clamped_signal);
        }
    }
    
    if (array_length(_move_signals) == 0) {
        show_debug_message("No accelerometer data found in time window");
        return {distance: infinity, score: 0.0};
    }
    
    // Extract features from player's movement
    var _classifier_size = array_length(_msm_data.measures);
    var _player_features = extract_features(_move_signals, _classifier_size);
    
    // Use the MSM measures array as reference means
    // Since MSM doesn't contain variance/covariance data, we use simple Euclidean distance
    var _reference_means = _msm_data.measures;
    
    // Calculate statistical distance (simplified - only Euclidean since MSM lacks variance data)
    var _distance = calculate_statistical_distance(_player_features, _reference_means);
    
    // Map distance to percentage score
    var _score = 0.0;
    
    if (_distance <= _msm_data.low_threshold) {
        _score = 100.0;
    } else if (_distance >= _msm_data.high_threshold) {
        _score = 0.0;
    } else {
        // Linear interpolation
        var _range = _msm_data.high_threshold - _msm_data.low_threshold;
        if (_range > 0) {
            _score = 100.0 * (_msm_data.high_threshold - _distance) / _range;
        }
    }
    
    _score = clamp(_score, 0.0, 100.0);
    
    return {
        distance: _distance,
        score: _score
    };
}

