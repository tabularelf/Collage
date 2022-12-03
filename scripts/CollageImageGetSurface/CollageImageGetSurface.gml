/// @func CollageGetImageSurface(collage_image_or_name, image_index)
/// @param {Struct.__CollageImageClass, String} collage_image_or_name
/// @param {Real} image_index
/// @return {Id.Surface}
/* Feather ignore all */
function CollageGetImageSurface(_identifier, _imageIndex) {
	gml_pragma("forceinline");
	if (is_string(_identifier)) {
		if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		
		return global.__CollageImageMap[$ _identifier].GetSurface(_imageIndex);	
	} 
	
	return _identifier.GetSurface(_imageIndex);	
}