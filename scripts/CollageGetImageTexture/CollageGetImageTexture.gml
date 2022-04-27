/// @func CollageGetImageTexture(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageTexture(_identifier, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _identifier].getTexture(_imageIndex);	
	} 
	
	return _identifier.getTexture(_imageIndex);	
}
