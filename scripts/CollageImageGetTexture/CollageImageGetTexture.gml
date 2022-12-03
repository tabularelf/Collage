/// @func CollageGetImageTexture(collage_image_or_name, image_index)
/// @param {Struct.__CollageImageClass, String} collage_image_or_name
/// @param {Real} image_index
/// @return {Pointer.Texture}
/* Feather ignore all */
function CollageGetImageTexture(_identifier, _imageIndex) {
	gml_pragma("forceinline");
	if (is_string(_identifier)) {
		if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		
		return global.__CollageImageMap[$ _identifier].ImageGetTexture(_imageIndex);	
	} 
	
	return _identifier.ImageGetTexture(_imageIndex);	
}