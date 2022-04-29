/// @func CollageGetImageSurface(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageSurface(_identifier, _imageIndex) {
	gml_pragma("forceinline");
	if (is_string(_identifier)) {
		if (!COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		
		return global.__CollageImageMap[$ _identifier].getSurface(_imageIndex);	
	} 
	
	return _identifier.getSurface(_imageIndex);	
}