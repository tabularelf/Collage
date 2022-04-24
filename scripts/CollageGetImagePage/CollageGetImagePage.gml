/// @func CollageGetImagePage(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImagePage(_spriteName, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _spriteName].getPage(_imageIndex);	
	} 
	
	return _spriteName.getPage(_imageIndex);	
}
