/// @func CollageGetImageTexturePage(identifier)
/// @param identifier
/// @param image_index
/* Feather ignore once GM1042 */
function CollageGetImageTexturePage(_identifier, _imageIndex) {
	gml_pragma("forceinline");
	if (is_string(_identifier)) {
		if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		
		return global.__CollageImageMap[$ _identifier].GetTexturePage(_imageIndex);	
	} 
	
	return _identifier.GetTexturePage(_imageIndex);	
}
