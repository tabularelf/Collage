/// @func CollageGetImageUVs(identifier, subimage)
/// @param identifier
/// @param subimage
function CollageGetImageUVs(_identifier, _imageIndex) {
	if (is_string(_spriteName)) {
		return global.__CollageImageMap[$ _identifier].getUVs(_imageIndex);
	}
	
	return _identifier.getUVs(_imageIndex);
}
