/// @func CollageImageLoad(identifier, subImage)
/// @param {String} identifier
/// @param {Real} subImage
/* Feather ignore once GM1042 */
function CollageImageLoad(_identifier, _subImage) {
	gml_pragma("forceinline");
	var _image;
	
	if (is_string(_identifier)) {
		if (!__COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("__COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		
		 _image =  global.__CollageImageMap[$ _identifier];
	} else {
		_image = _identifier;	
	}
	
	_image.subImagesArray[_subImage % _image.subImagesCount].texturePageStruct.__restoreFromCache();
}
