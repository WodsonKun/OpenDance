// Feather ignore all

/*
	It is safe to delete any function from this script
	or to delete the whole script entirely
*/

var _; // USED FOR HIDING NON-FEATHER SYNTAX "ERRORS"

/// @function TweensIncludeDeactivated( include? )
/// @description Include tweens with deactivated targets? Used by Tweens() function. Default: false
/// @param {Any} include
function TweensIncludeDeactivated(_include)
{	
	static _ = TGMX_Begin();
	
	global.TGMX.TweensIncludeDeactivated = _include;
}

/// @function TweenCalc( tween, [amount] )
/// @description Returns a calculated value using a tweens current state
/// @param {Any} tween			tween id
/// @param {Any} [amount]		(optional) amount between 0-1 or explicit [time] passed as array -- See examples below
/// @return {Any}
function TweenCalc(_t) 
{	
	/*
	    INFO:
	        Returns a calculated value using a tweens current state.
			A real number is returned directly if only one property is tweened.
			An array of real numbers is returned if multiple properties are tweened,
			in the order they were originally supplied to the tween.
        
	    EXAMPLES:
	        // Create defined tween
	        tween = TweenFire(self, EaseInOutQuint, 0, true, 0.0, 10, "", x, mouse_x);
        
	        // Calculate value of tween at its current state
	        x = TweenCalc(tween);
			
			// Calculate a tweens "halfway" value by using an amount (0.0 - 1.0)
			midPoint = TweenCalc(tween, 0.5);
			
			// Calculate using an explicit time by passing time within an array
			value = TweenCalc(tween, [5]);
			
			// Create multi-property tween --> Get array holding values for each calculated property
			tweenXY = TweenFire(self, EaseOutQuad, 0, false, 0, 30, "", x, mouse_x, "", y, mouse_y);
			midPoints = TweenCalc(tweenXY, 0.5);
			var _x = midPoints[0];
			var _y = midPoints[1];
	*/

	static _ = SharedTweener();

	_t = TGMX_FetchTween(_t);
	if (_t == undefined) { return 0; }
	
	var _amount;
	
	if (argument_count == 1) // Return tween's current time amount
	{
		_amount = is_method(_t[TGMX_T_EASE]) ? _t[TGMX_T_EASE](_t[TGMX_T_TIME], 0, 1, _t[TGMX_T_DURATION]) 
											 : animcurve_channel_evaluate(_t[TGMX_T_EASE], _t[TGMX_T_TIME] / _t[TGMX_T_DURATION]);
	}
	else
	if (is_real(argument[1])) // Real amount (0-1)
	{
		_amount = is_method(_t[TGMX_T_EASE]) ? _t[TGMX_T_EASE](argument[1], 0, 1, 1)
											 : animcurve_channel_evaluate(_t[TGMX_T_EASE], argument[1]);
	}
	else
	if (is_array(argument[1])) // Explicit time
	{
		_amount = is_method(_t[TGMX_T_EASE]) ? _t[TGMX_T_EASE](array_get(argument[1],0), 0, 1, _t[TGMX_T_DURATION])
											 : animcurve_channel_evaluate(_t[TGMX_T_EASE], array_get(argument[1],0) / _t[TGMX_T_DURATION]);
	}

	var _data = _t[TGMX_T_PROPERTY_DATA];
	var _count = array_length(_data) div 4;

	// Handle single property case
	if (_count == 1)
	{
		return lerp(_data[2], _data[2] + _data[3], _amount);
	}
		
	// Otherwise... handle multi-property case
	var _return = array_create(_count);
	var _iReturn = -1;
	var _iStart = 2;
	var _iDest = 3;
		
	repeat(_count)
	{
		_return[++_iReturn] = lerp(_data[_iStart], _data[_iStart]+_data[_iDest], _amount);
		_iStart += 4;
		_iDest += 4;
	}
    
	return _return;
}
_= TweenCalc; // HIDE SYNTAX ERROR

/// @function TweenStep( tween[s], amount )
/// @description Steps a paused tween forward or backward by a set amount
/// @param {Any} tween[s]
/// @param {Real} amount
function TweenStep(_t, _amount=1)
{
	_t = TGMX_FetchTween(_t);
	
	if (is_array(_t))
	{
		var _sharedTweener = SharedTweener();
		var _timeScale = _sharedTweener.timeScale * _amount; // Cache time scale
		var _timeScaleDelta = _timeScale * _sharedTweener.deltaTime; // Cache time scale affected by delta time
		
	    // IF system time scale isn't "paused"
	    if (_timeScale != 0)
	    {  
	        // Process tween if target/state exists/active
			var _target = _t[TGMX_T_TARGET];
			
			if (is_struct(_target)) // STRUCT TARGET
			{
				if (!weak_ref_alive(_target)) return;
				_target = _target.ref;
			}
			else // INSTANCE TARGET
			{
				if (!instance_exists(_target)) return;
			}
			
			if (_t[TGMX_T_DELAY] <= 0)
			{			
				// Cache updated time value for tween (multiply by relevant scale types (per / global/ group)
				var _time = _t[TGMX_T_TIME] + _t[TGMX_T_SCALE] * (_t[TGMX_T_DELTA] ? _timeScaleDelta : _timeScale) * _t[TGMX_T_GROUP_SCALE][0];
				
		        // IF tween is within start/destination
		        if (_time > 0 && _time < _t[TGMX_T_DURATION])
		        {
					// Assign updated time
		            _t[@ TGMX_T_TIME] = _time;
					// Process tween
					TGMX_TweenProcess(_t, _time, _t[TGMX_T_PROPERTY_DATA], _target);
				}
		        else // Tween has reached start or destination
				{
					TGMX_TweenHasReachedBounds(_t, _target, _time, _timeScaleDelta);
				}
			}
			else
			{
				//==================================
		        // Process Delay
		        //==================================
				// Decrement delay timer
				_t[@ TGMX_T_DELAY] = _t[TGMX_T_DELAY] - abs(_t[TGMX_T_SCALE]) * (_t[TGMX_T_DELTA] ? _timeScaleDelta : _timeScale) * _t[TGMX_T_GROUP_SCALE][0];
					
		        // IF the delay timer has expired
		        if (_t[TGMX_T_DELAY] <= 0)
		        {	
					// Set time to delay overflow
					_t[@ TGMX_T_TIME] = abs(_t[TGMX_T_DELAY]);
					// Indicate that delay has been removed from delay list
		            _t[@ TGMX_T_DELAY] = 0;										
		            // Execute FINISH DELAY event
					TGMX_ExecuteEvent(_t, TWEEN_EV_FINISH_DELAY);
					// Set tween as active 
					if (_t[TGMX_T_STATE] != TGMX_T_STATE_PAUSED)
					{
						_t[@ TGMX_T_STATE] = _t[TGMX_T_TARGET];
					}
					// Process tween data
					TGMX_TweenPreprocess(_t);
		            // Update property with start value                 
					TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], _target); // TODO: Verify that overflow is working
					// Execute PLAY event callbacks
					TGMX_ExecuteEvent(_t, TWEEN_EV_PLAY);
		        }
		    }
		}
	}
	else
	if (is_struct(_t))
	{
		TGMX_TweensExecute(_t, TweenStep, _amount);	
	}	
}


/// @function TweensFetch( tweens )
/// @param {Any} tweens
/// @description Returns an array of selected tweens
function TweensFetch(_tStruct=all)
{
	var _tweens = SharedTweener().tweens;
	var _t_queue = ds_queue_create();
	var _tIndex = -1;
	
	_tStruct = TGMX_FetchTween(_tStruct);
	
	// TARGET SELECT
	static STR_Target = "target";
	if (variable_struct_exists(_tStruct, STR_Target))
	{	
		if (is_array(_tStruct.target)) // ARRAY
		{
			repeat(ds_list_size(_tweens))
			{
				_tIndex += 1;
			    var _t = _tweens[| _tIndex];
			    var _target = _t[TGMX_T_TARGET];
						
				if (TGMX_TargetExists(_target)) 
				{
					var i = -1;
					repeat(array_length(_tStruct.target))
					{
						i += 1;
						var _selectionData = _tStruct.target[i];
						
						if (_selectionData == _tStruct) 
						{ 
							_selectionData = self; 
						}
						
						if (is_struct(_target)) // STRUCT
						{
							if (is_struct(_selectionData) && _target.ref == _selectionData)
							{
								ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
							}
						}
						else // INSTANCE
						if (!is_struct(_selectionData) && instance_exists(_selectionData)) 
						{ 
							if (_target == _selectionData.id || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData))
							{
								ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
							}
						}	
					}
				}
			}
		}
		else
		if (_tStruct.target == all) // All Targets
		{	
			repeat(ds_list_size(_tweens))
			{
				_tIndex += 1;
				var _t = _tweens[| _tIndex];
	            
				if (TGMX_TargetExists(_t[TGMX_T_TARGET]))
				{
					ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
				}
			}
		}
		else // Specific Target
		{
			var _selectionData = (_tStruct == _tStruct.target) ? self : _tStruct.target;
			
			repeat(ds_list_size(_tweens))
			{
				_tIndex += 1;
				var _t = _tweens[| _tIndex];
		        var _target = _t[TGMX_T_TARGET];
	
				if (TGMX_TargetExists(_target))
				{
					if (is_struct(_target)) // STRUCT TARGET
					{
						if (_target.ref == _selectionData)
						{
							ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
						}
					}
					else // INSTANCE | OBJECT | CHILD
					{
						if (_target == _selectionData.id || _target.object_index == _selectionData || object_is_ancestor(_target.object_index, _selectionData))
						{
							ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
						}
					}
				}
			}
		}
	}
	
	// GROUP
	static STR_Group = "group";
	var _select_group = _tStruct[$ STR_Group];
	if (_select_group != undefined)
	{	
		// SINGLE
		if (is_real(_select_group))
		{
			var _tIndex = -1;
			var _selectionData = _select_group;
        
			repeat(ds_list_size(_tweens))
			{
				_tIndex += 1;
		        var _t = _tweens[| _tIndex];
		        if (_t[TGMX_T_GROUP] == _selectionData && TGMX_TargetExists(_t[TGMX_T_TARGET]))
				{
					ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
				}
		    }
		}
		else // MULTI
		{
			var _tIndex = -1;
			
			repeat(ds_list_size(_tweens))
			{
				_tIndex += 1;
		        var _t = _tweens[| _tIndex];
				var i = -1;
				repeat(array_length(_select_group))
				{	
					i += 1;
					var _selectionData = _select_group[i];
					if (_t[TGMX_T_GROUP] == _selectionData && TGMX_TargetExists(_t[TGMX_T_TARGET]))
					{
						ds_queue_enqueue(_t_queue, _t[TGMX_T_ID]);
					}
				}
		    }
		}
	}
	
	var _ret_array = array_create(ds_queue_size(_t_queue));
	
	var i = -1;
	repeat(ds_queue_size(_t_queue))
	{
		i += 1;
		_ret_array[i] = ds_queue_dequeue(_t_queue);
	}
	
	// DESTROY TEMPORARY TWEEN QUEUE
	ds_queue_destroy(_t_queue);
	// MAKE SURE TO RETURN FALSE IF WE HAVE NO TRUE CONDITION ABOVE ^^
	return _ret_array;
}_=TweensFetch;

