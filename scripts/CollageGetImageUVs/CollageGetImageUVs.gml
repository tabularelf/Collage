/// @func CollageGetImageUVs(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageUVs(_spriteName, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _spriteName].getUVs(_imageIndex);
	}
	
	return _spriteName.getUVs(_imageIndex);
}
