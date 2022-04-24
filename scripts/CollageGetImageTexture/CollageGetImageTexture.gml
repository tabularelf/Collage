/// @func CollageGetImageTexture(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageTexture(_spriteName, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _spriteName].getTexture(_imageIndex);	
	} 
	
	return _spriteName.getTexture(_imageIndex);	
}
