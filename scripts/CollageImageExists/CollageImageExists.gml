/// @func CollageImageExists(identifier)
/// @param identifier
function CollageImageExists(_identifier) {
	if (is_string(_identifier)) {
		return variable_struct_exists(global.__CollageImageMap, _identifier);	
	} 
	
	return ((instanceof(_identifier) == "__CollageImageInfo") && (variable_struct_exists(global.__CollageImageMap, _identifier.name)));
}
