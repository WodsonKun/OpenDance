#macro as , function

/// @function foreach(array as (element, [index])
function foreach(array, func) { 
    var size = array_length(array);
    
    for (var i = 0; i < size; i++) {       
        var element = array[i];
        func(element, i);
    }
}

/// @function foreach_list(list as (element, [index])
function foreach_list(list, func) {
    var size = ds_list_size(list);
    
    for (var i = 0; i < size; i++) {
        var element = list[| i];
        func(element, i);
    }
}

/// @function foreach_map(map as (element, [key], [index])
function foreach_map(map, func) {
    var size = ds_map_size(map);
    
    var key = ds_map_find_first(map);
    
    for (var i = 0; i < size; i++) {
        var element = map[? key];
        func(element, key, i);
        
        key = ds_map_find_next(map, key);
    }
}

/// @function foreach_stack(stack as (element, [index])
function foreach_stack(stack, func) {
    var size = ds_stack_size(stack);
    
    for (var i = 0; i < size; i++) {
        var element = ds_stack_pop(stack);
        func(element, i);
    }
}

/// @function foreach_queue(queue as (element, [index])
function foreach_queue(queue, func) {
    var size = ds_queue_size(queue);
    
    for (var i = 0; i < size; i++) {
        var element = ds_queue_dequeue(queue);
        func(element, i);
    }
}

/// @function foreach_priority(priority as (element, [key], [index])
function foreach_priority(priority, func) {
    var size = ds_priority_size(priority);
    
    for (var i = 0; i < size; i++) {
        var element = ds_priority_find_max(priority);
        var key = ds_priority_find_priority(priority, element);
        func(element, key, i);
        
        ds_priority_delete_max(priority);
    }
}

/// @function foreach_struct(struct as (element, [name], [index])
function foreach_struct(struct, func) {
    var names = variable_struct_get_names(struct)
    var size = variable_struct_names_count(struct);
    
    for (var i = 0; i < size; i++) {
        var name = names[i];
        var element = variable_struct_get(struct, name);
        func(element, name, i);
    }
}