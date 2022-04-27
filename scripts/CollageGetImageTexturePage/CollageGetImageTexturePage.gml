/// @func CollageGetImageTexturePage(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageTexturePage(_spriteName, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _spriteName].getTexturePage(_imageIndex);	
	} 
	
	return _spriteName.getTexturePage(_imageIndex);	
}