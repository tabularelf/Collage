/// @func CollageImagesNamesToArray(identifier)
/// @param identifier
/* Feather ignore once GM1042 */
function CollageImagesNamesToArray(_identifier) {
	gml_pragma("forceinline");
    if (is_string(_identifier)) {
		if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");	
		}
		
        return global.__CollageTexturePagesMap[$ _identifier].ImagesNamesToArray();
    }
    
    return _identifier.ImagesNamesToArray();
}