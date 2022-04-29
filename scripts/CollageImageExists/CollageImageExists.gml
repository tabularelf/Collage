/// @func CollageImageExists(identifier)
/// @param identifier
function CollageImageExists(_identifier) {
	if (!COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
	}
	
	gml_pragma("forceinline");
	if (is_string(_identifier)) {
		return variable_struct_exists(global.__CollageImageMap, _identifier);		
	} 
	
	return ((instanceof(_identifier) == "__CollageImageInfo") && (variable_struct_exists(global.__CollageImageMap, _identifier.name)));
}
