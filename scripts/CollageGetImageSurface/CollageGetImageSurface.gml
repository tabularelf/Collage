/// @func CollageGetImageSurface(identifier, subimage)
/// @param {String} identifier
/// @param {Real} subimage
/* Feather ignore once GM1042 */
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