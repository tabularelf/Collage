/// @func CollageGetImageTexturePage(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageTexturePage(_identifier, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _identifier].getTexturePage(_imageIndex);	
	} 
	
	return _identifier.getTexturePage(_imageIndex);	
}