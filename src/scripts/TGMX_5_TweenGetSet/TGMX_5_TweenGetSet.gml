// Feather ignore all

/*
REQUIRED:
	TweenGet
	TweenSet
	
SAFE TO DELETE:
	TweenGroupGetTimeScale
	TweenDefaultGet
	TweenGroupSetTimeScale
	TweenDefaultSet
*/

var _; // USED TO HIDE SYNTAX WARNINGS FOR NON-FEATHER ENVIRONMENT

/// @function TweenGroupGetTimeScale( group )
/// @param {Any} group
function TweenGroupGetTimeScale(_group)
{	
	static _ = TGMX_Begin();
	
	if (!ds_map_exists(global.TGMX.GroupScales, _group))
	{	// Set a default group scale if it doesn't exist
		global.TGMX.GroupScales[? _group] = [1.0];
	}
	
	return global.TGMX.GroupScales[? _group];	
}_=TweenGroupGetTimeScale;


/// @function TweenGroupSetTimeScale( group, time_scale )
/// @param {Any} group
/// @param {Any} time_scale
function TweenGroupSetTimeScale(_group, _timescale)
{	
	static _ = TGMX_Begin();
	
	var _group_scale = global.TGMX.GroupScales[? _group];
	
	if (_group_scale == undefined)
	{
		global.TGMX.GroupScales[? _group] = [_timescale];
	}
	else
	{
		_group_scale[@ 0] = _group_scale;
	}
}_=TweenGroupSetTimeScale;


/// @function TweenDefaultGet( "data_label" )
/// @description gets the default base values for newly created tweens
/// @param {Any} "data_label"
function TweenDefaultGet(_data_label)
{	
	//	Supported Data Labels:
	//		"group" "delta" "scale" "ease" "mode" "duration" "rest" "amount" "continue_count"
	
	return TweenGet(TWEEN_DEFAULT, _data_label);
}_=TweenDefaultGet;


/// @function TweenDefaultSet( "data_label", _value, [...] )
/// @description sets the default base values for newly created tweens
/// @param {Any}		"data_label"
/// @param {Any}		value
/// @param {Any} [...]	additional label/value pairs
//	Supported Data Labels: "group" "delta" "scale" "ease" "mode" "duration" "rest" "amount" "continue_count"
function TweenDefaultSet(_label)
{	
	var _args = [];
	var i = argument_count;
	repeat(argument_count-1)
	{
		i -= 1;
		_args[i+1] = argument[i];
	}
	
	_args[0] = TWEEN_DEFAULT;
	_args[1] = _label;
	script_execute_ext(TweenSet, _args);
}_=TweenDefaultSet;


/// @function TweenGet( tween, "data_label" )
/// @description returns the data values for a tween
///	@param {Any} tween			tween id
/// @param {Any} data_label	data "label" string -- see supported labels inside function
function TweenGet(_t, _data_label) 
{	
	/*
		PLEASE NOTE THAT THIS FUNCTION RETURNS [undefined] IF THE TWEEN DOES NOT EXIST!
	    
		Supported Data Labels:
	        "group"          -- Tween group
	        "time"           -- Current time of tween in steps or seconds
	        "amount"		 -- Sets the tween's time by a relative amount between 0.0 and 1.0 
	        "scale"			 -- How fast a tween updates : Default = 1.0
	        "duration"       -- How long a tween takes to fully animate in steps or seconds
	        "ease"           -- The easing algorithm used by the tween
	        "mode"           -- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP
	        "target"         -- Target instance associated with tween
	        "delta"          -- Toggle timing between seconds(true) and steps(false)
	        "rest"			 -- Duration of time tween will "pause" before continuing play mode
			"delay"          -- Current timer of active delay
	        "delay_start"    -- The starting duration for a delay timer
	        "start"          -- Start value of the property or properties
	        "destination"    -- Destination value of the property or properties
			"rawstart"		 -- The raw value supplied to start
			"rawdest"		 -- The raw value supplied to destination
	        "property"       -- Property or properties effected by the tween
			"continue_count" -- Number of times play mode is to continue
			"caller"		 -- The environment which called the tween
        
	        e.g.
	            tween = TweenFire(self, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            duration = TweenGet(tween, "duration");
            
	    ***	WARNING *** The following labels return multiple values as an array for multi-property tweens:
        
				"start"    
				"destination"
				"property"
        
	        e.g.
	            tween = TweenFire(self, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100);
	            startValues = TweenGet(tween, "start");
	            xStart = startValues[0];
	            yStart = startValues[1];
	*/
	
	var i, _return, _iData, _data, _count, _propCount; // COULD BE GOOD TO COMMENT WHAT EACH OF THESE REFERS TO

	_t = TGMX_FetchTween(_t);
	if (_t == undefined) { return undefined; }
	
	_data_label = TGMX_StringStrip(_data_label);
	
	switch(global.TGMX.TweenDataLabelMap[? _data_label])
	{
	    case TGMX_T_PROPERTY:
			_data = _t[TGMX_T_PROPERTY_DATA_RAW];
			_count = array_length(_data) div 3;
			
			if (_count == 1)
			{
				return _data[0];
			}
			else
			{
				_return = array_create(_count);
				_iData = 0;
				i = -1;
				repeat(_count)
				{
					_return[++i] = _data[_iData];
					_iData += 3;
				}
				
				return _return;
			}
	    break;
		
	    case TGMX_T_DESTINATION: // TODO: Extend this to better handle raw data if stopped
			_data = _t[TGMX_T_PROPERTY_DATA];
			
			if (is_real(_data) || _t[TGMX_T_DELAY] > 0)
			{
				_data = _t[TGMX_T_PROPERTY_DATA_RAW];
				
				_propCount = array_length(_data) div 3;
				
				if (_propCount == 1)
				{
					return _data[2];
				}

				_return = array_create(_propCount);
				i = -1;
				_iData = 2;
				repeat(_propCount)
				{
					_return[++i] = _data[_iData];
					_iData += 3;
					
				}
					
				return _return;
			}
			
			if (_data[0] == 1)
			{
				return _data[2]+_data[3];	
			}
			else
			{
				_count = _data[0];
				_return = array_create(_count);
				_iData = 2;
				i = -1;
				repeat(_count)
				{
					_return[++i] = _data[_iData]+_data[_iData+1];
					_iData += 4;
				}
				
				return _return;
			}
	    break;
    
	    case TGMX_T_START: // TODO: Extend this to better handle raw data if stopped
			_data = _t[TGMX_T_PROPERTY_DATA];
			
			if (is_real(_data) || _t[TGMX_T_DELAY] > 0)
			{
				_data = _t[TGMX_T_PROPERTY_DATA_RAW];
				
				_propCount = array_length(_data) div 3;
				
				if (_propCount == 1)
				{
					return _data[2];
				}

				_return = array_create(_propCount);
				i = -1;
				_iData = 1;
				repeat(_propCount)
				{
					_return[++i] = _data[_iData];
					_iData += 3;	
				}
					
				return _return;
			}
			
			if (_data[0] == 1)
			{
				return _data[2];	
			}
			else
			{
				_count = _data[0];
				_return = array_create(_count);
				_iData = 2;
				i = -1;
				repeat(_count)
				{
					_return[++i] = _data[_iData];
					_iData += 4;
				}
				
				return _return;
			}
	    break;
		
		case TGMX_T_RAW_START:
			_data = _t[TGMX_T_PROPERTY_DATA_RAW];
			_propCount = array_length(_data) div 3;
				
			if (_propCount == 1)
			{
				return _data[1];
			}

			_return = array_create(_propCount);
			i = -1;
			_iData = 1;
			repeat(_propCount)
			{
				_return[++i] = _data[_iData];
				_iData += 3;	
			}
					
			return _return;
		break;
		
		case TGMX_T_RAW_DESTINATION:
			_data = _t[TGMX_T_PROPERTY_DATA_RAW];
			_propCount = array_length(_data) div 3;
				
			if (_propCount == 1)
			{
				return _data[2];
			}

			_return = array_create(_propCount);
			i = -1;
			_iData = 2;
			repeat(_propCount)
			{
				_return[++i] = _data[_iData];
				_iData += 3;
					
			}
					
			return _return;
		break;
    
	    case TGMX_T_DELAY: return _t[TGMX_T_DELAY] <= 0 ? 0 : _t[TGMX_T_DELAY]; break;
	    case TGMX_T_SCALE: return _t[TGMX_T_SCALE] * _t[TGMX_T_DIRECTION]; break;
		case TGMX_T_TIME:  return clamp(_t[TGMX_T_TIME], 0, _t[TGMX_T_DURATION]); break;
		default:		   return _t[global.TGMX.TweenDataLabelMap[? _data_label]];
	}
}


// @function TweenSet( tween[s], data_label, value, [...] )
/// @description Sets specified data values for selected tween[s]
/// @param {Any} tween{s}			tween to set
/// @param {Any} "data_label"		data "label" string -- see supported list inside function
/// @param {Any} value				value to apply to given data type
/// @param {Any} [...]				(optional) additional data_label/value pairs
function TweenSet(_t, _data_label) 
{	
	/*
	    Supported Data Labels:
	        "group"				-- Assign tween to a group
	        "time"				-- Current time of tween in steps or seconds
	        "amount"			-- Sets the tween's time by a relative amount between 0.0 and 1.0 // Change to position?
	        "scale"				-- How fast a tween updates : Default = 1.0
	        "duration"			-- How long a tween takes to fully animate in steps or seconds
	        "ease"				-- The easing algorithm used by the tween
	        "mode"				-- The play mode used by the tween (ONCE, BOUNCE, PATROL, LOOP)
	        "target"			-- Target instance associated with tween
	        "delta"				-- Toggle timing between seconds(true) and steps(false)
	        "delay"				-- Current timer of active delay
	        "delay_start"		-- The starting duration for a delay timer
	        "rest"				-- Amount of time rest before continuing -- usable for all play modes except "once" (TWEEN_MODE_ONCE)
			"start"				-- Start value of the property or properties
	        "destination"		-- Destination value of the property or properties
			"raw_start"			-- Update raw start value (before being processed ... e.g. "@+10")
			"raw_destination"	-- Update raw destination value (before being processed ... e.g. "@+10")
	        "property"			-- Property or properties effected by the tween
			"continue_count"	-- Number of times play mode is to continue
        
	        e.g.
	            tween = Tween(self, EaseLinear, 0, true, 0, 1, "x", 0, 100);
	            TweenSet(tween, "duration", 2.5);
            
	    The following labels can update multiple properties by supplying
		values in the same order the properties were first assigned:
        
	        "start"
	        "destination"
	        "property"
			"raw_start"
			"raw_destination"
        
	        e.g.
	            tween = Tween(self, EaseLinear, 0, true, 0, 1, "x", 0, 100, "y", 0, 100); // multi-property tween (x/y)
	            TweenSet(tween, "start", [mouse_x, mouse_y]); // update to x/y mouse coordinates
           
	    The keyword [undefined] can be used to leave a property value unchanged
	        e.g.
	            TweenSet(tween, "start", [undefined, mouse_y]); // update "y" but leave "x" unchanged
	*/

	_t = TGMX_FetchTween(_t);
	if (_t == undefined) return;	
	
	// HANDLE MULTI-TWEEN SETTING
	if (is_struct(_t))
	{
		switch(argument_count)
		{
			case 3:	return script_execute_ext(TGMX_TweensExecute, [_t, TweenSet, _data_label, argument[2]]);
			case 4: return script_execute_ext(TGMX_TweensExecute, [_t, TweenSet, _data_label, argument[2], argument[3]]);
			case 5: return script_execute_ext(TGMX_TweensExecute, [_t, TweenSet, _data_label, argument[2], argument[3], argument[4]]);
			case 6: return script_execute_ext(TGMX_TweensExecute, [_t, TweenSet, _data_label, argument[2], argument[3], argument[4], argument[5]]);
			case 7: return script_execute_ext(TGMX_TweensExecute, [_t, TweenSet, _data_label, argument[2], argument[3], argument[4], argument[5], argument[6]]);
			default:
				var _args = array_create(argument_count+1);
				_args[0] = _t; _args[1] = TweenSet; _args[2] = _data_label; _args[3] = argument[2];
		
				var i = 3;
				repeat(argument_count-3)
				{
					++i;
					_args[i] = argument[i-1]; 
				}
		
				return script_execute_ext(TGMX_TweensExecute, _args);
			//default end
		}
	}
	
	var _setValue, _data, _pIndex = 1;
	while(_pIndex < argument_count)
	{
		_data_label = TGMX_StringStrip(argument[_pIndex++]);
		var _index = global.TGMX.TweenDataLabelMap[? _data_label];
		
		if (_index == undefined)
		{
			if (is_string(_data_label))
			{
				if (string_length(_data_label) > 1 && global.TGMX.ShorthandTable[string_byte_at(_data_label, 1)])
				{
					_index = global.TGMX.TweenDataLabelMap[? string_copy(_data_label, 1, 1)];
					
					if (_index == TGMX_T_EASE)
					{
						_setValue = global.TGMX.ShortCodesEase[? TGMX_StringStrip(_data_label)];
						
						if (_setValue == undefined)
						{
							show_error("TweenGMX: Invalid ease type used in TweenSet()", false);	
						}
					}
					else
					if (_index == TGMX_T_MODE)
					{
						_setValue = global.TGMX.ShortCodesMode[? TGMX_StringStrip(_data_label)];
						
						if (_setValue == undefined)
						{
							show_error("TweenGMX: Invalid play mode used in TweenSet()", false);	
						}
					}
					else
					{
						_setValue = real(string_copy(_data_label, 2, 100));
					}
				}
				else
				{
					show_error("TweenGMX: Invalid label used with TweenSet() -> " + string(_data_label), false);
				}
			}
		}
		else
		{
			_setValue = argument[_pIndex++];
		}

		if (is_array(_t))
		{   
		    switch(_index)
		    {
		        case TGMX_T_SCALE:
		            _t[@ TGMX_T_SCALE] = _setValue * _t[TGMX_T_DIRECTION];
		        break;
        
				// THIS IS ON PURPOSE! DON'T WORRY!
				case TGMX_T_AMOUNT: _t[@ TGMX_T_TIME] = _setValue * _t[TGMX_T_DURATION];
		        case TGMX_T_TIME: 
		            _t[@ _index] = _setValue; // THIS IS ON PURPOSE! Maybe I should separate these two cases for better clarity
			
					if (is_struct(_t[TGMX_T_STATE]) || real(_t[TGMX_T_STATE]) >= 0 && _t[TGMX_T_DURATION] != 0)
				    {
						TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], is_struct(_t[TGMX_T_TARGET]) ? _t[TGMX_T_TARGET].ref : _t[TGMX_T_TARGET]);
				    }
		        break;
			
				case TGMX_T_EASE:
					if (typeof(_setValue) == "number")
					{									  // FUNCTION ID			     // ANIMATION CURVE
						_setValue = _setValue >= 100000 ? method(undefined, _setValue) : animcurve_get_channel(_setValue, 0);
					}
					else // "ease" string
					if (is_string(_setValue))
		    		{
						_setValue =  global.TGMX.ShortCodesEase[? TGMX_StringStrip(_setValue)];
		    		}
					else
					{
						// TODO: Update for asset ref for anim curve	
					}
		    		
		    		// Update ease data
		    		_t[@ TGMX_T_EASE] = _setValue;
			
					// Process tween right away if it is currently active and has a valid duration
					if (is_struct(_t[TGMX_T_STATE]) || real(_t[TGMX_T_STATE]) >= 0 && _t[TGMX_T_DURATION] != 0)
				    {
						TGMX_TweenProcess(_t, _t[TGMX_T_TIME], _t[TGMX_T_PROPERTY_DATA], is_struct(_t[TGMX_T_TARGET]) ? _t[TGMX_T_TARGET].ref : _t[TGMX_T_TARGET]);
				    }
				break;
         
		        case TGMX_T_DELAY:
		            if (_t[TGMX_T_DELAY] > 0)
		            {
		                _t[@ TGMX_T_DELAY] = _setValue;
						_t[@ TGMX_T_DELAY_START] = _setValue;
		            }
		        break;
        
				// TODO: Extend this to support "string" properties which also updates PROPERTY_DATA_RAW
		        case TGMX_T_START: // ...this might be redundant with if/else check
		        {
		        	if (_t[TGMX_T_STATE] != TGMX_T_STATE_DELAYED && _t[TGMX_T_STATE] != TGMX_T_STATE_STOPPED)
		        	{
						// ==== UPDATE LIVE VALUES ====
						_data = _t[TGMX_T_PROPERTY_DATA];

						// Multiple properties
						if (is_array(_setValue))
						{
							var i = -1;
							var _iData = 2;
							repeat(array_length(_setValue))
							{	// Update start
								var _newStart = _setValue[++i];
								if (_newStart != undefined)
								{	// Update change
									_data[@ _iData+1] = _data[_iData] + _data[_iData+1] - _newStart;
									// Update new start
									_data[@ _iData] = _newStart;   
								}
								_iData += 4;
							}
						}
						else // Single property
						{	// Udpate change (destination - start)
							_data[@ 3] = _data[2] + _data[3] - _setValue;
							// Update start
							_data[@ 2] = _setValue;
						}
		        	}

					// ==== UPDATE RAW VALUES ====
		        	_data = _t[TGMX_T_PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue))
					{
						var i = -1;
						var _iData = 1;
						repeat(array_length(_setValue))
						{	// Update start
							var _newStart = _setValue[++i];
							if (_newStart != undefined)
							{
								_data[@ _iData] = _newStart;
							}
							_iData += 3;
						}
					}
					else // Single property
					{	// Update start
						_data[@ 1] = _setValue;
					}
		        }
		        break;
        
	        	// TODO: Extend this to support "string" properties which also updates PROPERTY_DATA_RAW
		        case TGMX_T_DESTINATION:
		        {
		        	if (_t[TGMX_T_STATE] != TGMX_T_STATE_DELAYED && _t[TGMX_T_STATE] != TGMX_T_STATE_STOPPED)
		        	{
						// ==== UPDATE LIVE VALUES ====
						_data = _t[TGMX_T_PROPERTY_DATA];
					
						// Multiple properties
						if (is_array(_setValue)) 
						{
							var i = -1;
							var _iData = 2;
							repeat(array_length(_setValue))
							{	// Update change (destination - start)
								var _newDest = _setValue[++i];
								if (_newDest != undefined)
								{
									_data[@ _iData+1] = _newDest - _data[_iData];   
								}
								_iData += 4;
							}
						}
						else // Single property
						{	// Udpate change (destination - start)
							_data[@ 3] = _setValue - _data[2];
						}
		        	}
	
					// ==== UPDATE RAW VALUES ====
					_data = _t[TGMX_T_PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue)) 
					{
						var i = -1;
						var _iData = 2;
						repeat(array_length(_setValue))
						{	// Update raw destination
							var _newDest = _setValue[++i];
							if (_newDest != undefined)
							{
								_data[@ _iData] = _newDest;   
							}
							_iData += 3;
						}
					}
					else // Single property
					{
						_data[@ 2] = _setValue;
					}
		        }
		        break;
        
		        case TGMX_T_TARGET:
		            if (is_struct(_t[TGMX_T_TARGET]) || _t[TGMX_T_TARGET] != noone)
		            {
		            	_t[@ TGMX_T_TARGET] = (is_struct(_setValue)) ? weak_ref_create(_setValue) : _setValue.id;
				
		                if (is_struct(_t[TGMX_T_STATE]) || real(_t[TGMX_T_STATE]) >= 0)
		                {
		                    _t[@ TGMX_T_STATE] = _t[TGMX_T_TARGET]; // set active state
		                }
		            }
		        break;
			
				case TGMX_T_GROUP:
					_t[@ TGMX_T_GROUP] = _setValue;
					var _group_scale = global.TGMX.GroupScales[? _setValue];
					
					if (_group_scale == undefined)
					{
						_group_scale = [1.0];
						global.TGMX.GroupScales[? _setValue] = _group_scale;	
					}
					
					_t[@ TGMX_T_GROUP_SCALE] = _group_scale;
				break;
			
		       // prop, start, change, data ----- live
			   // prop, start, dest ---- raw
			   
		        case TGMX_T_PROPERTY:
		            _data = _t[TGMX_T_PROPERTY_DATA];
					var _dataRaw = _t[TGMX_T_PROPERTY_DATA_RAW];
		            var _argIndex = 0;
                
					if (is_array(_setValue))
					{
						_argIndex = -1;
						var _dataIndexLive = -3;
						var _dataIndexRaw = -3;
						
						repeat(array_length(_setValue))
			            {
							var _property = _setValue[++_argIndex];
							_dataIndexLive += 4;
							_dataIndexRaw += 3;
                    
			                if (_property != undefined)
			                {
			                    if (is_array(_property)) // Extended Property
			                    {   
			                        _data[@ _dataIndexLive] = _property[0]; // script
			                        _data[@ _dataIndexLive+3] = _property[1]; // data
			                    }
			                    else
								if (is_array(_data))
			                    {	// Get raw property setter script
			                        var _propRaw = global.TGMX.PropertySetters[? _property];
			                        _data[@ _dataIndexLive] = _propRaw; // script
			                        _data[@ _dataIndexLive+3] = _propRaw; // data
			                    }  
								
								// Update raw property
								_dataRaw[@ _dataIndexRaw] = _property; 
			                }
			            }
					}
					else
					{
						var _property = _setValue;
                    
			            if (is_array(_property)) // Extended Property
			            {   
			                _data[@ 1] = _property[0]; // script
			                _data[@ 4] = _property[1]; // data
			            }
			            else
						if (is_array(_data))
			            {	// Get raw property setter script
			                var _propRaw = global.TGMX.PropertySetters[? _property];
			                _data[@ 1] = _propRaw; // script
			                _data[@ 4] = _propRaw; // data
			            }  
						
						// Update raw property
						_dataRaw[@ 0] = _property; 
					}
		        break;
				
				case TGMX_T_RAW_START:
					// ==== UPDATE RAW VALUES ====
		        	_data = _t[TGMX_T_PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue))
					{
						var i = -1;
						var _iData = 1;
						repeat(array_length(_setValue))
						{	// Update start
							var _newStart = _setValue[++i];
							if (_newStart != undefined)
							{
								_data[@ _iData] = _newStart;
							}
							_iData += 3;
						}
					}
					else // Single property
					{	// Update start
						_data[@ 1] = _setValue;
					}
				break;
				
				case TGMX_T_RAW_DESTINATION:
					// ==== UPDATE RAW VALUES ====
					_data = _t[TGMX_T_PROPERTY_DATA_RAW];

					// Multiple properties
					if (is_array(_setValue)) 
					{
						var i = -1;
						var _iData = 2;
						repeat(array_length(_setValue))
						{	// Update raw destination
							var _newDest = _setValue[++i];
							if (_newDest != undefined)
							{
								_data[@ _iData] = _newDest;   
							}
							_iData += 3;
						}
					}
					else // Single property
					{
						_data[@ 2] = _setValue;
					}
				break;
		        
				// Default Setter Case
		        default: _t[@ _index] = _setValue;
		    }
		}
	}
}




