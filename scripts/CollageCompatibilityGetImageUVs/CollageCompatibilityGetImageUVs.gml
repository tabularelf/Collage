/// @func CollageCompatibilityGetImageUVs(identifier, image_index)
/// @param identifier
/// @param image_index
function CollageCompatibilityGetImageUVs(_identifier, _imageIndex) {
	gml_pragma("forceinline");
    var _uvs;
    if (is_string(_identifier)) {
		if (!COLLAGE_IMAGES_ARE_PUBLIC) {
			__CollageThrow("COLLAGE_IMAGES_ARE_PUBLIC is set to false and therefore string names do not work.");
		}
		_uvs = global.__CollageImageMap[$ _identifier].getUVs(_imageIndex);
	} else {
	    _uvs =_identifier.getUVs(_imageIndex);
	}
	var _texPage = _uvs.texturePageStruct;
	var _width = _texPage.width;
	var _height = _texPage.height;
	
	return [_uvs.normLeft, _uvs.normTop, _uvs.normRight, _uvs.normBottom, _uvs.trimLeft, _uvs.trimTop, _uvs.originalWidth/_width, _uvs.originalHeight/_height];
}