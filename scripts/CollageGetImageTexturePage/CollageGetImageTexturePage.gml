/// @func CollageGetImageTexturePage(identifier)
/// @param identifier
function CollageGetImageTexturePage(_identifier) {
	gml_pragma("forceinline");
	if (is_string(_identifier)) {
		if (!COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		
		return global.__CollageImageMap[$ _identifier].getTexturePage();	
	} 
	
	return _identifier.getTexturePage();	
}
